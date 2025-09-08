import 'package:agent_app_vpn/page/main/home/home_page.dart';

/// Created by 刘冰.
/// Date:2024/2/20
/// des:封装更换ip地址config参数
class NodeConfig {
  NodeConfig(this.serverAddress, this.serverPort, this.username, this.password);

  static void update(
    String serverAddress,
    int serverPort,
    String username,
    String password,
  ) =>
      nodeConfig = NodeConfig(serverAddress, serverPort, username, password);

  final String serverAddress;
  final int serverPort;
  final String username;
  final String password;
}
