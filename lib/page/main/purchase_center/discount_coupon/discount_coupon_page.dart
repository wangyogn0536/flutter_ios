import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../project_imports.dart';
import 'discount_coupon_page_model.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:优惠券列表UI

class DiscountCouPonPage extends StatefulWidget {
  const DiscountCouPonPage({super.key});

  @override
  State<DiscountCouPonPage> createState() => _DiscountCouPonPageState();
}

class _DiscountCouPonPageState
    extends BaseState<DiscountCouponPageModel, DiscountCouPonPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  List tabs = ['未使用', '已使用', '已过期'];
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
    controller.animateTo(currentIndex);
  }

  @override
  Widget getContentChild(DiscountCouponPageModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('优惠券', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          color: MyColor.tvDDDColor,
          image: model.couponList.isEmpty
              ? const DecorationImage(
                  image: AssetImage('images/empty_icon.png'),
                  fit: BoxFit.fitWidth,
                )
              : null,
        ),
        child: Column(
          children: [
            Container(
                decoration: myBoxDecoration(backColor: Colors.white),
                height: 50.h,
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
                      print('😊😊😊😊====$value');
                      setState(() {
                        currentIndex = value;
                        model.type = value;
                        model.refresh();
                      });
                    },
                    tabs: tabs.map((e) {
                      return Tab(
                        text: e,
                      );
                    }).toList())),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
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
                        style: MyTextStyle.text15blackStyle,
                      );
                    }
                    return SizedBox(
                      height: 30.h,
                      child: Center(child: body),
                    );
                  },
                ),
                child: ListView.builder(
                  itemBuilder: (c, index) => Container(
                    height: 110.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              color: MyColor.couponColor,
                              width: 100.w,
                              child: Center(
                                child: Text(
                                  '¥${model.couponList[index].price}',
                                  style: TextStyle(
                                      fontSize: 24.sp, color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 15.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6.h),
                                          child: Text(
                                            model.couponList[index].title,
                                            style: MyTextStyle.text17blackStyle,
                                          ),
                                        ),
                                        Text(
                                          '满${model.couponList[index].useMinPrice}元可用',
                                          style: MyTextStyle.text15grayStyle,
                                        ),
                                        Text(
                                          '有效期：${model.couponList[index].timeEnd}',
                                          style: MyTextStyle.text15grayStyle,
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ))
                          ],
                        ),
                        Positioned(
                            left: 90.w,
                            top: -10.h,
                            child: ClipOval(
                              child: Container(
                                color: MyColor.tvDDDColor,
                                width: 20.w,
                                height: 20.w,
                              ),
                            )),
                        Positioned(
                            left: 90.w,
                            bottom: -10.h,
                            child: ClipOval(
                              child: Container(
                                color: MyColor.tvDDDColor,
                                width: 20.w,
                                height: 20.w,
                              ),
                            )),
                      ],
                    ),
                  ),
                  itemCount: model.couponList.length,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement viewModel
  DiscountCouponPageModel get viewModel => DiscountCouponPageModel();
}
