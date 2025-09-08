import 'package:agent_app_vpn/project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:登陆页面的model
class LoginPageModel extends BaseViewModel {
  String isForce = '1';

  ///登陆接口
  void loginApiManager(String userName, String password,
      {Function? loginSuccess,
      Function? isForceLogin,
      Function? isCert}) async {
    Map<String, String> params = {
      "username": userName,
      "password": password,
      "uuid": uuid,
      "type": deviceType,
      "isforce": isForce,
      "name": name,
    };
    HttpManager.requestData(Url.login, true, params, ConfigString.requestPost,
        success: (res) {
      if (res['code'] == 666) {
        isForceLogin!();
        return;
      }
      CacheManager.getInstance()?.set(ConfigString.token, res['data']['token']);
      CacheManager.getInstance()
          ?.set(ConfigString.username, res['data']['minfo']['username']);
      CacheManager.getInstance()
          ?.set(ConfigString.serviceTel, res['data']['kf']['mobile']);
      CacheManager.getInstance()
          ?.set(ConfigString.serviceQQ, res['data']['kf']['qq']);
      CacheManager.getInstance()
          ?.set(ConfigString.serviceWechat, res['data']['kf']['img']);
      if (res['data']['minfo']['cert_is'] != 1) {
        isCert!();
      }
      CacheManager.getInstance()
          ?.set(ConfigString.isCert, res['data']['minfo']['cert_is']);
      MessageToast.toast(ConfigString.loginSuccess);
      loginSuccess!();
      notifyListeners();
    });
  }
  // ///用户协议接口
  // void userProtocol({Function? successOnTap}) {
  //   HttpManager.requestData(Url.userPolicy, true, {}, ConfigString.requestGet,
  //       success: (res) {});
  // }
  //
  // ///隐私政策接口
  // void privacyPolicy() {
  //   HttpManager.requestData(
  //       Url.webServiceTerms, true, {}, ConfigString.requestGet,
  //       success: (res) {});
  // }
}
