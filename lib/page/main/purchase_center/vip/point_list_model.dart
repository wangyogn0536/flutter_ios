import 'package:agent_app_vpn/data/vip_list_entity.dart';
import 'package:agent_app_vpn/project_imports.dart';

/// PointListModel 是一个管理积分列表数据的 ViewModel
/// 继承自 BaseViewModel，负责处理刷新、加载更多以及数据请求
class PointListModel extends BaseViewModel {
  /// 保存积分明细列表
  List<PointInfoListData> dataList = [];

  /// 保存分页数据和其他信息
  PointInfoPageData? infodata;

  /// 第一次加载数据的方法
  @override
  void firstLoadData() {
    super.firstLoadData();
    // 可以在这里添加第一次加载时的逻辑，例如初始化请求
  }

  /// 刷新数据
  @override
  void refresh() {
    super.refresh();
    print('refreshrefreshrefreshrefresh'); // 调试打印，表示刷新动作
    dataList.clear(); // 清空现有列表
    page = 1; // 重置分页到第一页
    getPointList(true); // 调用接口获取第一页数据，isRefresh=true
  }

  /// 加载更多数据（分页）
  @override
  void loadMore() {
    page++; // 页码加 1
    getPointList(false); // 调用接口获取下一页数据，isRefresh=false
  }

  /// 获取积分列表数据
  /// [isRefresh] 表示是否是下拉刷新
  void getPointList(bool isRefresh) {
    HttpManager.requestData(
      Url.pointsGetlist, // 请求接口 URL
      true, // 是否显示加载中
      {'page': page, 'limit': size}, // 请求参数：页码和每页数量
      ConfigString.requestGet, // 请求类型：GET
      success: (res) {
        // 请求成功回调
        PointInfoData data = PointInfoData.fromJson(res); // 将返回数据解析为 PointInfoData 对象
        infodata = data.data; // 保存分页数据
        dataList.addAll(infodata!.data); // 将本页数据追加到 dataList

        if (isRefresh) {
          // 如果是刷新操作，通知刷新控件完成
          refreshController.refreshCompleted();
        } else {
          // 如果是加载更多
          if (infodata!.currentpage == infodata!.lastpage) {
            // 当前页等于最后一页，表示没有更多数据
            refreshController.loadNoData();
          } else {
            // 还有更多数据
            refreshController.loadComplete();
          }
        }
      },
      complete: () {
        // 无论成功或失败都通知 UI 刷新
        notifyListeners();
      },
    );
  }
}