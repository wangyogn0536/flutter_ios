import 'package:agent_app_vpn/page/login_register/register/real_name/one_real_name/one_real_name_page_model.dart';
import 'package:agent_app_vpn/page/login_register/register/real_name/three_real_name/three_real_name_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../project_imports.dart';

class OneRealNamePage extends StatefulWidget {
  const OneRealNamePage({super.key});

  @override
  State<OneRealNamePage> createState() => _OneRealNamePageState();
}

class _OneRealNamePageState
    extends BaseState<OneRealNamePageModel, OneRealNamePage> {
  bool isAlipay = true;
  bool isWechat = false;
  int certType = 0;
  Timer? timer;
  @override
  Widget getContentChild(OneRealNamePageModel model) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _identityNumController =
        TextEditingController();
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('实名认证', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        padding: EdgeInsets.all(20.w),
        color: MyColor.tvDDDColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 405.h,
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 40.h, bottom: 10.h),
              decoration: myBoxDecoration(backColor: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(bottom: 40.h),
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleNumContent(
                            num: '1',
                            title: '填写信息',
                            color: MyColor.couponColor),
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: LineWidget(
                            width: 70.w,
                            color: MyColor.grayCCCColor,
                          ),
                        ),
                        TitleNumContent(
                            num: '2',
                            title: '刷脸认证',
                            color: MyColor.grayCCCColor),
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: LineWidget(
                            width: 70.w,
                            color: MyColor.grayCCCColor,
                          ),
                        ),
                        TitleNumContent(
                            num: '3',
                            title: '认证成功',
                            color: MyColor.grayCCCColor),
                      ],
                    ),
                  ),
                  Text(
                    '请填写您的个人信息',
                    style: MyTextStyle.text15grayStyle,
                  ),
                  TextFieldWidget(_nameController,
                      title: '真实姓名', content: '请输入姓名'),
                  LineWidget(
                    width: double.infinity,
                    color: MyColor.grayCCCColor,
                  ),
                  TextFieldWidget(_identityNumController,
                      maxLength: 18, title: '身份证号码', content: '请输入身份证号码'),
                  LineWidget(
                    width: double.infinity,
                    color: MyColor.grayCCCColor,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50.h,
                    margin: EdgeInsets.only(top: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectBandwidthBtn('支付宝', isAlipay, value: 1, (value) {
                          setState(() {
                            isAlipay = true;
                            isWechat = false;
                          });
                          certType = 0;
                        },
                            selectImage: 'images/select_radio_button_icon.png',
                            image: 'images/radio_button_icon.png',
                            titleSize: 17.sp,
                            imageSize: Size(17.w, 17.w)),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: SelectBandwidthBtn('微信', isWechat, value: 1,
                              (value) {
                            setState(() {
                              isWechat = true;
                              isAlipay = false;
                            });
                            certType = 1;
                          },
                              selectImage:
                                  'images/select_radio_button_icon.png',
                              image: 'images/radio_button_icon.png',
                              titleSize: 17.sp,
                              imageSize: Size(17.w, 17.w)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ThemeTitleButton(
                size: Size(double.infinity, 50.h),
                backgroudColor: MyColor.themeColor,
                title: '前往认证',
                titleFont: 17.sp,
                titleColor: Colors.white,
                onTap: () {
                  if (_nameController.text.isEmpty) {
                    MessageToast.toast(ConfigString.inputName);
                    return;
                  }
                  if (_identityNumController.text.isEmpty) {
                    MessageToast.toast(ConfigString.inputIdentityCard);
                    return;
                  }
                  if (_identityNumController.text.length != 18) {
                    MessageToast.toast(ConfigString.inputIdentityCard);
                    return;
                  }
                  model.realNameApi(_nameController.text,
                      _identityNumController.text, '$certType', onTap: (url) {
                    launchUrl(Uri.parse(
                      url,
                    ));
                    timer = Timer.periodic(const Duration(seconds: 5),
                        (timer) => startTimer(model));
                  });
                })
          ],
        ),
      ),
    );
  }

  ///启动定时器监听功能
  void startTimer(OneRealNamePageModel model) async {
    ///请求接口
    model.checkAuthentication(onTap: () {
      stopTimer();
      navigationPush(context, const ThreeRealNamePage());
    });
  }

  ///取消定时器监听
  void stopTimer() async {
    timer?.cancel();
    timer = null;
  }

  @override
  // TODO: implement viewModel
  OneRealNamePageModel get viewModel => OneRealNamePageModel();
}

///上方头部标识封装
class TitleNumContent extends StatelessWidget {
  String num;
  String title;
  Color color;
  TitleNumContent(
      {super.key, required this.num, required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r), color: color),
          width: 30.w,
          height: 30.w,
          margin: EdgeInsets.only(bottom: 5.h),
          child: Center(
            child: Text(
              num,
              style: MyTextStyle.text15whiteStyle,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            color: color,
          ),
        ),
      ],
    );
  }
}

///下划线
class LineWidget extends StatelessWidget {
  double width;
  Color color;
  LineWidget({super.key, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width.w,
      height: 0.5.h,
    );
  }
}

///输入框的封装
class TextFieldWidget extends StatelessWidget {
  TextEditingController textEditingController;
  String title;
  String content;
  int? maxLength;
  TextFieldWidget(this.textEditingController,
      {super.key, required this.title, required this.content, this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyle.text15blackStyle,
          ),
          SizedBox(
            width: 200.w,
            height: 50.h,
            child: TextField(
              controller: textEditingController,
              textAlign: TextAlign.right,
              maxLines: 1,
              maxLength: maxLength,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                counterText: '',
                hintText: content,
                border: InputBorder.none,
                hintStyle:
                    TextStyle(fontSize: 15.sp, color: MyColor.grayCCCColor),
              ),
              style: TextStyle(fontSize: 15.sp, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
