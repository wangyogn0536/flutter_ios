import '../../../../../project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:修改密码成功UI

class ChangePasswordSuccessPage extends StatefulWidget {
  const ChangePasswordSuccessPage({super.key});

  @override
  State<ChangePasswordSuccessPage> createState() =>
      _ChangePasswordSuccessPageState();
}

class _ChangePasswordSuccessPageState extends State<ChangePasswordSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('修改密码成功', [], isBack: false),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        padding: EdgeInsets.all(20.w),
        color: MyColor.tvDDDColor,
        child: Column(
          children: [
            Container(
              height: 230.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: myBoxDecoration(backColor: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/succeed_icon.png',
                      width: 80.w,
                      height: 80.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(
                        '修改密码成功！',
                        style: TextStyle(
                            fontSize: 18.sp, color: MyColor.themeColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ThemeTitleButton(
                size: Size(double.infinity, 50.h),
                backgroudColor: MyColor.themeColor,
                title: '返回登录',
                titleFont: 17.sp,
                titleColor: Colors.white,
                onTap: () => loginPush(context))
          ],
        ),
      ),
    );
  }
}
