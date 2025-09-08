import 'package:agent_app_vpn/page/login_register/login_register_backage_page.dart';
import 'package:agent_app_vpn/project_imports.dart';
import 'package:flutter/gestures.dart';

import '../login/login_page.dart';
import 'forget_password_page_model.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:忘记密码UI
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState
    extends BaseState<ForgetPasswordPageModel, ForgetPasswordPage>
    with WidgetsBindingObserver {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // //监听键盘收起参数
  // double _keyboardHeight = 0;
  //获取验证码的倒数时间
  bool _canGetCode = true;

  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
  }

  // @override
  // void didChangeMetrics() {
  //   super.didChangeMetrics();
  //   // 检查键盘高度变化
  //   final newKeyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  //   if (_keyboardHeight != newKeyboardHeight) {
  //     // setState(() {
  //     //   _keyboardHeight = newKeyboardHeight;
  //     // });
  //     // if (_keyboardHeight > 0) {
  //     //   if (_keyboardHeight > 266) {
  //     //     _keyboardHeight = 265.3;
  //     //   }
  //     // }
  //     setState(() {
  //       _keyboardHeight = newKeyboardHeight;
  //     });
  //     if (_keyboardHeight > 0) {
  //       // 键盘弹出
  //       print("Keyboard is showing.-------$_keyboardHeight");
  //       if (_keyboardHeight > 266) {
  //         _keyboardHeight = 0;
  //         return;
  //       }
  //       _keyboardHeight = 266;
  //     } else {
  //       _keyboardHeight = 0;
  //       // 键盘收起
  //       print("Keyboard is hidden.------$_keyboardHeight");
  //     }
  //     // if (_keyboardHeight > 0) {
  //     //   // 键盘弹出
  //     //   print("Keyboard is showing.-------$_keyboardHeight");
  //     //   if (_keyboardHeight > 266) {
  //     //     _keyboardHeight = 0.h;
  //     //     return;
  //     //   }
  //     //   _keyboardHeight = 266.h;
  //     // } else {
  //     //   _keyboardHeight = 0;
  //     //   // 键盘收起
  //     //   print("Keyboard is hidden.------$_keyboardHeight");
  //     // }
  //   }
  // }

//主要UI页面
  @override
  Widget getContentChild(ForgetPasswordPageModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoginRegisterBackPage(
        title: '忘记密码',
        backDistance: 480,
        // distance: 360 - _keyboardHeight,
        distance: 100,
        isAgree: false,
        child: Column(
          children: [
            Column(
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
                    isAutofocus: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TextFiledStyle(
                        _codeController,
                        ConfigString.inputCodeText,
                        false,
                        TextInputType.number,
                        'images/captcha_icon.png',
                        maxLength: 6,
                        // onTap: () {
                        //   setState(() {
                        //     _keyboardHeight = 400;
                        //   });
                        // },
                      ),
                      Positioned(
                          right: 15.w,
                          child: GestureDetector(
                            //输入框参数判定
                            onTap: _canGetCode
                                ? () {
                                    if (_userNameController.text.isEmpty) {
                                      MessageToast.toast(
                                          ConfigString.inputPhoneEmail);
                                      return;
                                    }
                                    if (_userNameController.text.length != 11) {
                                      MessageToast.toast(
                                          ConfigString.inputCorrectPhone);
                                      return;
                                    }
                                    model
                                        .forgetSmsSend(_userNameController.text,
                                            successTap: () {
                                      _startTimer();
                                    });
                                  }
                                : null,
                            child: Container(
                              width: 120.w,
                              height: 50.h,
                              color: Colors.transparent,
                              child: Center(
                                child: Text(
                                  _canGetCode
                                      ? ConfigString.againCode
                                      : '${60 - _timer!.tick ?? 0}秒后重发',
                                  style: _canGetCode
                                      ? MyTextStyle.text15themeStyle
                                      : MyTextStyle.text15grayStyle,
                                ),
                              ),
                            ),
                          ))
                    ],
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
                    isAutofocus: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: TextFiledStyle(
                    _confirmPasswordController,
                    ConfigString.inputConfirmPasswordText,
                    true,
                    TextInputType.streetAddress,
                    'images/password_icon.png',
                    isAutofocus: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: SizedBox(
                      width: 310.w,
                      height: 52.h,
                      child: ThemeTitleButton(
                          size: Size(double.infinity, 52.h),
                          backgroudColor: MyColor.themeColor,
                          title: ConfigString.confirm,
                          titleFont: 18,
                          titleColor: Colors.white,
                          onTap: () {
                            if (_userNameController.text.isEmpty) {
                              MessageToast.toast(ConfigString.inputPhoneEmail);
                              return;
                            }
                            if (_userNameController.text.length != 11) {
                              MessageToast.toast(
                                  ConfigString.inputCorrectPhone);
                              return;
                            }
                            if (_codeController.text.isEmpty) {
                              MessageToast.toast(ConfigString.inputCode);
                              return;
                            }
                            if (_codeController.text.length != 6) {
                              MessageToast.toast(ConfigString.inputCorrectCode);
                              return;
                            }
                            if (_passwordController.text.isEmpty) {
                              MessageToast.toast(
                                  ConfigString.inputPasswordText);
                              return;
                            }
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              MessageToast.toast(
                                  ConfigString.twoInputPasswordText);
                              return;
                            }
                            model.forgetMessage(
                                _userNameController.text,
                                _passwordController.text,
                                _confirmPasswordController.text,
                                _codeController.text, successTap: () {
                              MessageToast.toast('密码修改成功');
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            });
                            // navigationPush(context, const RealNamePage());
                          })),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: ConfigString.isUser,
                        style: MyTextStyle.text15grayStyle),
                    TextSpan(
                        text: ConfigString.atLogin,
                        style: MyTextStyle.text15themeStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          }),
                  ])),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ///获取验证码倒计时
  void _startTimer() {
    int seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      seconds--;
      if (seconds < 0) {
        _timer?.cancel();
        setState(() {
          _canGetCode = true;
        }); // 更新状态，触发重建界面
      } else {
        setState(() {
          _canGetCode = false;
        });
      }
    });
  }

  @override
  // TODO: implement viewModel
  ForgetPasswordPageModel get viewModel => ForgetPasswordPageModel();
}
