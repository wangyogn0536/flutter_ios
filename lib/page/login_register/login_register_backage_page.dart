import 'package:flutter/gestures.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

import '../../project_imports.dart';
import '../../util/permission.dart';
import '../../widgets/my_web_view.dart';
import '../main/home/home_page.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:登录页面全局封装，后面登录，注册，忘记密码都从这里调用
bool isHighlight = false;
final flutterV2ray = FlutterV2ray(onStatusChanged: (V2RayStatus status) {
  v2rayStatus.value = status;
});

class LoginRegisterBackPage extends StatefulWidget {
  final Widget child;
  final String title;
  final double distance;
  final int backDistance;
  final bool isAgree;
  const LoginRegisterBackPage({
    super.key,
    required this.child,
    required this.title,
    required this.backDistance,
    required this.distance,
    required this.isAgree,
  });
  @override
  State<LoginRegisterBackPage> createState() => _LoginRegisterBackPageState();
}

class _LoginRegisterBackPageState extends State<LoginRegisterBackPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: widget.backDistance.h,
                  color: MyColor.darkSurfaceColor,
                  child: Stack(
                    children: [
                      Center(
                        child: Image(
                          image: const AssetImage('images/logo_2.png'),
                          width: 300.w,
                          height: 180.h,
                        ),
                      ),
                      Positioned(
                        bottom: 50.w,
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().screenWidth,
                          height: 70.h,
                          child: Image.asset(
                            'images/backgroud_icon.jpg',
                            width: 260.w,
                            height: 70.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: MyColor.tvDDDColor,
                  child: widget.isAgree
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 40.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isHighlight = !isHighlight;
                                        if (isHighlight) {
                                          getDeviceName().then((deviceName) =>
                                              CacheManager.getInstance()?.set(
                                                  ConfigString.deviceName,
                                                  deviceName));
                                          getUuid().then((uuid) =>
                                              CacheManager.getInstance()?.set(
                                                  ConfigString.uuid, uuid!));
                                        } else {
                                          CacheManager.clearKey(
                                              ConfigString.deviceName);
                                          CacheManager.clearKey(
                                              ConfigString.uuid);
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 25.w,
                                      height: 20.h,
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: Icon(
                                        isHighlight
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        size: 18.0,
                                        color: isHighlight
                                            ? MyColor.themeColor
                                            : MyColor.grayCCCColor,
                                      ),
                                    ),
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: ConfigString.loginAgree,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '《${ConfigString.userProtocol}》',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: MyColor.themeColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            navigationPush(
                                                context,
                                                const WebViewPage(
                                                  'https://api.s10.cn/v2/help/service',
                                                  // 'https://baidu.com',
                                                  ConfigString.userProtocol,
                                                  isPodding: true,
                                                ));
                                          }),
                                    TextSpan(
                                        text: '和',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '《${ConfigString.privacyPolicy}》',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: MyColor.themeColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            navigationPush(
                                                context,
                                                const WebViewPage(
                                                  'https://api.s10.cn/v2/help/policy',
                                                  ConfigString.privacyPolicy,
                                                  isPodding: true,
                                                ));
                                            // model.privacyPolicy();
                                          }),
                                  ])),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const Center(),
                )),
              ],
            ),
            Positioned(
                bottom: widget.distance.h,
                child: Container(
                  width: ScreenUtil().screenWidth,
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    width: 340.w,
                    decoration: myBoxDecoration(backColor: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 21.sp, color: MyColor.themeColor),
                        ),
                        widget.child,
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}

