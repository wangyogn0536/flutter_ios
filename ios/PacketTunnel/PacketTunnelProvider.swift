//
//  PacketTunnelProvider.swift
//  PacketTunnel
//
//  Created by noo6 on 2024/7/13.
//

import NetworkExtension
import ClashKit
import Tun2SocksKit
import Yaml

class PacketTunnelProvider: NEPacketTunnelProvider {
    private var trafficTotalUp: Int64 = 0
    private var trafficTotalDown: Int64 = 0
    private var trafficUp: Int64 = 0
    private var trafficDown: Int64 = 0
    private var appliedCfg: String? = nil
    private var vpnIP: String? = nil
    
    private var userDefaults: UserDefaults? = nil
    
    private lazy var client = AppClashClient { trafficUp, trafficDown in
        self.trafficTotalUp += trafficUp
        self.trafficTotalDown += trafficDown
        self.trafficUp = trafficUp
        self.trafficDown = trafficDown
    }
    
    override func startTunnel(options: [String : NSObject]?) async throws {
        let exIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
        let identifier = exIdentifier.replacingOccurrences(of: ".PacketTunnel", with: "")
        let suiteName = "group.\(identifier)"
        self.userDefaults = UserDefaults(suiteName: suiteName)!
        
        let allowStartFromIOSSettings = userDefaults!.bool(forKey: "clash_flt_allowStartFromIOSSettings")
        
        let startFromIOSSettings = (options?["startFromApp"] as? Bool) != true
        if(startFromIOSSettings && !allowStartFromIOSSettings){
            throw MyError.runtimeError("Preventing tunnel start, allowStartFromIOSSettings is false")
        }
        let isSetup = setupClash()
        if (!isSetup) {
            throw MyError.runtimeError("Clash Setup failed")
        }
        let generalJson = String(data: ClashKit.ClashGetConfigGeneral()!, encoding: .utf8)
        let general = jsonToDictionary(generalJson)
        osLog("Clash started with config: \(String(describing: (generalJson)))")
        let port = general?["port"] as? Int ?? 7890
        let socksPort = general?["socks-port"] as? Int ?? 7891
        let host = "127.0.0.1"
        try await self.setTunnelNetworkSettings(initTunnelSettings(proxyHost: host, proxyPort: port))
        
        // start TUN
//        Task.init {
//            let tunConfigFile = saveTunnelConfigToFile(socksPort: socksPort)
//            do {
//                let tunConfig = try String(contentsOf: tunConfigFile, encoding: .utf8)
//                osLog("tunConfig: \(tunConfig)")
//            }catch{
//                fatalError("cannot read tunConfigFile")
//            }
//        }
        // 启动 TUN 并 Socks5Tunnel
        Task.init {
            let tunConfigFile = saveTunnelConfigToFile(socksPort: socksPort)
            do {
                let tunConfig = try String(contentsOf: tunConfigFile, encoding: .utf8)
                osLog("tunConfig: \(tunConfig)")
            } catch {
                fatalError("cannot read tunConfigFile")
            }
            
            _ = Socks5Tunnel.run(withConfig: Socks5Tunnel.Config.file(path: tunConfigFile))
            
            // 保存当前 VPN IP（手动设置为已知 VPN 配置的地址）
            let savedIP = vpnIP ?? "" // 这里使用你启动时配置的 VPN IP
            self.userDefaults?.set(savedIP, forKey: "lastKnownVpnIP")
            self.userDefaults?.synchronize()
            
            // ✅ 长期稳定心跳 + 自动重连（基于保存的 VPN 配置地址）
            Task.detached { [weak self] in
                guard let self = self else { return }
                while true {
                    try? await Task.sleep(nanoseconds: 300_000_000_000) // 300秒
                    // 直接比较当前 VPN 配置的地址（或外部已知 VPN IP），不依赖 Socks5Tunnel.stats
                    let currentConfiguredIP = self.vpnIP ?? ""
                    let savedIP = self.userDefaults?.string(forKey: "lastKnownVpnIP") ?? ""
                    if currentConfiguredIP != savedIP {
                        osLog("VPN 配置地址变化，自动重连...")
                        let tunConfigFile = saveTunnelConfigToFile(socksPort: socksPort)
                        _ = Socks5Tunnel.run(withConfig: Socks5Tunnel.Config.file(path: tunConfigFile))
                        // 更新保存的 VPN IP
                        self.userDefaults?.set(currentConfiguredIP, forKey: "lastKnownVpnIP")
                        self.userDefaults?.synchronize()
                    }
                }
            }
        }
    }
    
