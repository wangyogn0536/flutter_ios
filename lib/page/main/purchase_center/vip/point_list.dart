import 'package:agent_app_vpn/data/vip_list_entity.dart';
import 'package:agent_app_vpn/page/main/purchase_center/vip/point_list_model.dart';
import 'package:agent_app_vpn/project_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PointListPage extends StatefulWidget {
  const PointListPage({super.key});

  @override
  State<PointListPage> createState() => _PointListPageState();
}

class _PointListPageState extends BaseState<PointListModel, PointListPage> {
  @override
  Widget getContentChild(PointListModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('积分明细', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: MyColor.tvDDDColor,
        padding: EdgeInsets.all(16.w),
        child: model.dataList.isEmpty
            ? SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'images/empty_icon.png',
                  fit: BoxFit.fitWidth,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SmartRefresher(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true,
                  enablePullDown: true,
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("上拉加载");
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("加载失败，请重试");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("加载中...");
                      } else {
                        body = const Text("没有更多数据");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  child: ListView.builder(
                    itemBuilder: (c, index) {
                      PointInfoListData data = model.dataList[index];
                      return Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 15.w,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: Color(0xFFDDDDDD),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.msg,
                                    style: MyTextStyle.text15blackStyle,
                                  ),
                                  SizedBox(height: 5.w),
                                  Text(
                                    data.createat,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: MyColor.grayCCCColor,
                                    ),
                                  ),
                                  SizedBox(height: 15.w),
                                ],
                              ),
                              Text(
                                data.type + '${data.price}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: model.dataList.length,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  // TODO: implement viewModel
  PointListModel get viewModel => PointListModel();
}
