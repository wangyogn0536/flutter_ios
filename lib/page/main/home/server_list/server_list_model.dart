import 'package:agent_app_vpn/data/server_list_bean_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

import '../../../../data/area_list_bean_entity.dart';
import '../../../../data/product_type_bean_entity.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:服务器列表VM
class ServerListModel extends BaseViewModel {
  // int serverIndex = 0;
  int type = 0;
  // String? firstTitle;
  ///增加个全部元素
  AreaListBeanDataAreas allTitle =
      AreaListBeanDataAreas.fromJson({'title': '全部'});

  ///城市列表
  List<AreaListBeanDataAreas> areaEntityList = [];
  String title = '';

  ///服务器列表
  List<ServerListBeanDataData> serverEntityList = [];

  ///确定选择续费列表
  String money = ''; //显示用户余额
  int month = 1;
  List<int> orderIdList = [];

  ///获取带宽数据接口
  List<ProductTypeBeanDataTypes> productTypeList = [];
  int? bandWidthIndex;
  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
    areaEntityList.add(allTitle);
    areaListApiManager();
    serverListApiManager(
      refresh: true,
    );
  }

  @override
  void refresh() async {
    page = 1;
    serverEntityList.clear();
    if (type == 0) {
      serverListApiManager(refresh: true, area: title);
    } else {
      residenceListApiManager(refresh: true, area: title);
    }
  }

  @override
  void loadMore() {
    if (type == 0) {
      serverListApiManager(refresh: false, area: title);
    } else {
      residenceListApiManager(refresh: false, area: title);
    }
  }

  ///获取带宽数据接口
  // void getDaikuanData() {
  //   HttpManager.requestData(
  //       Url.getDaikuanData, false, {}, ConfigString.requestGet, success: (res) {
  //     productTypeList.clear();
  //     ProductTypeBeanEntity productTypeBeanEntity =
  //         ProductTypeBeanEntity.fromJson(res);
  //     productTypeList.addAll(productTypeBeanEntity.data.types);
  //   }, complete: () {
  //     notifyListeners();
  //   });
  // }

  ///--------------------------静态ip列表数据--------------------------///
  ///获取城市列表
  void areaListApiManager() {
    HttpManager.requestData(
        Url.staticAreaList, true, {}, ConfigString.requestGet, success: (res) {
      AreaListBeanEntity areaListBeanEntity = AreaListBeanEntity.fromJson(res);
      areaEntityList.addAll(areaListBeanEntity.data.areas);
      // title = areaEntityList[0].title;
      // serverListApiManager(title!);
    }, complete: () {
      notifyListeners();
    });
  }

  ///服务器列表
  void serverListApiManager({bool refresh = false, String? area}) {
    Map<String, dynamic> params = {
      "page": page,
      "t": bandWidthIndex,
      "area": area,
      "limit": size,
    };
    HttpManager.requestData(
        Url.staticList, true, params, ConfigString.requestGet, success: (res) {
      serverEntityList.clear();
      ServerListBeanEntity serverListBeanEntity =
          ServerListBeanEntity.fromJson(res);
      serverEntityList.addAll(serverListBeanEntity.data.data);
      if (refresh) {
        pageTotal = serverListBeanEntity.data.total;
        refreshController.resetNoData();
        refreshController.refreshCompleted();
      } else {
        refreshController.loadComplete();
      }
      if (size * page > pageTotal) {
        refreshController.loadNoData();
        return;
      }
      page++;
    }, fail: (e) {
      refreshController.loadFailed();
    }, complete: () {
      notifyListeners();
    });
  }

  ///--------------------------住宅ip列表数据--------------------------///
  ///获取城市列表
  void residenceAreaListApiManager({Function? successOnTap}) {
    HttpManager.requestData(
        Url.residenceStaticAreaList, true, {}, ConfigString.requestGet,
        success: (res) {
      AreaListBeanEntity areaListBeanEntity = AreaListBeanEntity.fromJson(res);
      areaEntityList.addAll(areaListBeanEntity.data.areas);
      // title = areaEntityList[0].title;
      // serverListApiManager(title!);
    }, complete: () {
      notifyListeners();
      successOnTap!();
    });
  }

  void residenceListApiManager(
      {bool refresh = false, String? area, Function? successOnTap}) {
    Map<String, dynamic> params = {
      "page": page,
      "limit": size,
      "area": area,
    };
    HttpManager.requestData(
        Url.residenceList, true, params, ConfigString.requestGet,
        success: (res) {
      ServerListBeanEntity serverListBeanEntity =
          ServerListBeanEntity.fromJson(res);
      serverEntityList.addAll(serverListBeanEntity.data.data);
      if (refresh) {
        pageTotal = serverListBeanEntity.data.total;
        refreshController.resetNoData();
        refreshController.refreshCompleted();
      } else {
        refreshController.loadComplete();
      }
      if (size * page > pageTotal) {
        refreshController.loadNoData();
        return;
      }
      page++;
    }, fail: (e) {
      refreshController.loadFailed();
    }, complete: () {
      notifyListeners();
      successOnTap!();
    });
  }

  /// 获取用户信息余额接口
  void memberInfoAPI(Function successTap) {
    HttpManager.requestData(Url.memberInfo, true, {}, ConfigString.requestPost,
        success: (res) {
      money = res['data']['balance'];
      successTap();
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
//     }, complete: () {
//       notifyListeners();
//     });
//   }
}
