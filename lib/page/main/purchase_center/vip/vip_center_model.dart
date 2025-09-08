import 'package:agent_app_vpn/data/vip_list_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

class VIPCenterModel extends BaseViewModel {
  VIPInfoObjectData objectData = VIPInfoObjectData();
  @override
  void firstLoadData() {
    super.firstLoadData();
    getVIPInfo();
  }

  void getVIPInfo() {
    HttpManager.requestData(
        Url.centergetinfo, true, {}, ConfigString.requestPost, success: (res) {
      VIPInfoData vipdata = VIPInfoData.fromJson(res);
      objectData = vipdata.data;
    }, complete: () {
      notifyListeners();
    });
  }

  void getZhuce() {
    HttpManager.requestData(Url.centerzhuce, true, {}, ConfigString.requestPost,
        success: (res) {
      getVIPInfo();
    });
  }

  void getAuth() {
    HttpManager.requestData(Url.centerauth, true, {}, ConfigString.requestPost,
        success: (res) {
      getVIPInfo();
    });
  }

  void getAuthCompany() {
    HttpManager.requestData(
        Url.centerauthCompany, true, {}, ConfigString.requestPost,
        success: (res) {
      getVIPInfo();
    });
  }

  void centerQiandao() {
    HttpManager.requestData(
        Url.centerqiandao, true, {}, ConfigString.requestPost, success: (res) {
      getVIPInfo();
      eventBus.fire(PointChange('2'));
    });
  }
}
