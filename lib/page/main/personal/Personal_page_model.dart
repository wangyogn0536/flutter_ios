import 'package:agent_app_vpn/data/usable_coupon_bean_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

/// Created by 刘冰.
/// Date:2024/7/22
/// des:购买VM
class PersonalPageModel extends BaseViewModel {
  String price = '0.00'; //优惠后价格
  String oPrice = '0.00'; //原价格
  String money = ''; //显示用户余额
  int selectBandwidthIndex = 0; //选择带宽
  String wechatPay = ''; //微信支付链接
  String alipayPay = ''; //支付宝支付链接
  String selectCouponText = '暂无可用优惠券';
  String purchaseNotesText = '';
  String iOSOrderNo = '';
  int code = 0;
  List<UsableCouponBeanDataYouhuiquan> selectCouponList = [];

  ///获取带宽数据接口
  // List<ProductTypeBeanDataTypes> productTypeList = [];
  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
    usableCouponsAPI();
    purchaseNotesData();
    city10NodeAPI();
  }

  ///获取带宽数据接口
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

  // void getPrice(String url, int daikuan, int month, int num, String typeId,
  //     {int? dcode, Function? isPops}) {
  //   HttpManager.requestData(
  //       url,
  //       false,
  //       {
  //         'daikuan': daikuan,
  //         'month': month,
  //         'num': num,
  //         'dcode': dcode,
  //         // 'type_id': typeId
  //       },
  //       ConfigString.requestPost, success: (res) {
  //     price = res['data']['price'];
  //     oPrice = res['data']['oprice'];
  //   }, complete: () {
  //     notifyListeners();
  //     isPops!();
  //   });
  // }

  ///购买须知
  void purchaseNotesData() {
    HttpManager.requestData(
        Url.purchaseNotes, false, {}, ConfigString.requestGet, success: (res) {
      purchaseNotesText = res['data'];
      notifyListeners();
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

  /// 获取购买可用优惠券接口
  void usableCouponsAPI() {
    HttpManager.requestData(
        Url.productCoupons, false, {'price': price}, ConfigString.requestPost,
        success: (res) {
      selectCouponList.clear();
      UsableCouponBeanEntity usableCouponBeanEntity =
          UsableCouponBeanEntity.fromJson(res);
      selectCouponList.addAll(usableCouponBeanEntity.data.youhuiquan);
      selectCouponText = '当前优惠券数量${selectCouponList.length}张';
    }, complete: () {
      notifyListeners();
    });
  }

  ///苹果端内购支付接口
  void iosPaySuccessData(
    String sign,
    String dateTime,
    String tradeNo,
    Map<String, dynamic> iOSPurchaseData,
  ) {
    Map<String, dynamic> params = {
      'sign': sign,
      'paytime': dateTime,
      'orderno': iOSOrderNo,
      'trade_no': tradeNo,
      'ios': iOSPurchaseData,
      'mode': 'product'
    };
    IosPayHttpManager.requestData(Url.iOSPurchase, params, success: () {});
  }

  ///静态节点列表
  void city10NodeAPI() {
    HttpManager.requestData(Url.productCity, false,
        {'type': '2', 'isshua': '1'}, ConfigString.requestPost,
        success: (res) {});
  }

  ///--------------------------提交订单接口--------------------------///
  ///静态提交订单
  void paymentStatic(
    int type,
    String daikuan,
    int month,
    String title,
    int areaId,
    int serverId,
    int num, {
    int? dcode,
    Function? paySuccess,
    Function? wechatPaySuccess,
    Function? alipayPaySuccess,
    Function? iOSPaySuccess,
  }) {
    HttpManager.requestData(
        Url.paymentStatic,
        true,
        {
          'type': type,
          'buy_type': daikuan,
          'time': month,
          'dcode': dcode,
          'node': [
            {
              'title': title,
              'areaid': areaId,
              'cityid': serverId,
              'number': num
            },
          ],
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
        case 100:
          iOSOrderNo = res['data']['orderno'];
          iOSPaySuccess!();
          break;
      }
    }, complete: () {
      notifyListeners();
    });
  }

  ///住宅提交订单
  void paymentResidence(
    int type,
    String daikuan,
    int month,
    String title,
    int areaId,
    int serverId,
    int num, {
    int? dcode,
    Function? paySuccess,
    Function? wechatPaySuccess,
    Function? alipayPaySuccess,
    Function? iOSPaySuccess,
  }) {
    HttpManager.requestData(
        Url.paymentResidence,
        true,
        {
          'type': type,
          'buy_type': '22',
          'time': month,
          'dcode': dcode,
          'node': [
            {
              'title': title,
              'areaid': areaId,
              'cityid': serverId,
              'number': num
            },
          ],
        },
        ConfigString.requestPost, success: (res) {
      switch (type) {
        case 1:
          wechatPay = res['data']['pay'];
          alipayPaySuccess!();

          break;
        case 2:
          alipayPay = res['data']['pay'];
          wechatPaySuccess!();
          break;
        case 4:
          paySuccess!();
          break;
        case 100:
          iOSOrderNo = res['data']['orderno'];
          iOSPaySuccess!();
          break;
      }
    }, complete: () {
      notifyListeners();
    });
  }
}
