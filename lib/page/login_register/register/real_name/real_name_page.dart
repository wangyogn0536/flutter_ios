import '../../../../project_imports.dart';
import 'one_real_name/one_real_name_page.dart';

class RealNamePage extends StatefulWidget {
  const RealNamePage({super.key});

  @override
  State<RealNamePage> createState() => _RealNamePageState();
}

class _RealNamePageState extends State<RealNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        '实名认证',
        [],
        isBack: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        color: MyColor.tvDDDColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ElevatedButtons(
            //   imageText: 'images/real_name_authetication_icon.png',
            //   title: ConfigString.realNameAutheticationText,
            //   delTitle: '填写姓名、身份证、手机号后提交',
            //   backColor: MyColor.realNameColor,
            //   onTop: () {
            //     print('我进入实名认证');
            //   },
            // ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: ElevatedButtons(
                backColor: MyColor.humanFaceColor,
                imageText: 'images/face_identification_icon.png',
                title: ConfigString.faceIdentificationText,
                delTitle: '填写信息后，根据提示刷脸认证',
                onTop: () {
                  // navigationPush(context, const OneRealNamePage());
                  CacheManager.getInstance()?.get(ConfigString.isCert) != 1
                      ? navigationPush(context, const OneRealNamePage())
                      : MessageToast.toast('您已实名认证请勿重复实名');
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 50.h),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white, // 背景颜色
                borderRadius: BorderRadius.circular(2.r),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.gray333Color
                        .withOpacity(0.1), // 阴影颜色，这里使用了半透明的灰色
                    offset: const Offset(1, 1), // 阴影偏移量，水平向右3px，垂直向下3px
                    blurRadius: 1.0, // 阴影的模糊半径
                    spreadRadius: 1.0, //偏移量
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '实名认证说明',
                    style: MyTextStyle.text20blackStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Text(
                      '1、根据国家政策要求，请进行实名认证 \n2、个人信息不做保留或其他用途; \n3、请确认你的身份证、手机号、姓名为同一人。',
                      style: MyTextStyle.text15grayStyle,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ElevatedButtons extends StatelessWidget {
  String imageText;
  String title;
  String delTitle;
  VoidCallback onTop;
  Color backColor;
  ElevatedButtons(
      {super.key,
      required this.imageText,
      required this.title,
      required this.delTitle,
      required this.backColor,
      required this.onTop});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: backColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0), // 圆角大小
              )),
          onPressed: onTop,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageText,
                width: 66.w,
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MyTextStyle.text20blackStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.w),
                      child: Text(
                        delTitle,
                        style: MyTextStyle.text15grayStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
