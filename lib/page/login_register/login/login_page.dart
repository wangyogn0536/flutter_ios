import 'package:agent_app_vpn/page/login_register/forget_password/forget_password_page.dart';
import 'package:agent_app_vpn/page/login_register/login_register_backage_page.dart';
import 'package:agent_app_vpn/page/login_register/register/register_page.dart';
import 'package:agent_app_vpn/page/main/tab_bar_page.dart';
import 'package:agent_app_vpn/project_imports.dart';
import 'package:flutter/gestures.dart';

import '../register/real_name/one_real_name/one_real_name_page.dart';
import 'login_page_model.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:登陆页UI
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPageModel, LoginPage> {
  final TextEditingController _userNameController = TextEditingController(
      text: CacheManager.getInstance()?.get<String>(ConfigString.phoneNum) ==
              null
          ? ''
          : '${CacheManager.getInstance()?.get<String>(ConfigString.phoneNum)}');
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(const Duration(seconds: 1), () {
    //   if (CacheManager.getInstance()
    //           ?.get<String>(ConfigString.isPrivacyPolicy) ==
    //       null) {
    //     showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return Container(
    //             color: MyColor.alphaColor,
    //             width: ScreenUtil().screenWidth, // 屏幕宽度
    //             height: ScreenUtil().screenHeight, //
    //             child: PrivacyPolicyPopup(agreeOnTap: () {
    //               CacheManager.getInstance()
    //                   ?.set(ConfigString.isPrivacyPolicy, '1');
    //               Navigator.pop(context);
    //             }, disagreeOnTap: () {
    //               CacheManager.clear();
    //               SystemNavigator.pop();
    //             }),
    //           );
    //         });
    //   }
    // });
  }

  @override
  Widget getContentChild(model) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: LoginRegisterBackPage(
        title: '账号登录',
        distance: 130,
        backDistance: 480,
        isAgree: true,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: TextFiledStyle(
                _userNameController,
                ConfigString.inputPhoneEmail,
                false,
                TextInputType.phone,
                'images/phone_icon.png',
                maxLength: 11,
                // focusNode: _focusNode,
                isAutofocus:
                    CacheManager.getInstance()?.get(ConfigString.phoneNum) ==
                            null
                        ? true
                        : false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: TextFiledStyle(
                _passwordController,
                ConfigString.inputPasswordText,
                true,
                TextInputType.streetAddress,
                'images/password_icon.png',
                isAutofocus:
                    CacheManager.getInstance()?.get(ConfigString.phoneNum) !=
                            null
                        ? true
                        : false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 15.h, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      navigationPush(context, const ForgetPasswordPage());
                    },
                    child: Text(
                      '忘记密码？',
                      style: MyTextStyle.text15themeStyle,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: SizedBox(
                width: 310.w,
                height: 52.h,
                child: ThemeTitleButton(
                    size: Size(double.infinity, 52.h),
                    backgroudColor: MyColor.themeColor,
                    title: ConfigString.loginText,
                    titleFont: 18,
                    titleColor: Colors.white,
                    onTap: () {
                      if (_userNameController.text.isEmpty) {
                        MessageToast.toast(ConfigString.inputPhoneEmail);
                        return;
                      }
                      if (_userNameController.text.length != 11) {
                        MessageToast.toast(ConfigString.inputCorrectPhone);
                        return;
                      }
                      if (_passwordController.text.isEmpty) {
                        MessageToast.toast(ConfigString.inputPasswordText);
                        return;
                      }
                      if (!isHighlight) {
                        MessageToast.toast(ConfigString.agreeProtocol);
                        return;
                      }
                      model.loginApiManager(
                          _userNameController.text, _passwordController.text,
                          loginSuccess: () {
                        CacheManager.getInstance()?.set(
                            ConfigString.phoneNum, _userNameController.text);
                        pushNavigation();
                      }, isCert: () {
                        navigationPush(context, const OneRealNamePage());
                      });
                      // if (Platform.isAndroid) {
                      //
                      // } else {
                      //   if (isHighlight) {
                      //   } else {
                      //     MessageToast.toast(ConfigString.agreeProtocol);
                      //   }
                      // }
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: ConfigString.noIsUser,
                    style: MyTextStyle.text15grayStyle),
                TextSpan(
                    text: ConfigString.atRegister,
                    style: MyTextStyle.text15themeStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        navigationPush(context, const RegisterPage());
                      }),
              ])),
            )
          ],
        ),
      ),
    );
  }

  ///进入主页面的方法
  void pushNavigation() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const TabBarPage(),
      ),
      (route) => false,
    );
  }

  ///判定登陆参数的方法
  void loginParameters(LoginPageModel model) async {}

  @override
  // TODO: implement viewModel
  get viewModel => LoginPageModel();
}
