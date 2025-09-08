import 'package:agent_app_vpn/page/login_register/forget_password/forget_password_page.dart'; // 导入忘记密码页面，用于点击“忘记密码？”时跳转
import 'package:agent_app_vpn/page/login_register/login_register_backage_page.dart'; // 导入登录注册背景页面，提供统一的背景UI
import 'package:agent_app_vpn/page/login_register/register/register_page.dart'; // 导入注册页面，用于点击“注册”时跳转
import 'package:agent_app_vpn/page/main/tab_bar_page.dart'; // 导入主页面的底部导航栏页面，登录成功后跳转
import 'package:agent_app_vpn/project_imports.dart'; // 导入项目公共资源，如颜色、样式、工具类等
import 'package:flutter/gestures.dart'; // 导入手势识别，用于文本点击事件

import '../register/real_name/one_real_name/one_real_name_page.dart'; // 导入实名认证页面，登录后如果需要实名认证则跳转
import 'login_page_model.dart'; // 导入登录页面的业务逻辑模型

/// 登录页组件，负责账号登录的UI展示和交互逻辑
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// 登录页状态类，管理登录页面的状态和业务逻辑
class _LoginPageState extends BaseState<LoginPageModel, LoginPage> {
  // 用户名输入框控制器，初始化时尝试从缓存读取上次登录的手机号，如果没有则为空字符串
  final TextEditingController _userNameController = TextEditingController(
      text: CacheManager.getInstance()?.get<String>(ConfigString.phoneNum) ==
              null
          ? ''
          : '${CacheManager.getInstance()?.get<String>(ConfigString.phoneNum)}');
  // 密码输入框控制器，初始化为空
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 以下注释代码为隐私政策弹窗逻辑：
    // 在页面加载1秒后检测缓存中是否同意过隐私政策，
    // 如果未同意则弹出隐私政策弹窗，用户同意则缓存标记，
    // 不同意则清除缓存并退出应用。
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
      resizeToAvoidBottomInset: true, // 避免键盘弹起遮挡内容
      backgroundColor: Colors.white,
      body: LoginRegisterBackPage(
        title: '账号登录', // 页面标题
        distance: 130, // 内容距离顶部的距离
        backDistance: 480, // 背景图片距离顶部的距离
        isAgree: true, // 是否默认同意协议
        child: Column(
          children: [
            // 用户名输入框区域
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: TextFiledStyle(
                _userNameController,
                ConfigString.inputPhoneEmail, // 提示文本：请输入手机号或邮箱
                false, // 不隐藏输入
                TextInputType.phone, // 输入类型为手机号
                'images/phone_icon.png', // 左侧图标
                maxLength: 11, // 最大输入长度11位
                // 是否自动聚焦，如果缓存中无手机号则自动聚焦
                isAutofocus:
                    CacheManager.getInstance()?.get(ConfigString.phoneNum) ==
                            null
                        ? true
                        : false,
              ),
            ),
            // 密码输入框区域
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: TextFiledStyle(
                _passwordController,
                ConfigString.inputPasswordText, // 提示文本：请输入密码
                true, // 隐藏输入内容
                TextInputType.streetAddress, // 输入类型为地址（用于密码输入）
                'images/password_icon.png', // 左侧图标
                // 是否自动聚焦，如果缓存中有手机号则自动聚焦密码输入框
                isAutofocus:
                    CacheManager.getInstance()?.get(ConfigString.phoneNum) !=
                            null
                        ? true
                        : false,
              ),
            ),
            // 忘记密码按钮区域，右对齐
            Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 15.h, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // 点击跳转到忘记密码页面
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
            // 登录按钮区域
            Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: SizedBox(
                width: 310.w,
                height: 52.h,
                child: ThemeTitleButton(
                    size: Size(double.infinity, 52.h),
                    backgroudColor: MyColor.themeColor, // 按钮背景色
                    title: ConfigString.loginText, // 按钮文字“登录”
                    titleFont: 18,
                    titleColor: Colors.white,
                    onTap: () {
                      // 点击登录按钮时的输入验证逻辑

                      // 1. 判断用户名是否为空
                      if (_userNameController.text.isEmpty) {
                        MessageToast.toast(ConfigString.inputPhoneEmail);
                        return;
                      }
                      // 2. 判断用户名长度是否为11位（手机号长度）
                      if (_userNameController.text.length != 11) {
                        MessageToast.toast(ConfigString.inputCorrectPhone);
                        return;
                      }
                      // 3. 判断密码是否为空
                      if (_passwordController.text.isEmpty) {
                        MessageToast.toast(ConfigString.inputPasswordText);
                        return;
                      }
                      // 4. 判断是否同意协议（isHighlight为协议勾选状态）
                      if (!isHighlight) {
                        MessageToast.toast(ConfigString.agreeProtocol);
                        return;
                      }
                      // 调用登录接口，传入用户名和密码
                      model.loginApiManager(
                          _userNameController.text, _passwordController.text,
                          loginSuccess: () {
                        // 登录成功后缓存手机号
                        CacheManager.getInstance()?.set(
                            ConfigString.phoneNum, _userNameController.text);
                        // 跳转到主页面
                        pushNavigation();
                      }, isCert: () {
                        // 如果需要实名认证则跳转实名认证页面
                        navigationPush(context, const OneRealNamePage());
                      });
                      // 以下为平台相关注释代码，暂时未启用
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
            // 注册提示区域，显示“还不是用户？注册”并支持点击跳转注册页面
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: ConfigString.noIsUser,
                    style: MyTextStyle.text15grayStyle), // “还不是用户？”
                TextSpan(
                    text: ConfigString.atRegister,
                    style: MyTextStyle.text15themeStyle, // “注册”
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // 点击跳转注册页面
                        navigationPush(context, const RegisterPage());
                      }),
              ])),
            )
          ],
        ),
      ),
    );
  }

  /// 跳转到主页面并移除所有之前的路由，防止返回登录页
  void pushNavigation() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const TabBarPage(), // 主页面底部导航栏
      ),
      (route) => false, // 移除所有旧路由
    );
  }

  /// 预留的登录参数判定方法，目前未实现
  void loginParameters(LoginPageModel model) async {}

  @override
  // TODO: implement viewModel
  get viewModel => LoginPageModel();
}
