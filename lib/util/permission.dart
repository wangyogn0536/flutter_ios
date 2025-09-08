import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../config/string.dart';

///拨打电话权限
Future<bool> requestPhonePermission() async {
  //获取当前短信的权限
  var status = await Permission.phone.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.phone.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

/// 获得手机名称
Future<String> getDeviceName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? deviceName = '';
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceName = '${androidInfo.brand}${androidInfo.model}';
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceName = iosInfo.name;
  }
  return deviceName;
}

///获得手机UUID标识
Future<String?> getUuid() async {
  final prefs = await SharedPreferences.getInstance();
  String? uuid = prefs.getString(ConfigString.uuid);
  if (uuid == null) {
    uuid = const Uuid().v4();
    await prefs.setString(ConfigString.uuid, uuid);
  }
  return uuid;
}

///获取剩余时间
String getLeaseTerm(String batteryEndDate) {
  if (batteryEndDate.isEmpty) {
    return "";
  }
  String day;
  DateTime endDate = DateTime.parse(batteryEndDate);
  DateTime startDate = DateTime.now();
  if (endDate.difference(startDate).inHours < 24) {
    day = "${endDate.difference(startDate).inHours}小时";
  } else if (endDate.difference(startDate).inMinutes < 0) {
    day = "已过期";
  } else {
    day = "${endDate.difference(startDate).inDays}天";
  }
  return day;
}

///存储权限
Future<bool> _requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return status.isGranted;
}

///获得手机剪切板权限
Future<void> requestClipboardPermission() async {
  // var status = await Permission.clipboard.status;
  // if (!status.isGranted) {
  //   await Permission.clipboard.request();
  // }
}
