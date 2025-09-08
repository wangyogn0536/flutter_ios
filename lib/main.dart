import 'dart:io'; // 用于文件和目录操作，判断平台等

import 'package:agent_app_vpn/page/login_register/login/login_page.dart'; // 登录页面
import 'package:agent_app_vpn/page/login_register/login_register_backage_page.dart'; // 登录注册备份页面（当前未使用）
import 'package:agent_app_vpn/page/main/tab_bar_page.dart'; // 主页面的底部导航栏页面
import 'package:agent_app_vpn/project_imports.dart'; // 项目中自定义的导入集合
// import 'package:background_fetch/background_fetch.dart'; // 用于后台任务的包（当前注释）
import 'package:clash_flt/clash_flt.dart'; // Clash代理相关功能的Flutter插件
import 'package:flutter_localizations/flutter_localizations.dart'; // Flutter本地化支持
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart'; // 弹窗和对话框管理
import 'package:package_info_plus/package_info_plus.dart'; // 获取应用包信息（版本号等）
import 'package:path_provider/path_provider.dart'; // 获取设备目录路径

import 'config/global.dart'; // 全局配置和常量
import 'config/profile_generator.dart'; // 配置文件生成相关功能

/// Created by 刘冰.
/// Date:2024/5/23
/// des:项目入口
/// 封装的全局vpn更改ip口

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 确保Flutter环境初始化完成，特别是涉及异步操作和插件调用时必须先调用

  await CacheManager.preInit();
  // 初始化缓存管理器，准备缓存系统的使用

  flutterV2ray.initializeV2Ray();
  // 初始化V2Ray相关功能，封装的全局VPN更改IP接口

  // 定义一个异步函数初始化Clash代理环境
  initClash() async {
    final filesDir = await getApplicationSupportDirectory();
    // 获取应用支持目录，存放配置文件等

    final clashHome =
        Directory("${filesDir.path}${Platform.pathSeparator}clash");
    // 在支持目录下创建clash文件夹，用于存放Clash相关文件

    await clashHome.create();
    // 创建clash目录（如果不存在）

    await ClashFlt.instance.init(clashHome);
    // 初始化Clash插件，传入clashHome作为工作目录

    ClashFlt.instance.selectedProxyName.value = kProxyName;
    // 设置默认的代理名称，kProxyName定义在全局配置中

    ClashFlt.instance.selectedProxyGroupName.value = kProxyGroupName;
    // 设置默认的代理组名称，kProxyGroupName定义在全局配置中

    await ClashFlt.instance.polluteCountryDB("assets/Country.mmdb");
    // 加载国家数据库文件，用于代理地区识别
  }

  await initClash();
  // 执行Clash代理初始化

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // 获取当前应用的包信息，包括版本号等

  CacheManager.getInstance()?.set(ConfigString.version, packageInfo.version);
  // 将应用版本号缓存起来，方便后续使用

  ///初始化后台刷新
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  // 注册后台任务的回调函数，用于实现后台刷新功能（当前注释）

  runApp(const MyApp());
  // 运行Flutter应用，启动MyApp根组件
}

/// 应用的根组件，负责整体应用的配置和路由管理
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      // 设计稿尺寸，ScreenUtil用于适配不同屏幕尺寸

      child: MaterialApp(
        // MaterialApp是Flutter应用的顶层容器，提供导航、主题、本地化等功能

        localizationsDelegates: const [
          // 本地化代理，支持多语言环境
          // AppLocalizations.delegate, // 自定义的本地化代理（注释掉了）
          GlobalMaterialLocalizations.delegate, // Material组件本地化支持
          GlobalWidgetsLocalizations.delegate, // 基础Widget本地化支持
          GlobalCupertinoLocalizations.delegate, // iOS风格控件本地化支持
        ],

        title: '四叶天代理',
        // 应用标题，部分平台会显示

        supportedLocales: const [
          Locale('zh', 'CN'),
          // 支持的语言环境，这里只支持中文简体
        ],

        theme: ThemeData(
          // 应用主题配置

          highlightColor: const Color.fromRGBO(0, 0, 0, 0),
          // 去除点击高亮颜色，避免点击时出现默认的高亮效果

          splashColor: const Color.fromRGBO(0, 0, 0, 0),
          // 去除水波纹效果，点击时无波纹
        ),

        navigatorKey: Global.navigatorKey,
        // 全局的导航Key，方便在应用任意位置进行导航操作

        debugShowCheckedModeBanner: false,
        // 关闭右上角的debug标签

        navigatorObservers: [FlutterSmartDialog.observer],
        // 添加FlutterSmartDialog的导航观察者，确保弹窗正常显示和管理

        builder: FlutterSmartDialog.init(),
        // 初始化FlutterSmartDialog，包裹整个应用以支持弹窗功能

        home: CacheManager.getInstance()?.get(ConfigString.token) == null
            ? const LoginPage()
            : const TabBarPage(),
        // 根据缓存中是否存在token决定首页展示登录页还是主页面
      ),
    );
  }
}

/// 后台刷新任务的回调函数
// void backgroundFetchHeadlessTask(HeadlessTask task) async {
//   String taskId = task.taskId;
//   bool isTimeout = task.timeout;
//   if (isTimeout) {
//     print("[BackgroundFetch] Headless task timed-out: $taskId");
//     BackgroundFetch.finish(taskId);
//     return;
//   }
//   print('[BackgroundFetch] Headless event received.');
//   BackgroundFetch.finish(taskId);
// }
// 该函数用于处理后台任务事件，确保任务超时时正确结束，避免系统杀死应用。
// 目前该功能被注释，可能是因为未启用后台刷新或等待后续实现。
