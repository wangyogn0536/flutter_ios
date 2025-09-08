import 'package:agent_app_vpn/page/main/purchase_center/change_password/change_password_page_model.dart';
import 'package:agent_app_vpn/page/main/purchase_center/change_password/change_password_success/change_password_success_page.dart';
import 'package:agent_app_vpn/project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:修改密码UI

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends BaseState<ChangePasswordPageModel, ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPassword2Controller = TextEditingController();
  bool isOldVisible = false;
  bool isNewVisible = false;
  bool isNew2Visible = false;
  @override
  Widget getContentChild(ChangePasswordPageModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('修改密码', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: MyColor.tvDDDColor,
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80.h,
              decoration: myBoxDecoration(backColor: Colors.white),
              child: Center(
                child: Text(
                  '您的账号：${CacheManager.getInstance()?.get<String>(ConfigString.username)}',
                  style: MyTextStyle.text17blackStyle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w),
              child: Text(
                '旧密码',
                style: MyTextStyle.text15gray888Style,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              decoration: myBoxDecoration(backColor: Colors.white),
              child: PasswordTextFieldWidget(oldPasswordController,
                  title: '请输入旧密码', isVisible: isOldVisible),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w),
              child: Text(
                '新密码',
                style: MyTextStyle.text15gray888Style,
              ),
            ),
            Container(
              height: 101.h,
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              decoration: myBoxDecoration(backColor: Colors.white),
              child: Column(
                children: [
                  PasswordTextFieldWidget(newPasswordController,
                      title: '请输入新密码', isVisible: isNewVisible),
                  Container(
                    color: MyColor.tvDDDColor,
                    width: double.infinity - 40.w,
                    height: 1.h,
                  ),
                  PasswordTextFieldWidget(newPassword2Controller,
                      title: '请再输入新密码', isVisible: isNew2Visible),
                ],
              ),
            ),
            ThemeTitleButton(
                size: Size(double.infinity, 50.h),
                backgroudColor: MyColor.themeColor,
                title: '确定修改',
                titleFont: 17.sp,
                titleColor: Colors.white,
                onTap: () {
                  if (oldPasswordController.text == '') {
                    MessageToast.toast('请输入旧密码');
                    return;
                  }
                  if (newPasswordController.text == '') {
                    MessageToast.toast('请输入新密码');
                    return;
                  }
                  if (newPassword2Controller.text == '') {
                    MessageToast.toast('请再次输入新密码');
                    return;
                  }
                  if (newPasswordController.text !=
                      newPassword2Controller.text) {
                    MessageToast.toast('两次输入的新密码不一样');
                    return;
                  }
                  model.memberChangePassword(oldPasswordController.text,
                      newPasswordController.text, newPassword2Controller.text,
                      successOnTap: () => navigationPush(
                          context, const ChangePasswordSuccessPage()));
                })
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement viewModel
  ChangePasswordPageModel get viewModel => ChangePasswordPageModel();
}

class PasswordTextFieldWidget extends StatefulWidget {
  TextEditingController textEditingController;
  String title;
  bool isVisible;
  PasswordTextFieldWidget(this.textEditingController,
      {super.key, required this.title, required this.isVisible});

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: MyTextStyle.text15blackStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
              width: 200.w,
              child: TextField(
                controller: widget.textEditingController,
                textAlign: TextAlign.right,
                maxLines: 1,
                keyboardType: TextInputType.text,
                obscureText: !widget.isVisible,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  hintText: '6-18位数字和字母组合',
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(fontSize: 15.sp, color: MyColor.grayCCCColor),
                ),
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.isVisible = !widget.isVisible;
                  });
                },
                child: Image.asset(
                  widget.isVisible
                      ? 'images/password_visible_icon.png'
                      : 'images/password_invisible_icon.png',
                  width: 23.w,
                  height: 20.h,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
