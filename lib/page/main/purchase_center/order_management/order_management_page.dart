import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../project_imports.dart';
import 'order_management_page_model.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:订单管理UI

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({super.key});

  @override
  State<OrderManagementPage> createState() => _OrderManagementPageState();
}

class _OrderManagementPageState
    extends BaseState<OrderManagementPageModel, OrderManagementPage> {
  @override
  Widget getContentChild(OrderManagementPageModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('订单管理', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: MyColor.tvDDDColor,
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              decoration: myBoxDecoration(backColor: Colors.white),
              height: 50.h,
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      '时间',
                      style: MyTextStyle.text15blackStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 60.w),
                    child: Text(
                      '金额(元)',
                      style: MyTextStyle.text15blackStyle,
                    ),
                  ),
                  Text(
                    '支付方式',
                    style: MyTextStyle.text15blackStyle,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: model.orderDataList.isEmpty
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          'images/empty_icon.png',
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    : SmartRefresher(
                        controller: model.refreshController,
                        onRefresh: model.refresh,
                        onLoading: model.loadMore,
                        enablePullUp: true,
                        enablePullDown: true,
                        child: ListView.builder(
                          itemBuilder: (c, index) => Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 1.h),
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            height: 100.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 90.w,
                                  child: Text(
                                    model.orderDataList[index].createAt,
                                    style: MyTextStyle.text15blackStyle,
                                  ),
                                ),
                                Text(
                                  model.orderDataList[index].price,
                                  style: MyTextStyle.text15blackStyle,
                                ),
                                Text(
                                  typeString(model.orderDataList[index].type),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: textColor(
                                          model.orderDataList[index].type)),
                                ),
                              ],
                            ),
                          ),
                          itemCount: model.orderDataList.length,
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  ///支付状态显示的文字
  String typeString(int type) {
    String typeString = '';
    switch (type) {
      case 1:
        typeString = '微信';
        break;
      case 2:
        typeString = '支付宝';
        break;
      case 3:
        typeString = '对公';
        break;
    }
    return typeString;
  }

  ///支付状态显示的颜色
  Color textColor(int type) {
    Color color = MyColor.grayCCCColor;
    switch (type) {
      case 1:
        color = MyColor.themeColor;
        break;
      case 2:
        color = Colors.lightBlue;
        break;
      case 3:
        color = MyColor.grayCCCColor;
        break;
    }
    return color;
  }

  @override
  // TODO: implement viewModel
  OrderManagementPageModel get viewModel => OrderManagementPageModel();
}
