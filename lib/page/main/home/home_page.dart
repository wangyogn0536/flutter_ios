import 'dart:io';

import 'package:agent_app_vpn/config/node_config.dart';
import 'package:agent_app_vpn/page/main/home/home_page_model.dart';
import 'package:agent_app_vpn/page/main/home/renew_server_list/renew_server_list_page.dart';
import 'package:agent_app_vpn/page/main/home/server_list/server_list_page.dart';
import 'package:agent_app_vpn/project_imports.dart';
// import 'package:background_fetch/background_fetch.dart';
import 'package:clash_flt/clash_flt.dart';
import 'package:clash_flt/clash_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_v2ray/model/v2ray_status.dart';
// import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/profile_generator.dart';
import '../../../data/server_list_bean_entity.dart';
import '../../../util/permission.dart';
import '../../../util/vpn_service.dart';
import '../../login_register/login/login_page.dart';
import '../personal/personal_page.dart';
import '../purchase_center/help_center/help_center_page.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:主页UI

///接受传过来的v2值
var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
NodeConfig? nodeConfig;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseState<HomePageModel, HomePage>
    with WidgetsBindingObserver {
  // String selectNodes = ConfigString.pleaseSelectServer;
  // String expirationDateText = '';
  // String addressText = '';

  // String selectNodes =
  //     CacheManager.getInstance()?.get(ConfigString.selectId) != null
  //         ? '${CacheManager.getInstance()?.get(ConfigString.area)}'
  //         : ConfigString.pleaseSelectServer;
  bool isConnect = false;
  bool isVpn = false;
  // String area = '${CacheManager.getInstance()!.get(ConfigString.area)}';
  //续费列表
  Set<ServerListBeanDataData> selectedIndices = {};
  //获取剩余时间选项
  DateTime? expiryDate;
  // Timer? timer;

  String area = ConfigString.pleaseSelectServer; //地点名称
  String ip = ''; //节点名称
  String diffDay = ''; //剩余时间
  int difDayInt = 0;
  // Timer? _vpnStatusTimer;
  int currentIndex = 0; //判断ip类型（静态或住宅）
  String daikuan = '';

  ///判断版本编号的
  // int version = int.parse(
  //     '${CacheManager.getInstance()?.get(ConfigString.version)}'
  //         .replaceAll('.', ''));
  // int onlineVersion = int.parse(
  //     '${CacheManager.getInstance()?.get(ConfigString.onlineVersion)}'
  //         .replaceAll('.', ''));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    ///启动程序第一次执行的方法
    checkIfFirstLaunch();
    isConnect = isVpn;
    if (CacheManager.getInstance()?.get(ConfigString.selectId) != null) {
      if (Platform.isIOS) {
        iOSInitState();
      }
    }
    Future.delayed(const Duration(seconds: 1), () {
      //检测更新系统
      updateDetection();
      //节点显示自动化
      // storeData();
    });

    ///定义网络监测参数系统
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      print("StreamSubscription=======1111111111");
      _checkConnection(result);
    });
  }

  // Future<String> getIpAddress(String hostname) async {
  //   try {
  //     final List<InternetAddress> addresses =
  //         await InternetAddress.lookup(hostname);
  //     print('111111111======');
  //     print('111111111======');
  //     print('111111111======');
  //     print(addresses.first.address);

  //     return addresses.first.address; // 返回第一个找到的IP地址
  //   } catch (e) {
  //     return 'Error: $e';
  //   }
  // }

  void iOSInitState() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.yaml');
    // String newserverAddress = await getIpAddress(nodeConfig!.serverAddress);
    // NodeConfig.update(newserverAddress, nodeConfig!.serverPort,
    //     nodeConfig!.username, nodeConfig!.password);
    file.writeAsString(profileGenerator(nodeConfig!));
    ClashFlt.instance.profileFile.value = file;
  }

  void _checkConnection(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      MessageToast.noCancelAlert('提醒', '网络断开，请查看网络', context);
      // return;
    }
    if (isVpn) {
      if (!result.contains(ConnectivityResult.vpn)) {
        if (nodeConfig?.serverAddress == '127.0.0.0') {
          return;
        }
        if (Platform.isIOS) {
          await ClashFlt.instance.resolveProfile();
          Future.delayed(const Duration(seconds: 1), () {
            ClashFlt.instance.startClash();
          });
          print("StreamSubscription=======222222");
          return;
        }
      }
    }
  }

  ///检测更新系统
  void updateDetection() {
    if (CacheManager.getInstance()?.get(ConfigString.onlineVersion) != null) {
      if (int.parse('${CacheManager.getInstance()?.get(ConfigString.version)}'
              .replaceAll('.', '')) <
          int.parse(
              '${CacheManager.getInstance()?.get(ConfigString.onlineVersion)}'
                  .replaceAll('.', ''))) {
        MessageToast.alert('有新版本更新是否需要更新', context, confirm: () {
          if (Platform.isIOS) {
            launchUrl(Uri.parse(
                'https://apps.apple.com/cn/app/%E5%9B%9B%E5%8F%B6%E5%A4%A9/id6615071892'));
          }
          return;
        }, callback: () {
          if (CacheManager.getInstance()?.get(ConfigString.isHot) == true) {
            activePopoverDiaLog(context);
            return;
          }
        });
      } else {
        if (CacheManager.getInstance()?.get(ConfigString.isHot) == true) {
          activePopoverDiaLog(context);
          return;
        }
      }
    }
  }

  ///存储数据显示
  void storeData() {
    HomePageModel model = HomePageModel();
    if (CacheManager.getInstance()?.get(ConfigString.selectId) != null) {
      area = '${CacheManager.getInstance()?.get(ConfigString.area)}';
      ip = '${CacheManager.getInstance()?.get(ConfigString.ip)}';
      diffDay = getLeaseTerm(model.timeEnd);
      difDayInt =
          DateTime.parse(model.timeEnd).difference(DateTime.now()).inDays;
      ;
      NodeConfig.update(
          '${CacheManager.getInstance()?.get(ConfigString.ip)}',
          int.parse('${CacheManager.getInstance()?.get(ConfigString.portSs5)}'),
          '${CacheManager.getInstance()?.get(ConfigString.uname)}',
          '${CacheManager.getInstance()?.get(ConfigString.passwd)}');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // 应用进入后台
      // startListeningVPNStatus();
    } else if (state == AppLifecycleState.resumed) {
      // 应用回到前台
      // stopListeningVPNStatus();
      if (isVpn) {
        if (Platform.isIOS) {
          ClashFlt.instance.resolveProfile();
          ClashFlt.instance.startClash();
          return;
        }
      }
    }
  }

  // void startListeningVPNStatus() async {
  //   BackgroundFetch.configure(
  //       BackgroundFetchConfig(
  //         minimumFetchInterval: 1,
  //         stopOnTerminate: false,
  //         enableHeadless: true,
  //         requiresBatteryNotLow: false,
  //         requiresCharging: false,
  //         requiresStorageNotLow: false,
  //         requiresDeviceIdle: false,
  //         requiredNetworkType: NetworkType.NONE,
  //       ), (String taskId) async {
  //     if (isVpn) {
  //       if (Platform.isIOS) {
  //         ClashFlt.instance.resolveProfile();
  //         ClashFlt.instance.startClash();
  //         return;
  //       }
  //     }
  //   });

  //   // VpnConnectionDetector vpnDetector = VpnConnectionDetector();
  //   // _vpnStatusTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
  //   //   vpnDetector.vpnConnectionStream.listen((event) {
  //   //     print('$event');
  //   //     if (event == VpnConnectionState.disconnected) {
  //   //
  //   //     }
  //   //   });
  //   // });
  // }

  // void stopListeningVPNStatus() {
  //   _vpnStatusTimer?.cancel();
  // }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    // _vpnStatusTimer?.cancel();
  }

  @override
  Widget getContentChild(HomePageModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 23, 244, 3),
        child: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              height: 540.h,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: MyColor.gray333Color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 65.h),
                    // color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigationPush(context, const HelpCenterPage());
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 20.w),
                              width: 50.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border: Border.all(
                                  color: Colors.white, // 边框颜色
                                  width: 1, // 边框宽度
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '教程',
                                  style: MyTextStyle.text15whiteStyle,
                                ),
                              )),
                        ),
                        Text(
                          ConfigString.homeHeaderText,
                          style: MyTextStyle.text20whiteStyle,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: IconButton(
                              onPressed: () {
                                MessageToast.alert(
                                    ConfigString.confirmMsg, context,
                                    confirm: () {
                                  CacheManager.clearKey(ConfigString.token);
                                  CacheManager.clearKey(ConfigString.selectId);
                                  // if (Platform.isAndroid) {
                                  //   AndroidVpnService.stopVpn();
                                  // }
                                  if (Platform.isIOS) {
                                    ClashFlt.instance.stopClash();
                                  }
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                });
                              },
                              icon: Image.asset(
                                'images/quit_icon.png',
                                width: 26.w,
                                height: 28.h,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Platform.isAndroid
                      ? Container(
                          margin: EdgeInsets.only(top: 110.h),
                          width: 170.w,
                          height: 170.w,
                          child: FloatingActionButton(
                            backgroundColor: MyColor.themeColor,
                            // foregroundColor: MyColor.greenColor,
                            elevation: 8.0, //
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(120.w),
                            ),
                            // clipBehavior: Clip.antiAlias,
                            onPressed: () {
                              // if (Platform.isAndroid) {
                              if (model.ipCount == 0) {
                                MessageToast.alert(
                                    '您暂时还没有IP\n是否前往购买后使用？', context,
                                    confirm: () {
                                  navigationPush(context, const PersonalPage());
                                  return;
                                }, callback: () {
                                  return;
                                });
                                return;
                              }
                              if (CacheManager.getInstance()
                                      ?.get(ConfigString.selectId) ==
                                  null) {
                                MessageToast.toast('请先选择节点后再链接');
                                // selectServerList(model);
                                return;
                              }
                              isConnect =
                                  v2rayStatus.value.state == 'DISCONNECTED';
                              setState(() {
                                if (v2rayStatus.value.state == "CONNECTED") {
                                  isVpn = false;
                                  AndroidVpnService.stopVpn();
                                  model.userEndVpn(
                                      int.parse(
                                          '${CacheManager.getInstance()?.get(ConfigString.selectId)}'),
                                      () {});
                                  return;
                                }
                                if (nodeConfig?.serverAddress == '127.0.0.0') {
                                  isConnect = false;
                                  isVpn = false;
                                  MessageToast.toast(
                                      ConfigString.pleaseSelectServer);
                                  AndroidVpnService.stopVpn();
                                  return;
                                }
                                // if (model.serverInfoBeanEntity?.data.diffday <
                                //     0) {
                                //   MessageToast.toast('IP节点已过期，请重新选择');
                                //   isConnect = false;
                                //   selectServerList(model);
                                //   return;
                                // }
                                if (nodeConfig == null) {
                                  isConnect = false;
                                  isVpn = false;
                                  MessageToast.toast(
                                      ConfigString.pleaseSelectServer);
                                  AndroidVpnService.stopVpn();
                                  return;
                                }
                                model.userStartVpn(
                                    int.parse(
                                        '${CacheManager.getInstance()?.get(ConfigString.selectId)}'),
                                    3, () {
                                  isVpn = true;
                                  AndroidVpnService.startVpn(nodeConfig!);
                                });
                              });
                              // }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'images/base_switch.png'),
                                  width: 60.w,
                                  height: 60.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Text(
                                    isConnect
                                        ? ConfigString.breakConnect
                                        : ConfigString.clickConnect,
                                    style: MyTextStyle.text17whiteStyle,
                                  ),
                                ),
                              ],
                            ),
                            // child: const Text(ConfigString.clickConnect),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 110.h),
                          width: 170.w,
                          height: 170.w,
                          child: ValueListenableBuilder(
                              valueListenable:
                                  ClashFlt.instance.state.isRunning,
                              builder: (context, value, child) {
                                final isInited = value == LazyState.enabling ||
                                    value == LazyState.disabling;
                                final isConnected =
                                    value == LazyState.enabled ||
                                        value == LazyState.disabling;
                                return FloatingActionButton(
                                  backgroundColor: MyColor.themeColor,
                                  // foregroundColor: MyColor.greenColor,
                                  elevation: 8.0, //
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(120.w),
                                  ),
                                  onPressed: () async {
                                    // print('isConnected---------$isConnected');
                                    if (isInited || nodeConfig == null) {
                                      MessageToast.toast(
                                          ConfigString.pleaseSelectServer);
                                      return;
                                    }
                                    if (isConnected) {
                                      ClashFlt.instance.stopClash();
                                      isVpn = false;
                                    } else {
                                      isVpn = true;
                                      await ClashFlt.instance.resolveProfile();
                                      ClashFlt.instance.startClash();
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            'images/base_switch.png'),
                                        width: 60.w,
                                        height: 60.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Text(
                                          isVpn
                                              ? ConfigString.breakConnect
                                              : ConfigString.clickConnect,
                                          style: MyTextStyle.text17whiteStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  isConnect
                      ? Padding(
                          padding: EdgeInsets.only(left: 300.w),
                          child: ValueListenableBuilder(
                              valueListenable: v2rayStatus,
                              builder: (context, value, child) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'images/top_arrow_icon.png'),
                                          width: 19,
                                          height: 20,
                                        ),
                                        Text(
                                          '${value.uploadSpeed}',
                                          style: MyTextStyle.text15whiteStyle,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'images/bottom_arrow_icon.png'),
                                          width: 19,
                                          height: 20,
                                        ),
                                        Text('${value.downloadSpeed}',
                                            style:
                                                MyTextStyle.text15whiteStyle),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        )
                      : const Center(),
                  Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: ValueListenableBuilder(
                        valueListenable: v2rayStatus,
                        builder: (context, value, child) {
                          return Text(
                            isConnect ? value.duration : '',
                            style: MyTextStyle.text30themeStyle,
                          );
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: ScreenUtil().screenWidth,
              color: MyColor.tvDDDColor,
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 19.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (model.ipCount == 0) {
                                MessageToast.alert(
                                    '您暂时还没有IP\n是否前往购买后使用？', context,
                                    confirm: () {
                                  navigationPush(context, const PersonalPage());
                                  return;
                                }, callback: () {
                                  navigationPush(
                                      context, const ServerListPage());
                                  return;
                                });
                              } else {
                                selectServerList(model);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15.h),
                              width: 187.w,
                              height: 52.h,
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              decoration:
                                  myBoxDecoration(backColor: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            'images/site_icon.png'),
                                        width: 30.w,
                                        height: 40.h,
                                      ),
                                      /**
                                          CacheManager.getInstance()?.get(
                                          ConfigString.selectId) !=
                                          null
                                          ? model.serverInfoBeanEntity?.data
                                          .area ??
                                          ''
                                          : ConfigString.pleaseSelectServer
                                       * */
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Text(
                                          area,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: MyColor.gray333Color),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image(
                                    image: const AssetImage(
                                        'images/right_arrow_icon.png'),
                                    width: 15.w,
                                    height: 20.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.rectDetectionApiManager();
                              MessageToast.toast('IP数量刷新成功');
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15.h),
                              width: 187.w,
                              height: 52.h,
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              decoration:
                                  myBoxDecoration(backColor: Colors.white),
                              child: Center(
                                child: Text(
                                  '共有IP数量${model.ipCount ?? '0'}个',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: MyColor.themeColor),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      area != ConfigString.pleaseSelectServer
                          ? Container(
                              margin: EdgeInsets.only(top: 20.h),
                              padding: EdgeInsets.only(
                                  top: 10.h,
                                  left: 20.w,
                                  right: 20.w,
                                  bottom: 10.h),
                              decoration:
                                  myBoxDecoration(backColor: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      currentIndex == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  ConfigString.belongAddress,
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          MyColor.orangeColor),
                                                ),
                                                /*
                                          model.serverInfoBeanEntity?.data
                                                      .ip ??
                                                  ''
                                          * */
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.w, top: 3),
                                                  child: Text(
                                                    ip,
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: serverInfoColor(
                                                            difDayInt)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const Center(),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  currentIndex == 0 ? 12.h : 0),
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    ConfigString
                                                        .ipExpirationDate,
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: MyColor
                                                            .orangeColor),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.w),
                                                    width: 100.w,
                                                    /**
                                                     * model.serverInfoBeanEntity!
                                                        .data.timeEnd ??
                                                        ''
                                                     * */
                                                    child: Text(
                                                      maxLines: 1,
                                                      model.timeEnd,
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
                                                          color: MyColor
                                                              .desTextColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            ConfigString.timeRemaining,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: MyColor.orangeColor),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 5.w,
                                            ),
                                            /**
                                                   * model.serverInfoBeanEntity?
                                                      .data.diffday??0 >=
                                                      0
                                                      ? '${model.serverInfoBeanEntity?.data.diffday}天'
                                                      : '已过期',

                                                      '${model.serverInfoBeanEntity?.data.diffday}天'
                                                   * */
                                            child: Text(
                                              diffDay,
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: serverInfoColor(
                                                      difDayInt)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Platform.isAndroid && currentIndex == 0
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.h),
                                              child: ThemeTitleButton(
                                                  size: Size(100.w, 30.h),
                                                  backgroudColor:
                                                      MyColor.themeColor,
                                                  title: '去续费',
                                                  titleFont: 16.sp,
                                                  titleColor: Colors.white,
                                                  onTap: () {
                                                    model.memberInfoAPI(() {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return PayRenewWidget(
                                                              balanceString:
                                                                  model.money,
                                                              orderIdList: [
                                                                int.parse(
                                                                    '${CacheManager.getInstance()!.get(ConfigString.selectId)}')
                                                              ],
                                                              firstPrice:
                                                                  '0.00',
                                                              daikuan:
                                                                  int.parse(
                                                                      daikuan),
                                                            );
                                                          });
                                                    });
                                                  }),
                                            )
                                          : const Center(),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const Center(),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  ///取消定时器监听
  // void stopTimer() async {
  //   timer?.cancel();
  //   timer = null;
  // }

