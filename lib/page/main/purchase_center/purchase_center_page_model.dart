import 'package:agent_app_vpn/data/vip_list_entity.dart';

import '../../../../project_imports.dart';

class PurchaseCenterModel extends BaseViewModel {
  VIPInfoObjectData objectData = VIPInfoObjectData();
  void loginOutData(Function successTap) {
    HttpManager.requestData(Url.loginOut, true, {}, ConfigString.requestPost,
        success: (res) {
      successTap();
    });
  }

  @override
  void firstLoadData() {
    super.firstLoadData();
    getVIPInfo(false);

    eventBus.on<PointChange>().listen((onData) {
      debugPrint('eventBus========${onData.point}');
      if (onData.point == '2') {
        getVIPInfo(false);
      }
    });
  }

  void getVIPInfo(bool isshow) {
    HttpManager.requestData(
        Url.centergetinfo, isshow, {}, ConfigString.requestPost,
        success: (res) {
      VIPInfoData vipdata = VIPInfoData.fromJson(res);
      objectData = vipdata.data;
    }, complete: () {
      notifyListeners();
    });
  }

  void centerQiandao() {
    HttpManager.requestData(
        Url.centerqiandao, true, {}, ConfigString.requestPost, success: (res) {
      getVIPInfo(true);
    });
  }
}
