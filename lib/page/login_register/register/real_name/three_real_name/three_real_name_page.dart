import '../../../../../project_imports.dart';
import '../../../login/login_page.dart';
import '../one_real_name/one_real_name_page.dart';

class ThreeRealNamePage extends StatefulWidget {
  const ThreeRealNamePage({super.key});

  @override
  State<ThreeRealNamePage> createState() => _ThreeRealNamePageState();
}

class _ThreeRealNamePageState extends State<ThreeRealNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('实名认证', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: MyColor.tvDDDColor,
        padding: EdgeInsets.all(20.w),
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
                            color: MyColor.couponColor,
                          ),
                        ),
                        TitleNumContent(
                            num: '2',
                            title: '刷脸认证',
                            color: MyColor.couponColor),
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: LineWidget(
                            width: 70.w,
                            color: MyColor.couponColor,
                          ),
                        ),
                        TitleNumContent(
                            num: '3',
                            title: '认证成功',
                            color: MyColor.couponColor),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
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
                              '恭喜您！实名认证成功',
                              style: TextStyle(
                                  fontSize: 20.sp, color: MyColor.themeColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
            ThemeTitleButton(
                size: Size(double.infinity, 50.h),
                backgroudColor: MyColor.themeColor,
                title: '返回',
                titleFont: 17.sp,
                titleColor: Colors.white,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false,
                  );
                  // CacheManager.getInstance()?.get(ConfigString.token) == null
                  //     ?
                  //     : Navigator.pushAndRemoveUntil(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const TabBarPage(),
                  //         ),
                  //         (route) => false,
                  //       );
                })
          ],
        ),
      ),
    );
  }
}
