import 'dart:io';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/string.dart';
import '../util/cache_manager.dart';
import 'base_change_notifier.dart';
import 'loading_state_widget.dart';

/// Created by 刘冰.
/// Date:2024/3/20
/// des:viewModel基类

abstract class BaseViewModel extends BaseChangeNotifier {
  int page = 1;

  int size = 20;

  int pageTotal = 0;

  String uuid = '${CacheManager.getInstance()?.get<String>(ConfigString.uuid)}';

  String name =
      '${CacheManager.getInstance()?.get<String>(ConfigString.deviceName)}';
  String deviceType = Platform.isAndroid ? '3' : '4';
  //上拉加载/下拉刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ///进入界面加载数据所必须的数据
  void firstLoadData() {
    viewState = ViewState.loading;
    refresh();
  }

  ///列表界面获取第一页数据
  void refresh() {}

  ///列表界面加载更多
  void loadMore() {}
}
