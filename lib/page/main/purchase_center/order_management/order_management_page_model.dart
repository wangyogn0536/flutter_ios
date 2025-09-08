import '../../../../data/order_member_list_bean_entity.dart';
import '../../../../project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:订单管理VM

class OrderManagementPageModel extends BaseViewModel {
  List<OrderMemberListBeanDataListData> orderDataList = [];
  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
    orderDataList.clear();
    page = 1;
    orderManagementApiManager(refresh: true);
  }

  @override
  void loadMore() {
    orderManagementApiManager(refresh: false);
  }

  ///获取城市列表
  void orderManagementApiManager({bool refresh = false}) {
    HttpManager.requestData(
      Url.orderMember,
      true,
      {'page': page, 'limit': size},
      ConfigString.requestGet,
      success: (res) {
        OrderMemberListBeanEntity orderMemberListBeanEntity =
            OrderMemberListBeanEntity.fromJson(res);
        orderDataList.addAll(orderMemberListBeanEntity.data.list.data);
        if (refresh) {
          pageTotal = orderMemberListBeanEntity.data.list.total;
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        page++;
      },
      complete: () {
        notifyListeners();
      },
    );
  }
}
