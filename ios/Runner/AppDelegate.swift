import UIKit
import Flutter
import NetworkExtension

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // 配置后台任务
    setupAndStartVPN()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func setupAndStartVPN() {
    let manager = NEVPNManager.shared()

    manager.loadFromPreferences { error in
      if let error = error {
        print("❌ 加载 VPN 配置失败: \(error)")
        return
      }

      // 配置 OnDemand 自动重连规则
      let rule = NEOnDemandRuleConnect()
      manager.onDemandRules = [rule]
      manager.isOnDemandEnabled = true

      // 配置 TunnelProvider 指向 PacketTunnel
      let tunnelProtocol = NETunnelProviderProtocol()
      tunnelProtocol.providerBundleIdentifier = "com.zhongqi.app.agent.PacketTunnel" // 替换成你的 PacketTunnel.appex bundle id
      tunnelProtocol.serverAddress = "127.0.0.1" // 可填任意占位
      tunnelProtocol.username = "" // 可选
      tunnelProtocol.passwordReference = nil // 可选

      manager.protocolConfiguration = tunnelProtocol
      manager.isEnabled = true

      // 保存配置
      manager.saveToPreferences { error in
        if let error = error {
          print("❌ 保存 VPN 配置失败: \(error)")
          return
        }

        print("✅ VPN 配置保存成功，准备启动 VPN")

        do {
          try manager.connection.startVPNTunnel()
          print("✅ VPN 已启动")
        } catch {
          print("❌ 启动 VPN 失败: \(error)")
        }
      }
    }
  }
}
