import 'package:agent_app_vpn/config/node_config.dart';
import 'package:agent_app_vpn/config/socks5_config_generate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../page/login_register/login_register_backage_page.dart';
const platformChannel = MethodChannel('your_channel_name');

class AndroidVpnService {
  static Future<void> startVpn(NodeConfig config) async {
    try {
      if (await flutterV2ray.requestPermission()) {
        await flutterV2ray.startV2Ray(
          remark: "四叶天代理IP",
          config: socks5ConfigGenerate(config.serverAddress, config.serverPort,
              config.username, config.password),
          blockedApps: null,
          bypassSubnets: null,
          proxyOnly: false,
        );
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to connect: '${e.message}'.");
    }
  }

  static Future<void> stopVpn() async {
    try {
      flutterV2ray.stopV2Ray();
    } on PlatformException catch (e) {
      debugPrint("Failed to disconnect: '${e.message}'.");
    }
  }
}

class IosVpnService {
  static const platformChannel =
      MethodChannel('com.agent.zhongqi.app/iOSNetworkConfig');
  // 调用iOS原生代码配置网络
  static Future<void> configureNetwork(NodeConfig nodeConfig) async {
    try {
      await platformChannel.invokeMethod('configureSOCKS5VPN', {
        'proxyAddress': nodeConfig.serverAddress,
        'port': nodeConfig.serverPort,
        'username': nodeConfig.username,
        'password': nodeConfig.password,
      });
    } on PlatformException catch (e) {
      // 处理异常
      print("Failed to Invoke: '${e.message}'.");
    }
  }
}