/**
 * 第一次执行程序逻辑
 * */
  Future<bool> isFirstTimeLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 使用一个key来标记是否是第一次启动
    bool isFirstLaunch = prefs.getBool('is_first_launch') ?? true;
    if (isFirstLaunch) {
      // 如果是第一次启动，修改标志位
      await prefs.setBool('is_first_launch', false);
    }
    return isFirstLaunch;
  }

  Future<void> checkIfFirstLaunch() async {
    bool isFirstLaunch = await isFirstTimeLaunch();
    if (isFirstLaunch) {
      // 如果是第一次启动，执行特定逻辑
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const guideBeginnersWidget();
          });
    }
  }

  ///活动弹窗
  void activePopoverDiaLog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Image.network(
                          'https://www.siyetian.com/static/huodong/images/hot.app.png'),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Image.asset(
                          'images/close_icon.png',
                          width: 35.w,
                          height: 35.w,
                        ))
                  ],
                ),

                // SizedBox.expand(
                //     child: Image.asset(
                //       'images/beginner_guide0${index}_icon.jpg',
                //       fit: BoxFit.cover,
                //     )),
              ],
            ),
          );
        });
  }

  ///新版本更新弹窗
  void newVersionUpdateDiaLog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Image.asset('images/close_icon.png'),
                    )
                  ],
                ),

                // SizedBox.expand(
                //     child: Image.asset(
                //       'images/beginner_guide0${index}_icon.jpg',
                //       fit: BoxFit.cover,
                //     )),
              ],
            ),
          );
        });
  }

  ///信息栏颜色选择
  Color serverInfoColor(int day) {
    Color color;
    if (day > 3) {
      color = MyColor.desTextColor;
    } else {
      color = Colors.red;
    }
    return color;
  }

  ///选择节点后的返回
  void selectServerList(HomePageModel model) {
    Future serverListPagePush = navigationPush(context, const ServerListPage());
    serverListPagePush.then((value) {
      final result = value as ResultData;
      DateTime endDate = DateTime.parse(result.serverListBeanDataData.timeEnd);
      DateTime startDate = DateTime.now();
      isVpn = false;
      if (Platform.isAndroid) {
        AndroidVpnService.stopVpn();
      }
      if (Platform.isIOS) {
        ClashFlt.instance.stopClash();
      }
      CacheManager.getInstance()
          ?.set(ConfigString.selectId, result.serverListBeanDataData.id);
      // CacheManager.getInstance()?.set(ConfigString.area, value.area);
      // CacheManager.getInstance()?.set(ConfigString.timeEnd, value.timeEnd);
      // CacheManager.getInstance()?.set(ConfigString.ip, value.ip);
      // CacheManager.getInstance()?.set(ConfigString.portSs5, value.portSs5);
      // CacheManager.getInstance()?.set(ConfigString.uname, value.uname);
      // CacheManager.getInstance()?.set(ConfigString.passwd, value.passwd);
      model.userEndVpn(
          int.parse(
              '${CacheManager.getInstance()?.get(ConfigString.selectId)}'),
          () {});
      NodeConfig.update(
          result.serverListBeanDataData.ip,
          int.parse(result.serverListBeanDataData.portSs5),
          result.serverListBeanDataData.uname,
          result.serverListBeanDataData.passwd);
      iOSInitState();
      setState(() {
        isConnect = false;
        area = result.serverListBeanDataData.area;
        ip = result.serverListBeanDataData.ip;
        model.timeEnd = result.serverListBeanDataData.timeEnd;
        diffDay = getLeaseTerm(result.serverListBeanDataData.timeEnd);
        difDayInt = endDate.difference(startDate).inDays;
        daikuan = result.serverListBeanDataData.daikuan;
        currentIndex = result.index;
        // addressText = value.ip;
        // expirationDateText = value.timeEnd;
      });
    });
  }

  @override
  // TODO: implement viewModel
  HomePageModel get viewModel => HomePageModel();
}

