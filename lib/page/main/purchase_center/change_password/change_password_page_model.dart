import 'package:agent_app_vpn/project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:修改密码VM

class ChangePasswordPageModel extends BaseViewModel {
  void memberChangePassword(
      String oldPassword, String newPassword, String newPassword2,
      {Function? successOnTap}) {
    Map<String, dynamic> params = {
      "password_old": oldPassword,
      "password_new": newPassword,
      "password_newc": newPassword2,
    };
    HttpManager.requestData(
        Url.changePassword, true, params, ConfigString.requestPost,
        success: (res) {
      successOnTap!();
    });
  }
}
