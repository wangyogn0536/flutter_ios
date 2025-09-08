import 'dart:convert';
import 'dart:io';

import 'package:agent_app_vpn/page/login_register/login_register_backage_page.dart';
import 'package:agent_app_vpn/page/login_register/register/real_name/one_real_name/one_real_name_page.dart';
import 'package:agent_app_vpn/page/main/tab_bar_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../project_imports.dart';
import 'register_page_model.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:注册页UI
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPageModel, RegisterPage>
    with WidgetsBindingObserver {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double _keyboardHeight = 0;
  WebViewController? webViewController;
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
  //     setState(() {
  //       _keyboardHeight = newKeyboardHeight;
  //     });
  //     if (_keyboardHeight > 0) {
  //       // 键盘收起
  //       print("键盘收起.-------$_keyboardHeight");
  //       if (_keyboardHeight > 266) {
  //         _keyboardHeight = 0;
  //         return;
  //       }
  //       _keyboardHeight = 266;
  //     } else {
  //       _keyboardHeight = 0;
  //       // 键盘弹出
  //       print("键盘弹出.------$_keyboardHeight");
  //     }
  //   }
  // }

  @override
  Widget getContentChild(RegisterPageModel model) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoginRegisterBackPage(
          title: '账号注册',
          // distance: 370 - _keyboardHeight,
          distance: 120,
          backDistance: 480,
          isAgree: true,
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
                          onTap: () {
                            setState(() {
                              _keyboardHeight = 400.h;
                            });
                          },
                        ),
                        Positioned(
                            right: 15.w,
                            child: GestureDetector(
                              onTap: _canGetCode
                                  ? () {
                                      if (_userNameController.text.length !=
                                          11) {
                                        MessageToast.toast(
                                            ConfigString.inputCorrectPhone);
                                        return;
                                      }
                                      if (Platform.isAndroid) {
                                        _showWebViewPopup(context,
                                            successTap: (messageData) {
                                          model.registerSmsSend(
                                              _userNameController.text,
                                              messageData['ticket'],
                                              messageData['randstr'],
                                              successTap: () {
                                            _startTimer();
                                          });
                                        });
                                      }
                                      if (Platform.isIOS) {
                                        model.iOSRegisterSmsSend(
                                            _userNameController.text,
                                            successTap: () {
                                          _startTimer();
                                        });
                                      }
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
                    child: SizedBox(
                        width: 310.w,
                        height: 52.h,
                        child: ThemeTitleButton(
                            size: Size(double.infinity, 52.h),
                            backgroudColor: MyColor.themeColor,
                            title: ConfigString.registerText,
                            titleFont: 18,
                            titleColor: Colors.white,
                            onTap: () {
                              if (isHighlight) {
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
                                if (_codeController.text.isEmpty) {
                                  MessageToast.toast(ConfigString.inputCode);
                                  return;
                                }
                                if (_codeController.text.length != 6) {
                                  MessageToast.toast(
                                      ConfigString.inputCorrectCode);
                                  return;
                                }
                                if (_passwordController.text.isEmpty) {
                                  MessageToast.toast(
                                      ConfigString.inputPasswordText);
                                  return;
                                }
                                if (!isHighlight) {
                                  MessageToast.toast(
                                      ConfigString.agreeProtocol);
                                  return;
                                }
                                model.registerApiManager(
                                    _userNameController.text,
                                    _passwordController.text,
                                    _codeController.text, successOnTap: () {
                                  MessageToast.alert('您还未实名认证是否实名认证', context,
                                      callback: () {
                                    navigationPush(context, const TabBarPage());
                                  }, confirm: () {
                                    navigationPush(
                                        context, const OneRealNamePage());
                                  });
                                });
                              } else {
                                MessageToast.toast(ConfigString.agreeProtocol);
                              }
                            })
                        // ElevatedButton(
                        //     onPressed: () {
                        //
                        //
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //         foregroundColor: Colors.white,
                        //         backgroundColor: MyColor.themeColor,
                        //         textStyle: TextStyle(fontSize: 18.sp),
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(2.0))),
                        //     child: const Text(ConfigString.registerText)),
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
          )),
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

  void _showWebViewPopup(BuildContext context, {Function? successTap}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WebView(
          backgroundColor: Colors.transparent,
          initialUrl: 'https://a.com/captcha.html', // 线上页面路径
          onWebViewCreated: (WebViewController webViewController) {
            this.webViewController = webViewController;
            _loadHtmlFromAssets(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: {
            JavascriptChannel(
              name: 'FlutterJSBridge',
              onMessageReceived: (JavascriptMessage message) {
                // _startTimer();
                print("captcha callback：" + message.message);
                Map<String, dynamic> messageData = json.decode(message.message);
                Navigator.pop(context);
                successTap!(messageData);
              },
            ),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('data:')) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        );
      },
    );
  }

  // 这个方法用于从assets读取HTML文件，并用'data:'URI加载到WebView。
  Future<void> _loadHtmlFromAssets(WebViewController controller) async {
    String fileText = await rootBundle.loadString('assets/captcha.html');
    final String contentBase64 = base64Encode(Utf8Encoder().convert(fileText));
    controller.loadUrl('data:text/html;base64,$contentBase64');
  }

  @override
  // TODO: implement viewModel
  RegisterPageModel get viewModel => RegisterPageModel();
}
/*

* */