///底部的button
class BottomButton extends StatelessWidget {
  String title;
  final VoidCallback onTop;
  BottomButton(this.title, this.onTop, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 123.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white, // 背景颜色
        border: Border.all(
          color: MyColor.tvDDDColor, // 边框颜色
          width: 1.0, // 边框宽度
        ),
        borderRadius: BorderRadius.circular(2.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.gray333Color.withOpacity(0.1), // 阴影颜色，这里使用了半透明的灰色
            offset: const Offset(1, 1), // 阴影偏移量，水平向右3px，垂直向下3px
            blurRadius: 1.0, // 阴影的模糊半径
            spreadRadius: 1.0, //偏移量
          ),
        ],
      ),
      child: TextButton(
        onPressed: onTop,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          title,
          style: MyTextStyle.text15themeStyle,
        ),
      ),
    );
  }
}

/**
 * 新手指引的widget
 * */
class guideBeginnersWidget extends StatefulWidget {
  const guideBeginnersWidget({super.key});

  @override
  State<guideBeginnersWidget> createState() => _guideBeginnersWidgetState();
}

class _guideBeginnersWidgetState extends State<guideBeginnersWidget> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
            child: SizedBox(
          width: ScreenUtil().screenWidth, // 屏幕宽度
          height: ScreenUtil().screenHeight - 50.h, //
          child: Image.asset(
            'images/beginner_guide0${index}_icon.jpg',
            fit: BoxFit.cover,
          ),
        )),
        Positioned(
            bottom: 70.h,
            child: Container(
              width: ScreenUtil().screenWidth,
              height: 90.h,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    index++;
                  });
                  if (index > 4) {
                    navPop();
                  }
                },
                child: Center(
                  child: Container(
                    width: 170.w,
                    height: 80.h,
                    color: Colors.transparent,
                  ),
                ),
              ),
            )),
        Positioned(
            top: 55.h,
            right: 34.w,
            child: GestureDetector(
              onTap: () {
                navPop();
              },
              child: Container(
                width: 88.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(
                    color: Colors.white, // 边框颜色
                    width: 1, // 边框宽度
                  ),
                ),
                child: Center(
                  child: Text(
                    '跳过',
                    style: MyTextStyle.text20whiteStyle,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  void navPop() {
    Navigator.of(context).pop();
    NodeConfig.update('127.0.0.0', 8442, 'syd123456', '456789123');
    AndroidVpnService.startVpn(nodeConfig!);
  }
}

///Image.asset('images/beginner_guide01_icon.jpg')
