import 'dart:async';
import 'dart:io';
// 暂时没用到这个心跳  所以文件是废弃状态
class VPNHeartbeat {
  static Timer? _timer;
  static int _failCount = 0;
  static const int _maxFail = 5; // 连续失败次数超过就提示或重连

  /// 开始心跳
  static void start(
      {Duration interval = const Duration(seconds: 30),
      int socksPort = 10808}) {
    // 避免重复启动
    stop();

    _timer = Timer.periodic(interval, (_) async {
      try {
        // 建立 TCP 连接到 SOCKS5 IPv6 回环
        final socket = await RawSocket.connect("::1", socksPort)
            .timeout(const Duration(seconds: 3));
        socket.close();

        _failCount = 0; // 成功就重置失败计数
        print("✅ VPN 心跳正常 ${DateTime.now()}");
      } catch (e) {
        _failCount++;
        print("❌ VPN 心跳错误: $e");

        if (_failCount >= _maxFail) {
          print("⚠️ VPN 心跳连续 $_maxFail 次失败，可以考虑重启 VPN 或通知用户");
          // TODO: 可调用 ClashFlt.instance.startClash() 重启 VPN
          _failCount = 0;
        }
      }
    });

    print("VPN 心跳启动，每 ${interval.inSeconds} 秒");
  }

  /// 停止心跳
  static void stop() {
    _timer?.cancel();
    _timer = null;
    _failCount = 0;
    print("VPN 心跳停止");
  }
}
