import 'package:agent_app_vpn/project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:主页的VM
Function? hotOnTap;

class HomePageModel extends BaseViewModel {
  //总的ip数量
  int ipCount = 0;
  //到期的ip数量
  int? isDaoqiCount = 0;
  //活动展示页
  bool isHot = false;
  String money = ''; //显示用户余额
  int month = 1;
  // int? daikuan;
  String timeEnd = ''; //有效期
  // ServerInfoBeanEntity? serverInfoBeanEntity;

  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
    rectDetectionApiManager();
    if (CacheManager.getInstance()!.get(ConfigString.selectId) != null) {
      serverContent(
          '${CacheManager.getInstance()!.get(ConfigString.selectId)}');
    }
  }

  ///获取城市列表
  void rectDetectionApiManager() async {
    HttpManager.requestData(
        Url.rectDetection2,
        true,
        {
          'version': CacheManager.getInstance()?.get(ConfigString.version),
          'type': '4'
        },
        ConfigString.requestPost, success: (res) {
      ipCount = res['data']['ipcount'];
      isDaoqiCount = res['data']['isDaoqiCount'];
      CacheManager.getInstance()?.set(ConfigString.isHot, res['data']['isHot']);
      CacheManager.getInstance()
          ?.set(ConfigString.versionDiff, res['data']['version_diff']);
      CacheManager.getInstance()
          ?.set(ConfigString.onlineVersion, res['data']['version']);
      CacheManager.getInstance()
          ?.set(ConfigString.isForcedReturn, res['data']['isForcedReturn']);
    }, complete: () {
      notifyListeners();
    });
  }

  ///开启vpn接口
  void userStartVpn(int id, int type, Function successOnTop) {
    HttpManager.requestData(Url.useStart, true, {'startid': id, 'type': type},
        ConfigString.requestPost, success: (res) {
      if (res['data']['istrue'] == true) {
        successOnTop();
      } else {
        MessageToast.toast(res['info']);
      }
      notifyListeners();
    });
  }

  ///断开vpn接口
  void userEndVpn(int id, Function endOnTop) {
    HttpManager.requestData(
        Url.useEnd, true, {'endid': id}, ConfigString.requestPost,
        success: (res) {
      endOnTop();
      notifyListeners();
    });
  }

  // ///主页面节点信息接口
  void serverContent(String id) {
    HttpManager.requestData(
        Url.serverContent, false, {'id': id}, ConfigString.requestPost,
        success: (res) {
      // daikuan = res['data']['daikuan'];
      timeEnd = res['data']['time_end'];
    }, complete: () {
      notifyListeners();
    });
  }

  /// 获取用户信息余额接口
  void memberInfoAPI(Function successTap) {
    HttpManager.requestData(Url.memberInfo, true, {}, ConfigString.requestPost,
        success: (res) {
      money = res['data']['balance'];
      successTap();
      notifyListeners();
    }, complete: () {
      notifyListeners();
    });
  }

//   ///获取价格接口
//   void getPrice(List<int> orderIdList, {Function? isPops}) {
//     HttpManager.requestData(
//         Url.renewPrice,
//         true,
//         {
//           'order_id': orderIdList,
//           'month': month,
//         },
//         ConfigString.requestPost, success: (res) {
//       isPops!(res['data']['price']);
//       notifyListeners();
//     });
//   }
}
