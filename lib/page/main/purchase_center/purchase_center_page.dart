import 'dart:io';

import 'package:agent_app_vpn/page/main/purchase_center/purchase_center_page_model.dart';
import 'package:agent_app_vpn/page/main/purchase_center/vip/point_list.dart';
import 'package:agent_app_vpn/page/main/purchase_center/vip/vip_center.dart';
import 'package:clash_flt/clash_flt.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../project_imports.dart';
import '../../../util/permission.dart';
import '../../login_register/login/login_page.dart';
import '../../login_register/register/real_name/real_name_page.dart';
import '../home/server_list/server_list_page.dart';
import 'about_us/about_us_page.dart';
import 'change_password/change_password_page.dart';
import 'discount_coupon/discount_coupon_page.dart';
import 'help_center/help_center_page.dart';
import 'my_complaint/my_complaint_page.dart';
import 'my_wallet/my_wallet_page.dart';
import 'order_management/order_management_page.dart';

/// Created by 刘冰.
/// Date:2024/7/22
/// des:个人中心UI

class PurchaseCenterPage extends StatefulWidget {
  const PurchaseCenterPage({super.key});

  @override
  State<PurchaseCenterPage> createState() => _PurchaseCenterPageState();
}

class _PurchaseCenterPageState
    extends BaseState<PurchaseCenterModel, PurchaseCenterPage> {
  @override
  Widget getContentChild(PurchaseCenterModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      backgroundColor: MyColor.tvDDDColor,
      body: Container(
        height: double.infinity,
        decoration: myBoxDecoration(backColor: MyColor.tvDDDColor),
        child: Stack(
          children: [
            Container(
              height: 325.h,
              color: MyColor.gray333Color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 79.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.w, right: 17.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 88.w,
                                  height: 88.w,
                                  decoration: BoxDecoration(
                                    color: MyColor.tabTextColor,
                                    borderRadius: BorderRadius.circular(60.r),
                                  ),
                                  child: Image.asset(
                                    'images/head_portrait_icon.png',
                                  ),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: 0,
                                  child: Offstage(
                                    offstage:
                                        model.objectData.gradeinfo.level == 0,
                                    child: Image.asset(
                                      'images/vip_grade_v.png',
                                      fit: BoxFit.fitWidth,
                                      width: 25.w,
                                      height: 35.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 18.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.h, bottom: 5.h),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${CacheManager.getInstance()?.get<String>(ConfigString.username)} ',
                                            style: MyTextStyle.text20whiteStyle,
                                          ),
                                          Image.asset(
                                            'images/vip_grade_${model.objectData.gradeinfo.level}.png',
                                            width: 30.w,
                                            height: 24.w,
                                          ),
                                        ],
                                      )),
                                  Text(
                                    '欢迎来到我的世界~~',
                                    style: MyTextStyle.text15grayStyle,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            if (model.objectData.qiandao == 1) {
                              model.centerQiandao();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(11.w, 8.w, 8.w, 8.w),
                            decoration: BoxDecoration(
                              color: model.objectData.qiandao == 1
                                  ? const Color(0xFF36AB9C)
                                  : Colors.white.withAlpha(76),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text(
                              model.objectData.qiandao == 1
                                  ? '签到领积分'
                                  : '  已签到  ',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: model.objectData.qiandao == 1
                                      ? Colors.white
                                      : const Color(0xFFeeeeee)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.h),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/vip_bg3.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getThisWidget(model.objectData.balance, '账户(元)'),
                          Container(
                            margin: EdgeInsets.only(top: 30.h),
                            width: 1.0, // 竖线的宽度
                            height: 22.h, // 竖线的高度
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: 1.0,
                                    color: Color(0xFFDDDDDD)), // 左边的边框作为竖线
                              ),
                            ),
                          ),
                          getThisWidget(
                              '${model.objectData.youhuiquan}', '优惠券'),
                          Container(
                            margin: EdgeInsets.only(top: 30.h),
                            width: 1.0, // 竖线的宽度
                            height: 22.h, // 竖线的高度
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: 1.0,
                                    color: Color(0xFFDDDDDD)), // 左边的边框作为竖线
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigationPush(context, const PointListPage());
                            },
                            child: getThisWidget(
                              '${model.objectData.point}',
                              '积分',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 260.h,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  width: ScreenUtil().screenWidth,
                  child: Column(
                    children: [
                      Container(
                        height: 110.h,
                        decoration: myBoxDecoration(backColor: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TopSelectElevatedButton(
                                onTop: () {
                                  navigationPush(context, const MyWalletPage());
                                },
                                title: '我的钱包',
                                imageName: 'images/wallet_icon.png'),
                            TopSelectElevatedButton(
                                onTop: () {
                                  navigationPush(context, const VIPCenter());
                                },
                                title: '会员中心',
                                imageName: 'images/vip_center.png'),
                            TopSelectElevatedButton(
                                onTop: () {
                                  navigationPush(
                                      context, const ServerListPage());
                                },
                                title: '我的套餐',
                                imageName: 'images/package_name_icon.png'),
                            TopSelectElevatedButton(
                                onTop: () {
                                  navigationPush(
                                      context, const DiscountCouPonPage());
                                },
                                title: '优惠券',
                                imageName: 'images/discount_coupon_icon.png'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        height: 200.h,
                        decoration: myBoxDecoration(backColor: Colors.white),
                        child: GridView.count(
                          padding: EdgeInsets.only(top: 0.h),
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                          children: [
                            BottomSelectElevatedButton(
                                onTop: () {
                                  navigationPush(
                                      context, const OrderManagementPage());
                                },
                                title: '订单管理',
                                imageName: 'images/recharge_record_icon.png'),
                            BottomSelectElevatedButton(
                                onTop: () {
                                  navigationPush(context, const RealNamePage());
                                },
                                title: '实名认证',
                                imageName: 'images/real_name_icon.png'),
                            BottomSelectElevatedButton(
                                onTop: () {
                                  navigationPush(
                                      context, const ChangePasswordPage());
                                },
                                title: '修改密码',
                                imageName: 'images/change_password_icon.png'),
                            BottomSelectElevatedButton(
                                onTop: () {
                                  navigationPush(
                                      context, const HelpCenterPage());
                                },
                                title: '帮助中心',
                                imageName: 'images/help2_icon.png'),
                            BottomSelectElevatedButton(
                                onTop: () {
                                  if (Platform.isAndroid) {
                                    Future phonePermission =
                                        requestPhonePermission();
                                    phonePermission.then((value) => {
                                          if (value)
                                            {
                                              launchUrl(Uri.parse(
                                                  'tel:${ConfigString.phoneNumber}'))
                                            }
                                        });
                                  } else {
                                    launchUrl(Uri.parse(
                                        'tel:${ConfigString.phoneNumber}'));
                                  }
                                },
                                title: '联系客服',
                                imageName: 'images/contact_service_icon.png'),
                            BottomSelectElevatedButton(
                                onTop: () {
                                  navigationPush(
                                      context, const MyComplaintPage());
                                },
                                title: '投诉与反馈',
                                imageName: 'images/complain_icon.png'),
                            BottomSelectElevatedButton(
                                onTop: () {
                                  navigationPush(context, const AboutUsPage());
                                },
                                title: '关于四叶天',
                                imageName: 'images/in_regard_icon.png'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: ThemeTitleButton(
                            size: Size(double.infinity, 50.h),
                            backgroudColor: Colors.white,
                            title: '退出登录',
                            titleFont: 17,
                            titleColor: MyColor.desTextColor,
                            onTap: () {
                              MessageToast.alert(
                                  ConfigString.confirmMsg, context,
                                  confirm: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                  (route) => false,
                                );
                                CacheManager.clearKey(ConfigString.token);
                                CacheManager.clearKey(ConfigString.selectId);

                                // if (Platform.isAndroid) {
                                //   AndroidVpnService.stopVpn();
                                // }
                                if (Platform.isIOS) {
                                  ClashFlt.instance.stopClash();
                                }
                              });
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: ThemeTitleButton(
                            size: Size(double.infinity, 50.h),
                            backgroudColor: Colors.white,
                            title: '注销账户',
                            titleFont: 17,
                            titleColor: MyColor.desTextColor,
                            onTap: () {
                              MessageToast.alert(
                                  '注销之后将清除所有节点信息\n确定要注销么？', context,
                                  confirm: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                  (route) => false,
                                );
                                CacheManager.clearKey(ConfigString.token);
                                CacheManager.clearKey(ConfigString.selectId);
                                CacheManager.clearKey(ConfigString.phoneNum);
                                // if (Platform.isAndroid) {
                                //   AndroidVpnService.stopVpn();
                                // }
                                if (Platform.isIOS) {
                                  ClashFlt.instance.stopClash();
                                }
                                model.loginOutData(() {});
                              });
                            }),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget getThisWidget(String topNum, String botString) {
    return Column(
      children: [
        Text(
          topNum,
          style: TextStyle(fontSize: 21.sp, color: Colors.white),
        ),
        Text(
          botString,
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFFDDDDDD),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement viewModel
  PurchaseCenterModel get viewModel => PurchaseCenterModel();
}

// class PurchaseCenterPage extends StatefulWidget {
//   const PurchaseCenterPage({super.key});
//
//   @override
//   State<PurchaseCenterPage> createState() => _PurchaseCenterPageState();
// }
//
// class _PurchaseCenterPageState extends State<PurchaseCenterPage> {
//   @override
//   Widget build(BuildContext context) {

//   }
// }

/*
* ElevatedButton(
        onPressed: onTop,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: )
* */
