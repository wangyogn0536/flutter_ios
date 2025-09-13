import 'dart:io';

import 'package:agent_app_vpn/page/login_register/login/login_page.dart';
import 'package:agent_app_vpn/page/login_register/login_register_backage_page.dart';
import 'package:agent_app_vpn/page/main/tab_bar_page.dart';
import 'package:agent_app_vpn/project_imports.dart';
// import 'package:background_fetch/background_fetch.dart';
import 'package:clash_flt/clash_flt.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'config/global.dart';
import 'config/profile_generator.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:项目入口
///封装的全局vpn更改ip口

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.preInit();
  flutterV2ray.initializeV2Ray();
  initClash() async {
    final filesDir = await getApplicationSupportDirectory();
    final clashHome =
        Directory("${filesDir.path}${Platform.pathSeparator}clash");
    await clashHome.create();
    await ClashFlt.instance.init(clashHome);
    ClashFlt.instance.selectedProxyName.value = kProxyName;
    ClashFlt.instance.selectedProxyGroupName.value = kProxyGroupName;
    await ClashFlt.instance.polluteCountryDB("assets/Country.mmdb");
  }

  await initClash();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  CacheManager.getInstance()?.set(ConfigString.version, packageInfo.version);

  ///初始化后台刷新
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      child: MaterialApp(
        localizationsDelegates: const [
          // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: '四叶天代理',
        supportedLocales: const [
          Locale('zh', 'CN'),
        ],
        theme: ThemeData(
          highlightColor: const Color.fromRGBO(0, 0, 0, 0),
          splashColor: const Color.fromRGBO(0, 0, 0, 0),
        ),
        navigatorKey: Global.navigatorKey,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        home: CacheManager.getInstance()?.get(ConfigString.token) == null
            ? const LoginPage()
            : const TabBarPage(),
      ),
    );
  }
}

///后台刷新
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
