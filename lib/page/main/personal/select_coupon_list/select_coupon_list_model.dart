import 'package:agent_app_vpn/data/usable_coupon_bean_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

import '../../../../data/product_type_bean_entity.dart';

class SelectCouponListModel extends BaseViewModel {
  List<UsableCouponBeanDataYouhuiquan> selectCouponList = [];
  List<ProductTypeBeanDataTypes> productTypeList = [];

  int selectBandwidthIndex = 0; //选择带宽

  String price = '0.00'; //优惠后价格
  String oPrice = '0.00'; //原价格
  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
    // getDaikuanData();
  }

  // ///获取带宽数据接口
  // void getDaikuanData() {
  //   HttpManager.requestData(
  //       Url.getDaikuanData, false, {}, ConfigString.requestGet, success: (res) {
  //     productTypeList.clear();
  //     ProductTypeBeanEntity productTypeBeanEntity =
  //         ProductTypeBeanEntity.fromJson(res);
  //     productTypeList.addAll(productTypeBeanEntity.data.types);
  //     notifyListeners();
  //   });
  // }

  ///获取静态价格接口
  void getStaticPrice(String daikuan, int month, int num,
      {int? dcode, Function? isPops}) {
    HttpManager.requestData(
        Url.getStaticPrice,
        false,
        {'buy_type': daikuan, 'ipnum': num, 'month': month, 'dcode': dcode},
        ConfigString.requestPost, success: (res) {
      price = res['data']['price'];
      oPrice = res['data']['oprice'];
    }, complete: () {
      notifyListeners();
      isPops!();
    });
  }

  ///获取住宅价格接口
  void getResidencePrice(String buyType, int month, int num,
      {int? dcode, Function? isPops}) {
    HttpManager.requestData(
        Url.getResidencePrice,
        false,
        {'buy_type': buyType, 'ipnum': num, 'month': month, 'dcode': dcode},
        ConfigString.requestPost, success: (res) {
      price = res['data']['price'];
      oPrice = res['data']['oprice'];
    }, complete: () {
      notifyListeners();
      isPops!();
    });
  }

  ///获取续费价格接口
  void getRenewPrice(List<int> orderIdList, int month,
      {int? dcode, Function? isPops}) {
    HttpManager.requestData(
        Url.renewPrice,
        true,
        {
          'order_id': orderIdList,
          'month': month,
          'dcode': dcode,
        },
        ConfigString.requestPost, success: (res) {
      notifyListeners();
      isPops!();
    });
  }
}