    override func stopTunnel(with reason: NEProviderStopReason) async {
        Socks5Tunnel.quit()
    }
    
    override func handleAppMessage(_ messageData: Data) async -> Data? {
        let message = String(data: messageData, encoding: .utf8)
        switch(message) {
        case "notifyConfigChanged":
            _ = setupClash()
            break
        case "queryTrafficNow":
            return "\(trafficUp),\(trafficDown)".data(using: .utf8)
        case "queryTrafficTotal":
            return "\(trafficTotalUp),\(trafficTotalDown)".data(using: .utf8)
        default:
            break
        }
        return nil
    }
    
    private func setupClash() -> Bool {
        let userDefaults = self.userDefaults!
        let clashHome = userDefaults.string(forKey: "clash_flt_clashHome")
        let clashHomeUrl = resolvePath(clashHome, isDir: true)
        let profilePath = userDefaults.string(forKey: "clash_flt_profilePath")
        let profileUrl = resolvePath(profilePath, isDir: false)
        let countryDBPath = userDefaults.string(forKey: "clash_flt_countryDBPath")
        let countryDBUrl = resolvePath(countryDBPath, isDir: false)
        let groupName = userDefaults.string(forKey: "clash_flt_groupName")
        let proxyName = userDefaults.string(forKey: "clash_flt_proxyName")
        osLog("setup with clashHome: \(clashHomeUrl?.path ?? ""), profilePath: \(profileUrl?.path ?? ""), countryDBPath: \(countryDBUrl?.path ?? ""), groupName: \(groupName ?? ""), proxyName: \(proxyName ?? "")")
        
        if(clashHomeUrl == nil ||
           profileUrl == nil ||
           countryDBUrl == nil ||
           groupName == nil ||
           proxyName == nil
        ) {
            osLog("\(String(describing: clashHomeUrl)), \(String(describing: profileUrl)), \(String(describing: countryDBUrl)), \(String(describing: groupName)), \(String(describing: proxyName))")
            return false
        }
        let cacheDBUrl = clashHomeUrl!.appendingPathComponent("cache.db")
        FileManager.default.createFile(atPath: cacheDBUrl.path, contents: nil)
        let fileExists = FileManager.default.fileExists(atPath: profileUrl!.path)
        osLog("profileUrl: \(profileUrl!), fileExists: \(fileExists)")
        
        let config = try? String(contentsOfFile: profilePath!)
        osLog("config: \(config ?? "")")
        if(config == nil) {
            return false
        }
        let configOverride = """
        \(config!)
        allow-lan: true
        ipv6: true
        """
        if (appliedCfg != configOverride) {
            osLog("config changed, calling ClashKit.ClashSetup.")
            ClashKit.ClashSetup(clashHomeUrl!.path, configOverride, client)
            appliedCfg = configOverride
            do {
                let yaml = try Yaml.load(configOverride)
                let proxiesdic = yaml["proxies"].array?.first
                vpnIP = proxiesdic?["server"].string
            } catch {
                print("Error parsing YAML: \(error)")
            }
        } else {
            osLog("config no changes, skip ClashKit.ClashSetup.")
        }
        let map = [groupName! : proxyName!]
        let json = dictionaryToJson(dic: map)
        ClashKit.ClashPatchSelector(json?.data(using: .utf8))
        return true
    }
    
    private func initTunnelSettings(proxyHost: String, proxyPort: Int) -> NEPacketTunnelNetworkSettings {
        let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: vpnIP ?? "254.1.1.1")
        settings.mtu = 1450
//        settings.ipv4Settings = {
//            let settings = NEIPv4Settings(addresses: ["198.18.0.1"], subnetMasks: ["255.255.0.0"])
//            settings.includedRoutes = [NEIPv4Route.default()]
//            return settings
//        }()
//        settings.ipv6Settings = {
//            let settings = NEIPv6Settings(addresses: ["fd6e:a81b:704f:1211::1"], networkPrefixLengths: [64])
//            settings.includedRoutes = [NEIPv6Route.default()]
//            return settings
//        }()
//        settings.dnsSettings = NEDNSSettings(servers: ["1.1.1.1"])
        settings.dnsSettings = NEDNSSettings(servers: ["101.226.4.6"])
        settings.proxySettings = {
            let settings = NEProxySettings();
            settings.httpServer = NEProxyServer(address: "::1", port: proxyPort)
            settings.httpsServer = NEProxyServer(address: "::1", port: proxyPort)
            settings.httpEnabled = true
            settings.httpsEnabled = true
            settings.matchDomains = [""]
            return settings
        }()
        return settings
    }
}

