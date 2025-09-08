import 'package:agent_app_vpn/project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:忘记密码VM
class ForgetPasswordPageModel extends BaseViewModel {
  ///发送短信接口
  void forgetSmsSend(String phone, {Function? successTap}) {
    Map<String, String> params = {
      'phone': phone,
    };
    HttpManager.requestData(
        Url.forgetSmsSend, true, params, ConfigString.requestPost,
        success: (res) {
      successTap!();
    });
  }

  ///忘记密码接口
  void forgetMessage(
      String username, String password, String passwords, String phoneCode,
      {Function? successTap}) {
    Map<String, dynamic> params = {
      'username': username,
      'password': password,
      'passwords': passwords,
      'phone_code': phoneCode,
    };
    HttpManager.requestData(Url.forget, true, params, ConfigString.requestPost,
        success: (res) {
      successTap!();
    });
  }
}
