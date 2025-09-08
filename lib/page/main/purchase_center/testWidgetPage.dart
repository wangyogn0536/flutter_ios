import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../project_imports.dart';

class TestWidgetPage extends StatefulWidget {
  const TestWidgetPage({super.key});

  @override
  State<TestWidgetPage> createState() => _TestWidgetPageState();
}

class _TestWidgetPageState extends State<TestWidgetPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardAvoider(
          autoScroll: true,
          child: Container(
            height: 50.h,
            color: Colors.blue,
            margin: EdgeInsets.only(top: 600.h),
            child: TextField(
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                hintText: '请输入内容',
              ),
            ),
          )),
    );
  }
}
