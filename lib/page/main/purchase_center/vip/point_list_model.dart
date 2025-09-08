import 'package:agent_app_vpn/data/vip_list_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

class PointListModel extends BaseViewModel {
  List<PointInfoListData> dataList = [];
  PointInfoPageData? infodata;
  @override
  void firstLoadData() {
    super.firstLoadData();
  }

  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
    print('refreshrefreshrefreshrefresh');
    dataList.clear();
    page = 1;
    getPointList(true);
  }

  @override
  void loadMore() {
    page++;
    getPointList(false);
  }

  void getPointList(bool isRefresh) {
    HttpManager.requestData(
      Url.pointsGetlist,
      true,
      {'page': page, 'limit': size},
      ConfigString.requestGet,
      success: (res) {
        PointInfoData data = PointInfoData.fromJson(res);
        infodata = data.data;
        dataList.addAll(infodata!.data);
        if (isRefresh) {
          refreshController.refreshCompleted();
        } else {
          if (infodata!.currentpage == infodata!.lastpage) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        }
      },
      complete: () {
        notifyListeners();
      },
    );
  }
}
