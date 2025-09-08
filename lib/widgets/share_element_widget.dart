import '../page/login_register/login/login_page.dart';
import '../project_imports.dart';

///公共使用的AppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool isBack;
  const CustomAppBar(
    this.title,
    this.actions, {
    super.key,
    required this.isBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: MyColor.gray333Color,
      title: Text(
        title,
        style: MyTextStyle.text20whiteStyle,
      ),
      leading: isBack
          ? IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Image.asset(
                'images/left_arrow_icon.png',
                width: 23.51.w,
                height: 24.78.h,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}

///全局的Container的样式
BoxDecoration myBoxDecoration({
  Color? backColor,
}) {
  return BoxDecoration(
      color: backColor!,
      borderRadius: BorderRadius.circular(2.5.r),
      boxShadow: [
        BoxShadow(
          color: MyColor.gray333Color.withAlpha(25), // 阴影颜色，这里使用了半透明的灰色
          offset: const Offset(1, 1), // 阴影偏移量，水平向右3px，垂直向下3px
          blurRadius: 1.0, // 阴影的模糊半径
          spreadRadius: 2.0, //
        )
      ]);
}

///公共使用的选择带宽控件
class SelectBandwidthBtn extends StatelessWidget {
  final String title;
  final int value;
  final ValueChanged<int> onChanged;
  final bool isHighlight;
  final String selectImage;
  final String image;
  final double titleSize;
  final Size imageSize;
  const SelectBandwidthBtn(this.title, this.isHighlight, this.onChanged,
      {super.key,
      required this.selectImage,
      required this.value,
      required this.image,
      required this.titleSize,
      required this.imageSize});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(isHighlight ? selectImage : image),
              width: imageSize.width,
              height: imageSize.height,
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: Text(
                title,
                style: isHighlight
                    ? TextStyle(
                        fontSize: titleSize.sp, color: MyColor.themeColor)
                    : TextStyle(
                        fontSize: titleSize.sp, color: MyColor.gray555Color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///全局跳转页面
Future<void> navigationPush(BuildContext context, Widget widget) async =>
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));

///跳转到登录页面
Future<void> loginPush(BuildContext context) async {
  await Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
    (route) => false,
  );
}

///全局的文字点击按钮
class ThemeTitleButton extends StatelessWidget {
  Size size;
  Color backgroudColor;
  String title;
  double titleFont;
  Color titleColor;
  VoidCallback onTap;
  ThemeTitleButton(
      {super.key,
      required this.size,
      required this.backgroudColor,
      required this.title,
      required this.titleFont,
      required this.titleColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: FloatingActionButton(
          backgroundColor: backgroudColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontSize: titleFont.sp,
              color: titleColor,
            ),
          ),
        ));
  }
}

///暂定下方模态弹窗
///付款模态弹窗
class showDialogWidget extends StatefulWidget {
  Widget widget;
  showDialogWidget(this.widget, {super.key});

  @override
  State<showDialogWidget> createState() => _showDialogWidgetState();
}

class _showDialogWidgetState extends State<showDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Center(),
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: widget.widget)
      ],
    );
  }
}

///上面选择按键
class TopSelectElevatedButton extends StatelessWidget {
  final VoidCallback onTop;
  final String title;
  final String imageName;
  const TopSelectElevatedButton({
    super.key,
    required this.onTop,
    required this.title,
    required this.imageName,
  });
  @override
  Widget build(BuildContext context) {
    return SelectElevatedButton(
        onTop: onTop,
        title: title,
        imageName: imageName,
        imageSize: const Size(40, 40));
  }
}

///下面选择按键

class BottomSelectElevatedButton extends StatelessWidget {
  final VoidCallback onTop;
  final String title;
  final String imageName;
  const BottomSelectElevatedButton(
      {super.key,
      required this.onTop,
      required this.title,
      required this.imageName});
  @override
  Widget build(BuildContext context) {
    return SelectElevatedButton(
        onTop: onTop,
        title: title,
        imageName: imageName,
        imageSize: const Size(30, 30));
  }
}

///个人中心选择按键
class SelectElevatedButton extends StatelessWidget {
  final VoidCallback onTop;
  final String title;
  final String imageName;
  final Size imageSize;
  const SelectElevatedButton(
      {super.key,
      required this.onTop,
      required this.title,
      required this.imageName,
      required this.imageSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: FloatingActionButton(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        onPressed: onTop,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageName,
              width: imageSize.width,
              height: imageSize.height,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                title,
                style: MyTextStyle.text15blackStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

///推出登录
