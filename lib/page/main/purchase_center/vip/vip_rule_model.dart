import 'package:agent_app_vpn/data/vip_list_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

class VIPRuleModel extends BaseViewModel {
  List<VIPRuleData> dataList = [];
  @override
  void firstLoadData() {
    super.firstLoadData();
    getVIPRules();
  }

  void getVIPRules() {
    HttpManager.requestData(Url.centerrules, true, {}, ConfigString.requestPost,
        success: (res) {
      VIPRuleListData vipdata = VIPRuleListData.fromJson(res);
      dataList.addAll(vipdata.data);
    }, complete: () {
      notifyListeners();
    });
  }
}