class TextFiledStyle extends StatelessWidget {
  final TextEditingController _textEditingController;
  final String title;
  final bool isObscureText;
  final int maxLength;
  final TextInputType textInputType;
  final String imageAsset;
  final bool isAutofocus;
  FocusNode? focusNode;
  final VoidCallback? onTap;
  TextFiledStyle(this._textEditingController, this.title, this.isObscureText,
      this.textInputType, this.imageAsset,
      {super.key,
      this.maxLength = 60,
      this.focusNode,
      this.isAutofocus = false,
      this.onTap});
  final List<ContextMenuButtonItem> menuItems = [
    ContextMenuButtonItem(
      type: ContextMenuButtonType.cut,
      label: '剪切',
      onPressed: () {
        // 剪切操作
      },
    ),
    ContextMenuButtonItem(
      type: ContextMenuButtonType.copy,
      label: '复制',
      onPressed: () {
        // 复制操作
      },
    ),
    ContextMenuButtonItem(
      type: ContextMenuButtonType.paste,
      label: '粘贴',
      onPressed: () {
        // 粘贴操作
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      alignment: Alignment.center,
      height: 53.h,
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      child: TextField(
        focusNode: focusNode,
        onTap: onTap,
        textAlignVertical: TextAlignVertical.bottom,
        controller: _textEditingController,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.black, fontSize: 17.sp),
        maxLines: 1,
        autofocus: false,
        cursorColor: MyColor.themeColor,
        keyboardType: textInputType,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          counterText: '', //取消字符显示下标
          hintStyle: TextStyle(fontSize: 17.sp, color: Colors.grey),
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0.r), // 边框的圆角
          ),
          // 设置背景颜色
          filled: true,
          fillColor: Colors.white,
          // 设置前置图标
          prefixIcon: Image(
            image: AssetImage(imageAsset),
            width: 51.w,
            height: 20.h,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 51.w, // 图标最小宽度
            minHeight: 20.h, // 图标最小高度
          ),
          //设置焦点边框
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: MyColor.tvDDDColor, width: 1.0),
          ),

          //设置未焦点边框
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: MyColor.tvDDDColor, width: 1.0),
          ),
        ),
        maxLength: maxLength,
        obscureText: isObscureText,
        contextMenuBuilder:
            (BuildContext context, EditableTextState editableTextState) {
          return AdaptiveTextSelectionToolbar.editableText(
            editableTextState: editableTextState,
            // 可以在这里添加自定义按钮

            // items: <ContextMenuButtonItem>[
            //   ContextMenuButtonItem(
            //     type: ContextMenuButtonType.cut,
            //     label: '剪切', // 自定义文本
            //   ),
            //   ContextMenuButtonItem(
            //     type: ContextMenuButtonType.copy,
            //     label: '复制', // 自定义文本
            //   ),
            //   ContextMenuButtonItem(
            //     type: ContextMenuButtonType.paste,
            //     label: '粘贴', // 自定义文本
            //   ),
            //   ContextMenuButtonItem(
            //     type: ContextMenuButtonType.selectAll,
            //     label: '选择全部', // 自定义文本
            //   ),
            // ],
          );
        },
      ),
    );
  }
}

///安卓版本的用户协议和隐私政策
// class PrivacyPolicyPopup extends StatefulWidget {
//   final VoidCallback agreeOnTap;
//   final VoidCallback disagreeOnTap;
//   const PrivacyPolicyPopup(
//       {super.key, required this.agreeOnTap, required this.disagreeOnTap});
//
//   @override
//   State<PrivacyPolicyPopup> createState() => _PrivacyPolicyPopupState();
// }
//
// class _PrivacyPolicyPopupState extends State<PrivacyPolicyPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       margin:
//           EdgeInsets.only(top: 160.h, bottom: 160.h, left: 40.w, right: 40.w),
//       padding: EdgeInsets.all(20.w),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             '四叶天用户协议与隐私政策',
//             style: MyTextStyle.text20blackStyle,
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 40.h),
//             child: RichText(
//               text: TextSpan(children: [
//                 TextSpan(
//                   text:
//                       '     感谢您使用四叶天APP，在您使用本软件过程中，我们可能会对您的部分个人信息进行收集和使用。请您仔细阅读《',
//                   style: MyTextStyle.text15blackStyle,
//                 ),
//                 TextSpan(
//                     text: ConfigString.userProtocol,
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: MyColor.themeColor,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         navigationPush(
//                             context,
//                             const WebViewPage(
//                               'https://api.s10.cn/v2/help/service',
//                               ConfigString.userProtocol,
//                               isPodding: true,
//                             ));
//                       }),
//                 TextSpan(
//                   text: '》与《',
//                   style: MyTextStyle.text15blackStyle,
//                 ),
//                 TextSpan(
//                     text: ConfigString.privacyPolicy,
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: MyColor.themeColor,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         navigationPush(
//                             context,
//                             const WebViewPage(
//                               'https://api.s10.cn/v2/help/policy',
//                               ConfigString.privacyPolicy,
//                               isPodding: true,
//                             ));
//                       }),
//                 TextSpan(
//                   text:
//                       '》，并确定完全了解我们对您个人信息的处理规则。如您同意《用户协议》与《隐私政策》，请点击“同意”开始使用四叶天代理IP，我们会保护您的个人信息安全。',
//                   style: MyTextStyle.text15blackStyle,
//                 ),
//               ]),
//             ),
//           ),
//
//           /// title: ConfigString.registerText,
//           //                           titleFont: 18,
//           //                           titleColor: Colors.white,
//           Padding(
//             padding: EdgeInsets.only(top: 90.h),
//             child: ThemeTitleButton(
//                 size: Size(250.w, 50.h),
//                 backgroudColor: MyColor.themeColor,
//                 title: '同意',
//                 titleFont: 18,
//                 titleColor: Colors.white,
//                 onTap: widget.agreeOnTap),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 20.h),
//             child: ThemeTitleButton(
//                 size: Size(250.w, 50.h),
//                 backgroudColor: MyColor.tvDDDColor,
//                 title: '不同意',
//                 titleFont: 18,
//                 titleColor: Colors.black,
//                 onTap: widget.disagreeOnTap),
//           ),
//         ],
//       ),
//     );
//   }
// }
