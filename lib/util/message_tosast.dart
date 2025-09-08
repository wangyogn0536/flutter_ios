import 'package:agent_app_vpn/project_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:公共使用的toast和苹果端提示弹窗
class MessageToast {
  static toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static topToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static alert(String msg, BuildContext context,
      {Function? callback, Function? confirm}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: CupertinoAlertDialog(
              title: const Text("提示"),
              content: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(msg),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(
                    "取消",
                    style:
                        TextStyle(color: MyColor.desTextColor, fontSize: 15.sp),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    callback!();
                  },
                ),
                CupertinoDialogAction(
                    child: Text(
                      "确定",
                      style: MyTextStyle.text15BlueStyle,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      confirm!();
                    })
              ]),
        );
      },
    );
  }

  static noCancelAlert(String title, String msg, BuildContext context,
      {Function? confirm}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: CupertinoAlertDialog(
              title: Text(
                title,
                style: TextStyle(fontSize: 20.sp),
              ),
              content: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(msg),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: Text(
                      "确定",
                      style: MyTextStyle.text15BlueStyle,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      confirm!();
                    })
              ]),
        );
      },
    );
  }

  // static snack(String msg, BuildContext context) {
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //     action: SnackBarAction(
  //       label: "关闭",
  //       onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
  //     ),
  //   ));
  // }
}
