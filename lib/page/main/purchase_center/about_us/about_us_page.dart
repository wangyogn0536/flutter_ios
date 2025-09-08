import 'dart:io';

import 'package:agent_app_vpn/page/login_register/register/real_name/one_real_name/one_real_name_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../project_imports.dart';
import '../../../../widgets/my_web_view.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:关于四叶天UI

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int version = int.parse(
      '${CacheManager.getInstance()?.get(ConfigString.version)}'
          .replaceAll('.', ''));
  int onlineVersion = int.parse(
      '${CacheManager.getInstance()?.get(ConfigString.onlineVersion)}'
          .replaceAll('.', ''));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('关于四叶天', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: MyColor.tvDDDColor,
        child: Container(
          margin: EdgeInsets.all(20.w),
          padding: EdgeInsets.all(20.w),
          decoration: myBoxDecoration(backColor: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: 200.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Image.asset(
                        'images/logo_icon.png',
                        width: 75.w,
                        height: 75.w,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                      child: Text(
                        '${ConfigString.appName}代理',
                        style: MyTextStyle.text20blackStyle,
                      ),
                    ),
                    Text(
                      'v${CacheManager.getInstance()?.get(ConfigString.version)}',
                      style: MyTextStyle.text17grayStyle,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('111111---------$version---22222----$onlineVersion');
                  if (version < onlineVersion) {
                    MessageToast.alert(
                      '有新版本更新是否需要更新',
                      context,
                      confirm: () {
                        if (Platform.isAndroid) {
                          launchUrl(Uri.parse(
                              'https://wwue.lanzoup.com/siyetianAndroid'));
                          // androidDownload();
                        }
                        if (Platform.isIOS) {
                          launchUrl(Uri.parse(
                              'https://apps.apple.com/cn/app/%E5%9B%9B%E5%8F%B6%E5%A4%A9/id6615071892'));
                        }
                        return;
                      },
                    );
                  } else {
                    MessageToast.noCancelAlert('提示', '已是最新版本', context);
                  }
                },
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '版本更新',
                        style: MyTextStyle.text17blackStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '检查更新',
                            style: MyTextStyle.text17grayStyle,
                          ),
                          Image.asset(
                            'images/right_arrow_icon.png',
                            width: 17,
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              LineWidget(
                  width: double.infinity - 40.w, color: MyColor.grayCCCColor),
              InkWell(
                onTap: () {
                  navigationPush(
                      context,
                      const WebViewPage(
                        'https://api.s10.cn/v2/help/service',
                        ConfigString.userProtocol,
                        isPodding: true,
                      ));
                },
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '用户协议',
                        style: MyTextStyle.text17blackStyle,
                      ),
                      Image.asset(
                        'images/right_arrow_icon.png',
                        width: 17,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              LineWidget(
                  width: double.infinity - 40.w, color: MyColor.grayCCCColor),
              InkWell(
                onTap: () {
                  navigationPush(
                      context,
                      const WebViewPage(
                        'https://api.s10.cn/v1/help/policy',
                        ConfigString.privacyPolicy,
                        isPodding: true,
                      ));
                },
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '隐私政策',
                        style: MyTextStyle.text17blackStyle,
                      ),
                      Image.asset(
                        'images/right_arrow_icon.png',
                        width: 17,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              LineWidget(
                  width: double.infinity - 40.w, color: MyColor.grayCCCColor),
            ],
          ),
        ),
      ),
    );
  }
}
