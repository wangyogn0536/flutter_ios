import 'package:agent_app_vpn/project_imports.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

/// Created by 刘冰.
/// Date:2024/4/20
/// des:App初始化

class AppInit {
  AppInit._();

  static Future<void> init() async {
    Future.delayed(const Duration(seconds: 1), () {
      FlutterSplashScreen.hide();
    });
    // CacheManager.preInit();
    // AppStorage().init();
  }
}

///禁用复制粘贴
class CustomTextEditingController extends TextEditingController {
  @override
  void copy(String text) {
    // 禁用复制功能
    print('Copy action blocked');
  }

  @override
  void paste(String text) {
    // 禁用粘贴功能
    print('Paste action blocked');
  }
}
