import 'package:agent_app_vpn/data/coupon_list_bean_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:优惠券列表VM

class DiscountCouponPageModel extends BaseViewModel {
  int type = 0;
  List<CouponListBeanDataData> couponList = [];
  @override
  void refresh() async {
    page = 1;
    couponList.clear();
    memberInfoAPI(refresh: true);
  }

  @override
  void loadMore() {
    memberInfoAPI(
      refresh: false,
    );
  }

  /// 获取优惠券
  void memberInfoAPI({bool refresh = false}) {
    HttpManager.requestData(
        Url.couponsList,
        true,
        {'type': type, 'page': page, 'limit': size},
        ConfigString.requestGet, success: (res) {
      CouponListBeanEntity couponListBeanEntity =
          CouponListBeanEntity.fromJson(res);
      couponList.addAll(couponListBeanEntity.data.data);
      if (refresh) {
        pageTotal = couponListBeanEntity.data.total;
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
    }, complete: () {
      notifyListeners();
    });
  }
}
