import 'dart:convert';

import 'package:agent_app_vpn/project_imports.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:注册的VM
class RegisterPageModel extends BaseViewModel {
  ///发送短信接口
  void registerSmsSend(String phone, String ticket, String randStr,
      {Function? successTap}) {
    Map<String, String> params = {
      "phone": phone,
      "ticket": ticket,
      "randstr": randStr
    };
    HttpManager.requestData(
        Url.registerSmsSend, true, params, ConfigString.requestPost,
        success: (res) {
      successTap!();
    });
  }

  ///苹果端接受短信接口
  void iOSRegisterSmsSend(String phone, {Function? successTap}) {
    String createTime = DateTime.now().millisecondsSinceEpoch.toString();
    String eeee =
        'phone:$phone;time:$createTime;token:kjhkldfalasdhflihgikjdolajikldsh${DateFormat('yyyyMMdd').format(DateTime.now())}';
    final bytes = utf8.encode(
        'phone:$phone;time:$createTime;token:kjhkldfalasdhflihgikjdolajikldsh${DateFormat('yyyyMMdd').format(DateTime.now())}');
    final sign = md5.convert(bytes);
    print(
        '正常的的值----------$eeee, utf8的----------$bytes,我的MD5加密------------$sign');
    final Map<String, String> params = {
      "phone": phone,
      "time": createTime,
      "sign": sign.toString(),
    };
    HttpManager.requestData(
        Url.iOSRegister, true, params, ConfigString.requestPost,
        success: (res) {
      successTap!();
    });
  }

  ///注册接口
  void registerApiManager(String userName, String password, String code,
      {Function? successOnTap}) {
    Map<String, String> params = {
      "username": userName,
      "password": password,
      "phone_code": code,
      // "uuid": uuid,
      "type": deviceType,
      // "name": name,
    };
    HttpManager.requestData(
        Url.smsRegister, true, params, ConfigString.requestPost,
        success: (res) {
      CacheManager.getInstance()?.set(ConfigString.token, res['data']['token']);
      CacheManager.getInstance()
          ?.set(ConfigString.username, res['data']['minfo']['username']);
      MessageToast.toast(ConfigString.registerSuccess);
      successOnTap!();
    });
  }
}
