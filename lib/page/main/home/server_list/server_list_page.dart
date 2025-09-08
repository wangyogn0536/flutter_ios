import 'dart:io';

import 'package:agent_app_vpn/data/server_list_bean_entity.dart';
import 'package:agent_app_vpn/page/main/home/server_list/server_list_model.dart';
import 'package:agent_app_vpn/project_imports.dart';
import 'package:agent_app_vpn/util/vpn_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../personal/personal_page.dart';
import '../renew_server_list/renew_server_list_page.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:服务器列表页

class ServerListPage extends StatefulWidget {
  //城市列表
  const ServerListPage({super.key});

  @override
  State<ServerListPage> createState() => _ServerListPageState();
}

class _ServerListPageState extends BaseState<ServerListModel, ServerListPage>
    with SingleTickerProviderStateMixin {
  // late TabController controller;
  int areaIndex = 0;
  bool _is5MHighlight = false;
  bool _is10MHighlight = false;
  bool _is20MHighlight = false;
  bool isRenew = false;

  ///是否显示续费
  bool _isCheckAll = false; //是否全选
  Set<ServerListBeanDataData> selectedIndices = {}; //所选的续费数组

  late TabController controller;
  List tabs = ['静态IP', '住宅IP'];
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
    controller.animateTo(currentIndex);
  }

  @override
  Widget getContentChild(model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: CustomAppBar(
        '节点选择',
        [
          IconButton(
              onPressed: () {
                if (model.serverEntityList.isEmpty) {
                  MessageToast.toast('您暂时没有ip，请购买后使用');
                  navigationPush(context, const PersonalPage());
                  return;
                }
                model.areaEntityList.clear();
                model.serverEntityList.clear();
                areaIndex = 0;
                model.areaEntityList.add(model.allTitle);
                if (currentIndex == 0) {
                  model.areaListApiManager();
                  model.serverListApiManager();
                } else {
                  model.residenceAreaListApiManager();
                  model.residenceListApiManager();
                }
                MessageToast.toast('已刷新，请勿重复刷新');
              },
              icon: Image.asset(
                'images/refresh_icon.png',
                width: 40.w,
                height: 40.w,
              )),
        ],
        isBack: true,
      ),
      body: Container(
        color: MyColor.tvDDDColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                decoration: myBoxDecoration(backColor: Colors.white),
                height: 45.h,
                child: TabBar(
                    controller: controller,
                    automaticIndicatorColorAdjustment: true,
                    unselectedLabelColor: Colors.black,
                    labelColor: MyColor.themeColor,
                    labelStyle: const TextStyle(fontSize: 17),
                    indicatorColor: MyColor.themeColor,
                    enableFeedback: true,
                    indicatorPadding: EdgeInsets.all(2.w),
                    indicatorWeight: 2,
                    onTap: (value) {
                      model.areaEntityList.clear();
                      model.areaEntityList.add(model.allTitle);
                      model.serverEntityList.clear();
                      if (value == 0) {
                        model.areaListApiManager();
                        model.serverListApiManager();
                      } else {
                        model.residenceAreaListApiManager(successOnTap: () {
                          isRenew = false;
                        });
                        model.residenceListApiManager(successOnTap: () {
                          isRenew = false;
                        });
                      }
                      setState(() {
                        areaIndex = 0;
                        currentIndex = value;
                        model.type = value;
                      });
                      // model.refresh();
                    },
                    tabs: tabs.map((e) {
                      return Tab(
                        text: e,
                      );
                    }).toList())),
            currentIndex == 0
                ? Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    height: 45.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.w),
                          child: Text(
                            ConfigString.selectBandwidth,
                            style: TextStyle(
                                fontSize: 17.sp, color: MyColor.themeColor),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     for (int i = 0; i < model.productTypeList.length; i++)
                        //       ServerSelectBandwidthBtn(
                        //           title: model.productTypeList[i].title,
                        //           value: i,
                        //           isHighlight: model.bandWidthIndex == i,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               model.bandWidthIndex = value;
                        //               model.refresh();
                        //             });
                        //           })
                        //   ],
                        // )

                        ServerSelectBandwidthBtn(
                            title: ConfigString.text5M,
                            value: 1,
                            isHighlight: _is5MHighlight,
                            onChanged: (value) {
                              setState(() {
                                _is5MHighlight = !_is5MHighlight;
                                _is10MHighlight = false;
                                _is20MHighlight = false;
                                _isCheckAll = false;
                                selectedIndices.clear();
                                if (_is5MHighlight) {
                                  model.bandWidthIndex = 0;
                                } else {
                                  model.bandWidthIndex = null;
                                }
                                model.refresh();
                              });
                            }),
                        ServerSelectBandwidthBtn(
                            title: ConfigString.text10M,
                            value: 1,
                            isHighlight: _is10MHighlight,
                            onChanged: (value) {
                              setState(() {
                                _is10MHighlight = !_is10MHighlight;
                                _is5MHighlight = false;
                                _is20MHighlight = false;
                                _isCheckAll = false;
                                selectedIndices.clear();
                                if (_is10MHighlight) {
                                  model.bandWidthIndex = 2;
                                } else {
                                  model.bandWidthIndex = null;
                                }
                                model.refresh();
                              });
                            }),
                        ServerSelectBandwidthBtn(
                            title: ConfigString.text20M,
                            isHighlight: _is20MHighlight,
                            value: 1,
                            onChanged: (value) {
                              setState(() {
                                _is20MHighlight = !_is20MHighlight;
                                _is5MHighlight = false;
                                _is10MHighlight = false;
                                _isCheckAll = false;
                                selectedIndices.clear();
                                if (_is20MHighlight) {
                                  model.bandWidthIndex = 8;
                                } else {
                                  model.bandWidthIndex = null;
                                }
                                model.refresh();
                              });
                            })
                      ],
                    ),
                  )
                : const Center(),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.w,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                              child: ListView.builder(
                            itemBuilder: (c, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  areaIndex = index;
                                  if (model.areaEntityList[areaIndex].title ==
                                      '全部') {
                                    model.title = '';
                                  } else {
                                    model.title =
                                        model.areaEntityList[areaIndex].title;
                                  }
                                  model.refresh();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10.w,
                                    right: 10.w,
                                    top: 5.h,
                                    bottom: 5.h),
                                width: double.infinity,
                                height: 50.h,
                                color: areaIndex == index
                                    ? MyColor.themeColor
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    model.areaEntityList[index].title,
                                    style: areaIndex == index
                                        ? MyTextStyle.text17whiteStyle
                                        : TextStyle(
                                            fontSize: 17.sp,
                                            color: MyColor.gray333Color),
                                  ),
                                ),
                              ),
                            ),
                            itemCount: model.areaEntityList.length,
                          )),
                          if (Platform.isAndroid)
                            isRenew || currentIndex == 1
                                ? const Center()
                                : Container(
                                    margin: EdgeInsets.only(top: 1.h),
                                    width: double.infinity,
                                    height: 60.h,
                                    color: MyColor.themeColor,
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isRenew = true;
                                          });
                                        },
                                        child: Text(
                                          '新增续费',
                                          style: MyTextStyle.text17whiteStyle,
                                        )),
                                  )
                          else
                            const Center(),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 1.w),
                      alignment: Alignment.centerRight,
                      color: Colors.white,
                      child: SmartRefresher(
                        controller: model.refreshController,
                        onRefresh: model.refresh,
                        onLoading: model.loadMore,
                        enablePullUp: true,
                        enablePullDown: true,
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.canLoading) {
                              body = Text(
                                "上拉加载更多",
                                style: MyTextStyle.text15blackStyle,
                              );
                            } else {
                              body = Text(
                                "没有更多数据了!",
                                style: MyTextStyle.text15gray888Style,
                              );
                            }
                            return SizedBox(
                              height: 30.h,
                              child: Center(child: body),
                            );
                          },
                        ),
                        child: ListView.builder(
                          itemBuilder: (c, index) {
                            /*
                            *
                            * */
                            return isRenew
                                ? _serverListItems(
                                    context,
                                    model.serverEntityList[index],
                                    _isCheckAll,
                                    model.serverEntityList[index].type == 9
                                        ? '${model.serverEntityList[index].daikuan}M'
                                        : bandWidthString(
                                            model.serverEntityList[index].type),
                                    model.serverEntityList[index].area,
                                    model.serverEntityList[index].ip)
                                : Slidable(
                                    key:
                                        ValueKey(model.serverEntityList[index]),
                                    endActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        extentRatio: 0.5,
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) => remark,
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            label: '备注',
                                          ),
                                          // SlidableAction(
                                          //   onPressed: (context) => remark,
                                          //   backgroundColor: MyColor.themeColor,
                                          //   foregroundColor: Colors.white,
                                          //   label: '切换',
                                          // ),
                                        ]),
                                    child: InkWell(
                                      onTap: () {
                                        var result = ResultData(
                                            serverListBeanDataData:
                                                model.serverEntityList[index],
                                            index: currentIndex);
                                        if (Platform.isAndroid) {
                                          AndroidVpnService.stopVpn();
                                        }
                                        Navigator.pop(context, result);
                                      },
                                      child: SizedBox(
                                        height: 50.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            isRenew
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Image.asset(
                                                      'images/select_box_icon.png',
                                                      width: 17.w,
                                                      height: 17.h,
                                                    ),
                                                  )
                                                : const Center(),
                                            Text(
                                              currentIndex == 1
                                                  ? '[住宅]'
                                                  : model
                                                              .serverEntityList[
                                                                  index]
                                                              .type ==
                                                          9
                                                      ? '  [${model.serverEntityList[index].daikuan}M]'
                                                      : '  [${bandWidthString(model.serverEntityList[index].type)}]',
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  color: MyColor.orangeColor),
                                            ),
                                            Text(
                                              model
                                                  .serverEntityList[index].area,
                                              style:
                                                  MyTextStyle.text17themeStyle,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.w),
                                              child: Text(
                                                model
                                                    .serverEntityList[index].ip,
                                                style: TextStyle(
                                                    fontSize: 17.sp,
                                                    color:
                                                        MyColor.gray333Color),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          itemCount: model.serverEntityList.length,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            if (isRenew)
              Container(
                margin: EdgeInsets.only(top: 1.h),
                width: double.infinity,
                height: 60.h,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: SelectBandwidthBtn('全选', _isCheckAll, (value) {
                        setState(() {
                          _isCheckAll = !_isCheckAll;
                          if (!_isCheckAll) {
                            selectedIndices.clear();
                          } else {
                            selectedIndices.addAll(model.serverEntityList);
                          }
                        });
                      },
                          selectImage: 'images/select_box_icon.png',
                          value: 1,
                          image: 'images/choice_box_icon.png',
                          titleSize: 20.sp,
                          imageSize: Size(20.w, 20.w)),
                    ),
                    Row(
                      children: [
                        ThemeTitleButton(
                            size: Size(80.w, 40.h),
                            backgroudColor: MyColor.themeColor,
                            title: '取消续费',
                            titleFont: 17.sp,
                            titleColor: Colors.white,
                            onTap: () {
                              setState(() {
                                isRenew = false;
                              });
                            }),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 20.w),
                          child: ThemeTitleButton(
                              size: Size(80.w, 40.h),
                              backgroudColor: MyColor.themeColor,
                              title: '续费',
                              titleFont: 17.sp,
                              titleColor: Colors.white,
                              onTap: () {
                                if (selectedIndices.isEmpty) {
                                  MessageToast.toast('请选择要续费的IP');
                                  return;
                                }
                                List<int> orderIdList = [];
                                for (int i = 0;
                                    i < selectedIndices.length;
                                    i++) {
                                  orderIdList
                                      .add(selectedIndices.toList()[i].id);
                                }
                                model.orderIdList = orderIdList;
                                model.memberInfoAPI(() {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PayRenewWidget(
                                          daikuan: 10,
                                          balanceString: model.money,
                                          orderIdList: orderIdList,
                                          firstPrice: '0.00',
                                        );
                                      });
                                  // model.getPrice(orderIdList, isPops: (price) {
                                  //
                                  // });
                                });
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              )
            else
              const Center(),
          ],
        ),
      ),
    );
  }

  Widget _serverListItems(
      BuildContext context,
      ServerListBeanDataData serverListBeanDataData,
      bool isCheckAll,
      String bandWidth,
      String area,
      String ipText) {
    final String imageName = selectedIndices.contains(serverListBeanDataData)
        ? 'images/select_box_icon.png'
        : 'images/choice_box_icon.png';
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCheckAll = false;
          if (selectedIndices.contains(serverListBeanDataData)) {
            selectedIndices.remove(serverListBeanDataData);
          } else {
            selectedIndices.add(serverListBeanDataData);
          }
        });
      },
      child: Container(
        color: Colors.white,
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                isCheckAll ? 'images/select_box_icon.png' : imageName,
                width: 17.w,
                height: 17.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                bandWidth,
                style: TextStyle(fontSize: 17.sp, color: MyColor.orangeColor),
              ),
            ),
            Text(
              // model.serverEntityList[index].area,
              area,
              style: MyTextStyle.text17themeStyle,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                // model.serverEntityList[index].ip,
                ipText,
                style: TextStyle(fontSize: 17.sp, color: MyColor.gray333Color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ///带宽颜色显示
  // Color bandWidthColor(int type) {
  //   Color color;
  //   switch (type) {
  //     case 2:
  //       color = Colors.red;
  //       break;
  //     case 8:
  //       color = Colors.yellow;
  //       break;
  //     default:
  //       color = Colors.green;
  //       break;
  //   }
  //   return color;
  // }

  ///显示带宽的文字
  String bandWidthString(int type) {
    String string;
    switch (type) {
      case 2:
        string = ConfigString.text10M;
        break;
      case 8:
        string = ConfigString.text20M;
        break;
      default:
        string = ConfigString.text5M;
        break;
    }
    return string;
  }

  ///右滑点击
  void remark(BuildContext context) {}
  @override
  // TODO: implement viewModel
  get viewModel => ServerListModel();
}

class ResultData {
  final ServerListBeanDataData serverListBeanDataData;
  final int index;

  ResultData({required this.serverListBeanDataData, required this.index});
}

class ServerSelectBandwidthBtn extends StatelessWidget {
  final String title;
  final bool isHighlight;
  final int value;
  final ValueChanged<int> onChanged;
  const ServerSelectBandwidthBtn(
      {super.key,
      required this.title,
      required this.value,
      required this.isHighlight,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: SelectBandwidthBtn(title, isHighlight, onChanged,
          value: value,
          selectImage: 'images/select_box_icon.png',
          image: 'images/choice_box_icon.png',
          titleSize: 15,
          imageSize: Size(15.w, 15.w)),
    );
  }
}
