import 'package:agent_app_vpn/data/usable_coupon_bean_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

import '../../../../data/area_list_bean_entity.dart';
import '../../../../data/server_list_bean_entity.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:续费的VM
class RenewServerListModel extends BaseViewModel {
  int? bandWidthIndex;

  ///增加个全部元素
  AreaListBeanDataAreas allTitle =
      AreaListBeanDataAreas.fromJson({'title': '全部'});

  ///城市列表
  List<AreaListBeanDataAreas> areaEntityList = [];

  ///服务器列表
  List<ServerListBeanDataData> serverEntityList = [];

  String area = ''; //城市的选择
  String price = ''; //显示用户余额
  String oPrice = ''; //原价格
  List<int> orderIdList = [];

  String wechatPay = ''; //微信支付链接
  String alipayPay = ''; //支付宝支付链接

  ///优惠券专栏
  String selectCouponText = '暂无可用优惠券';
  List<UsableCouponBeanDataYouhuiquan> selectCouponList = [];
  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
    usableCouponsAPI(price);
  }

  // /// 获取用户信息余额接口
  // void memberInfoAPI(Function successTap) {
  //   HttpManager.requestData(Url.memberInfo, true, {}, ConfigString.requestPost,
  //       success: (res) {
  //     price = res['data']['balance'];
  //     successTap();
  //   }, complete: () {
  //     notifyListeners();
  //   });
  // }

  ///获取价格接口
  void getPrice(
    List<int> orderIdList,
    int month, {
    int? dcode,
  }) {
    HttpManager.requestData(
        Url.renewPrice,
        false,
        {
          'order_id': orderIdList,
          'month': month,
          'dcode': dcode,
        },
        ConfigString.requestPost, success: (res) {
      price = res['data']['price'];
      oPrice = res['data']['oprice'];
      notifyListeners();
    }, complete: () {
      notifyListeners();
    });
  }

  /// 获取购买可用优惠券接口
  void usableCouponsAPI(String price, {Function? success}) {
    HttpManager.requestData(
        Url.productCoupons, false, {'price': price}, ConfigString.requestPost,
        success: (res) {
      selectCouponList.clear();
      UsableCouponBeanEntity usableCouponBeanEntity =
          UsableCouponBeanEntity.fromJson(res);
      selectCouponList.addAll(usableCouponBeanEntity.data.youhuiquan);
      selectCouponText = '当前优惠券数量${selectCouponList.length}张';
      notifyListeners();
      success!();
    });
  }

  ///提交续费订单接口
  void paymentStatic(List<int> orderList, int month, int type,
      {Function? paySuccess,
      Function? wechatPaySuccess,
      int? dcode,
      Function? alipayPaySuccess}) {
    HttpManager.requestData(
        Url.renewStatic,
        true,
        {
          'order_id': orderList,
          'month': month,
          'type': type,
          'dcode': dcode,
        },
        ConfigString.requestPost, success: (res) {
      switch (type) {
        case 1:
          wechatPay = res['data']['pay'];
          wechatPaySuccess!();
          break;
        case 2:
          alipayPay = res['data']['pay'];
          alipayPaySuccess!();
          break;
        case 4:
          paySuccess!();
          break;
      }
    });
  }
}