class AppClashClient: NSObject, ClashClientProtocol {
    private let trafficListener: (_ up: Int64, _ down: Int64) -> Void
    
    init(trafficListener: @escaping (_ up: Int64, _ down: Int64) -> Void) {
        self.trafficListener = trafficListener
    }
    
    func log(_ level: String?, message: String?) {
        osLog("AppClashClient[\(level ?? "")]: \(message ?? "")")
    }
    
    func traffic(_ up: Int64, down: Int64) {
        trafficListener(up, down)
    }
}

private func saveTunnelConfigToFile(socksPort: Int) -> URL {
    //task-stack-size: 20480
    //task-stack-size: 24576
    //tcp-buffer-size: 4096 //这个是后加上的
    //task-stack-size: 32768
    //tcp-buffer-size: 8192
    /**
          enable: true
    •    开启 TUN 隧道模式，让 iOS 把 IP 层流量导入 VPN。
    •    必须开启，否则 VPN 隧道无法接管网络流量。
    •    udp: true
    •    支持 UDP 流量转发。
    •    iOS 视频/游戏应用常用 QUIC/HTTP3，需要 UDP，否则视频刷一会就断开。
    •    mtu: 1450
    •    最大传输单元。iOS 支持的最大稳定值约 1450。
    •    设置过大（如 9000）会导致分片失败，长视频或大流量 TCP/UDP 连接容易断。
    •    auto-route: true
    •    自动将设备所有流量通过 VPN 隧道。
    •    如果设置为 false，需要手动路由，否则部分流量可能直连导致不走 VPN。

    •    port: \(socksPort)
    •    本地 SOCKS5 代理端口，用于 Tunnel 将流量转发给 Clash Core 或代理服务。
    •    \(socksPort) 是 Flutter 占位符，会动态替换为实际端口。
    •    address: ::1
    •    本地 IPv6 地址（相当于 127.0.0.1）。
    •    udp: true
    •    开启 UDP 支持，保证视频流量、QUIC/HTTP3 能通过 SOCKS5 隧道。
    •    task-stack-size: 32768
    •    隧道线程堆栈大小（字节）。
    •    流量大或并发高时，增大堆栈防止线程崩溃。
    •    tcp-buffer-size: 16384
    •    TCP 缓冲区大小（字节）。
    •    视频流量大，缓冲区太小可能导致长连接掉线。
    •    connect-timeout: 5000
    •    TCP 连接超时时间（毫秒）。
    •    超过 5 秒未建立连接就重连。
    •    read-write-timeout: 60000
    •    TCP 读写超时时间（毫秒）。
    •    视频长连接可承受 60 秒延迟，不轻易断开。
    •    log-file: stderr & log-level: info
    •    日志输出到标准错误流，方便调试，打印主要信息。
    •    limit-nofile: 65535
    •    文件描述符上限。
    •    流量大或并发多时，保证足够的 socket/文件句柄，避免连接失败。

    */
  
    let content = """
    tunnel:
      mtu: 1450
      auto-route: true
      enable: true
      udp: true
    socks5:
      port: \(socksPort)
      address: ::1
      udp: true


    misc:
      task-stack-size: 32768 
      tcp-buffer-size: 16384
      connect-timeout: 5000
      read-write-timeout: 60000
      log-file: stderr
      log-level: info
      limit-nofile: 65535
    """
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent("tunnel_config.yaml")
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            fatalError("Error writing to file: \(error)")
        }
    } else {
        fatalError("Error finding the documents directory.")
    }
}


private func jsonToDictionary(_ text: String?) -> [String: Any]? {
    if (text == nil) {
        return nil
    }
    if let data = text!.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            osLog("\(error.localizedDescription)")
        }
    }
    return nil
}

private func dictionaryToJson(dic: Dictionary<String, Any>?) -> String? {
    var jsonData: Data? = nil
    do {
        if let dic = dic {
            jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        }
    } catch {
    }
    if let jsonData = jsonData {
        return String(data: jsonData, encoding: .utf8)
    }
    return nil
}

enum MyError: Error {
    case runtimeError(String)
}


private func resolvePath(_ nonSandboxPath: String?, isDir: Bool) -> URL? {
    if (nonSandboxPath == nil) {
        return nil
    }
    //"/private/var/mobile/Containers/Shared/AppGroup/604455A2-AD91-4DD7-AC82-F7DCE3BE448E/clash/profile/1ab43c05"
    return URL(string: nonSandboxPath!)
}

func osLog(_ any: Any?) {
    NSLog("[ClashFlt.PacketTunnel]\(any ?? "")")
}
