import 'node_config.dart';

/// Created by 刘冰.
/// Date:2024/5/20
/// des:socks5的苹果端结构封装
const kProxyName = "socks5";
const kProxyGroupName = "default";

// String profileGenerator(NodeConfig config) => '''
// port: 7890
// socks-port: 7891
// mode: rule
// log-level: silent

// proxies:
//   - name: "$kProxyName"
//     type: socks5
//     server: ${config.serverAddress}
//     port: ${config.serverPort}
//     username: ${config.username}
//     password: ${config.password}
//     udp: false

// proxy-groups:
//   - name: "$kProxyGroupName"
//     type: select
//     proxies: 
//       - "socks5"

// rules:
//   - "MATCH,default"
// ''';
String profileGenerator(NodeConfig config) => '''
port: 7890
socks-port: 7891
mode: rule
log-level: info  # silent 也可，根据需要

proxies:
  - name: "$kProxyName"
    type: socks5
    server: ${config.serverAddress}
    port: ${config.serverPort}
    username: ${config.username}
    password: ${config.password}
    udp: true  # ⚠️ 开启 UDP 支持

proxy-groups:
  - name: "$kProxyGroupName"
    type: select
    proxies: 
      - "$kProxyName"

rules:
  - "MATCH,$kProxyGroupName"
''';