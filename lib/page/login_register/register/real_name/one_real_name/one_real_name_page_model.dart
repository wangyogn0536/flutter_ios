import 'package:agent_app_vpn/project_imports.dart';

class OneRealNamePageModel extends BaseViewModel {
  String AliUrl = '';

  ///认证接口
  void realNameApi(String name, String cartNo, String type, {Function? onTap}) {
    Map<String, String> params = {
      'cert_name': name,
      'cert_no': cartNo,
      'cert_type': type,
    };
    HttpManager.requestData(
        Url.aliRealName, true, params, ConfigString.requestPost,
        success: (res) {
      AliUrl = res['data']['url'];
      onTap!(res['data']['url']);
    });
  }

  ///检测是否完成认证接口
  void checkAuthentication({Function? onTap}) {
    Map<String, String> params = {};
    HttpManager.requestData(
        Url.checkAuthentication, false, params, ConfigString.requestPost,
        success: (res) {
      onTap!();
    });
  }
}
