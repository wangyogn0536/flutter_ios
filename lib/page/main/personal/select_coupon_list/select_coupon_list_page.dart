import 'package:agent_app_vpn/page/main/personal/select_coupon_list/select_coupon_list_model.dart';

import '../../../../data/usable_coupon_bean_entity.dart';
import '../../../../project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:优惠券列表页
class SelectCouponListPage extends StatefulWidget {
  bool isResidence; //是否是住宅
  String selectBandwidthIndex; //选择带宽
  int maxSelectIndex; //最大选择数量
  int timeIndex; //购买时长
  List<UsableCouponBeanDataYouhuiquan> selectCouponList;
  int purchaseTypes; //1.购买 2.续费
  List<int> orderIdList; //续费需要的数组id
  SelectCouponListPage(this.selectCouponList,
      {super.key,
      required this.isResidence,
      required this.selectBandwidthIndex,
      required this.purchaseTypes,
      required this.maxSelectIndex,
      required this.orderIdList,
      required this.timeIndex});

  @override
  State<SelectCouponListPage> createState() => _SelectCouponListPageState();
}

class _SelectCouponListPageState
    extends BaseState<SelectCouponListModel, SelectCouponListPage> {
  @override
  Widget getContentChild(SelectCouponListModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('选择优惠券', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          color: MyColor.tvDDDColor,
          image: widget.selectCouponList.isEmpty
              ? const DecorationImage(
                  image: AssetImage('images/empty_icon.png'),
                  fit: BoxFit.fitWidth,
                )
              : null,
        ),
        child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
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
                            '¥${widget.selectCouponList[index].price}',
                            style:
                                TextStyle(fontSize: 24.sp, color: Colors.white),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6.h),
                                    child: Text(
                                      widget.selectCouponList[index].title,
                                      style: MyTextStyle.text17blackStyle,
                                    ),
                                  ),
                                  Text(
                                    '满${widget.selectCouponList[index].useMinPrice}元可用',
                                    style: MyTextStyle.text15grayStyle,
                                  ),
                                  Text(
                                    '有效期：${widget.selectCouponList[index].timeEnd}',
                                    style: MyTextStyle.text15grayStyle,
                                  )
                                ],
                              ),
                            )),
                            Container(
                              width: 1.w,
                              color: MyColor.grayCCCColor,
                            ),
                            InkWell(
                              onTap: () {
                                switch (widget.purchaseTypes) {
                                  case 1:
                                    if (widget.isResidence) {
                                      model.getResidencePrice(
                                          '22',
                                          widget.timeIndex,
                                          widget.maxSelectIndex,
                                          dcode: widget.selectCouponList[index]
                                              .id, isPops: () {
                                        Navigator.pop(context,
                                            widget.selectCouponList[index]);
                                      });
                                    } else {
                                      model.getStaticPrice(
                                          '${widget.selectBandwidthIndex}',
                                          widget.timeIndex,
                                          widget.maxSelectIndex,
                                          dcode: widget.selectCouponList[index]
                                              .id, isPops: () {
                                        Navigator.pop(context,
                                            widget.selectCouponList[index]);
                                      });
                                    }
                                    // model.getPrice(
                                    //     model
                                    //         .productTypeList[
                                    //             model.selectBandwidthIndex]
                                    //         .url
                                    //         .price,
                                    //     widget.selectBandwidthIndex,
                                    //     widget.timeIndex,
                                    //     widget.maxSelectIndex,
                                    //     model
                                    //         .productTypeList[
                                    //             model.selectBandwidthIndex]
                                    //         .typeId,
                                    //     dcode: widget.selectCouponList[index]
                                    //         .id, isPops: () {
                                    //   Navigator.pop(context,
                                    //       widget.selectCouponList[index]);
                                    // });
                                    break;
                                  case 2:
                                    model.getRenewPrice(
                                        widget.orderIdList, widget.timeIndex,
                                        dcode: widget.selectCouponList[index]
                                            .id, isPops: () {
                                      Navigator.pop(context,
                                          widget.selectCouponList[index]);
                                    });
                                    break;
                                }
                              },
                              child: Container(
                                width: 50.w,
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    '立\n即\n使\n用',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: MyColor.couponColor),
                                  ),
                                ),
                              ),
                            ),
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
            itemCount: widget.selectCouponList.length,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement viewModel
  SelectCouponListModel get viewModel => SelectCouponListModel();
}
