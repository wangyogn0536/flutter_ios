import 'package:agent_app_vpn/project_imports.dart';
import 'package:tobias/tobias.dart' as tobias;

import '../../personal/personal_page.dart';
import '../../personal/select_coupon_list/select_coupon_list_page.dart';
import '../../tab_bar_page.dart';
import 'renew_server_list_page_model.dart';

///选择后带宽的全局变量
int? dwType;

/// Created by 刘冰.
/// Date:2024/5/23
/// des:续费弹框

class PayRenewWidget extends StatefulWidget {
  String balanceString;
  List<int> orderIdList;
  String firstPrice;
  int daikuan;
  PayRenewWidget({
    super.key,
    required this.balanceString,
    required this.orderIdList,
    required this.firstPrice,
    required this.daikuan,
  });
  @override
  State<PayRenewWidget> createState() => _PayRenewWidgetState();
}

class _PayRenewWidgetState
    extends BaseState<RenewServerListModel, PayRenewWidget> {
  bool isRemainingPay = true;
  bool isWeChatPay = false;
  bool isAlipayPay = false;
  String payWayStr = '';
  int payType = 4;
  int? dCode; //优惠券id
  String selectTimeText = ConfigString.pleaseSelectTime;
  String? _selectedItem; //选择购买时间下拉菜单
  int? _selectedIndex; //选择购买时间的元素索引
  List<String> buyTime = [
    '1个月',
    '3个月',
    '6个月',
    '1年',
    '3年',
  ];
  @override
  Widget getContentChild(RenewServerListModel model) {
    // TODO: implement getContentChild
    return showDialogWidget(Container(
      height: 370.h,
      padding: EdgeInsets.only(top: 15.h),
      decoration: myBoxDecoration(backColor: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '续费时间',
                      style: MyTextStyle.text17blackStyle,
                    ),
                    Center(
                      child: DropdownButton<String>(
                        value: _selectedItem,
                        icon: null,
                        // 取消阴影效果
                        elevation: 1,
                        items: buyTime
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 17.w, top: 10.h),
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (value == '3个月' ||
                                    value == '6个月' ||
                                    value == '1年' ||
                                    value == '3年')
                                  Positioned(
                                      child: Image.asset(
                                    discountImageAsset(value),
                                    width: 30.w,
                                    height: 30.w,
                                  )),
                              ],
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          selectTimeText,
                          style: MyTextStyle.text15gray888Style,
                        ),
                        alignment: AlignmentDirectional.center,
                        //
                        style: MyTextStyle.text15blackStyle,
                        onChanged: (String? newValue) {
                          setState(() {
                            dCode = null;
                            _selectedItem = newValue!;
                            _selectedIndex = buyTime.indexOf(newValue);
                            switch (buyTime.indexOf(newValue)) {
                              case 0:
                                _selectedIndex = 1;
                                break;
                              case 1:
                                _selectedIndex = 3;
                                break;
                              case 2:
                                _selectedIndex = 6;
                                break;
                              case 3:
                                _selectedIndex = 12;
                                break;
                              case 4:
                                _selectedIndex = 36;
                                break;
                            }
                            model.getPrice(widget.orderIdList, _selectedIndex!);
                            model.usableCouponsAPI(model.price);
                          });
                        },
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Container(
                    //       width: 25.w,
                    //       height: 25.w,
                    //       margin: EdgeInsets.only(right: 20.w),
                    //       child: FloatingActionButton(
                    //         backgroundColor: timeIndex > 1
                    //             ? MyColor.themeColor
                    //             : MyColor.grayCCCColor, // 背景颜色
                    //         elevation: 1.0,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(2.w), // 圆角大小
                    //         ),
                    //         onPressed: timeIndex > 1
                    //             ? () {
                    //                 setState(() {
                    //                   timeIndex--;
                    //                   dCode = null;
                    //                   model.month = timeIndex;
                    //                 });
                    //                 model.getPrice(
                    //                   widget.orderIdList,
                    //                 );
                    //                 // model.usableCouponsAPI(model.price);
                    //               }
                    //             : null,
                    //         child: Center(
                    //           child: Text(
                    //             '-',
                    //             style: MyTextStyle.text17whiteStyle,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Text(
                    //       '$timeIndex月',
                    //       style: MyTextStyle.text17blackStyle,
                    //     ),
                    //     Container(
                    //       width: 25.w,
                    //       height: 25.w,
                    //       margin: EdgeInsets.only(left: 20.w),
                    //       child: FloatingActionButton(
                    //         elevation: 1.0,
                    //         backgroundColor: MyColor.themeColor, // 背景颜色
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(2.w), // 圆角大小
                    //         ),
                    //         onPressed: () {
                    //           setState(() {
                    //             timeIndex++;
                    //             model.month = timeIndex;
                    //
                    //             dCode = null;
                    //           });
                    //           model.getPrice(
                    //             widget.orderIdList,
                    //           );
                    //           // model.usableCouponsAPI(model.price);
                    //         },
                    //         child: Center(
                    //           child: Text(
                    //             '+',
                    //             style: MyTextStyle.text17whiteStyle,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h),
                color: MyColor.tvDDDColor,
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 15.h),
                child: Text(
                  '付款方式',
                  style: MyTextStyle.text17blackStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h),
                color: MyColor.tvDDDColor,
                child: Column(
                  children: [
                    PayWayWidget('images/balance_payment.png', '余额支付', true,

                        ///${widget.money}
                        delText: '（可用:${widget.balanceString}元）', () {
                      payWayStr = '余额支付';
                      payType = 4;
                      setState(() {
                        isRemainingPay = true;
                        isWeChatPay = false;
                        isAlipayPay = false;
                      });
                    }, isRemainingPay),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    //   child: PayWayWidget(
                    //       'images/weChat_pay_icon.png', '微信支付', false,
                    //       delText: '', () {
                    //     payWayStr = '微信支付';
                    //     payType = 1;
                    //     setState(() {
                    //       isRemainingPay = false;
                    //       isWeChatPay = true;
                    //       isAlipayPay = false;
                    //     });
                    //   }, isWeChatPay),
                    // ),
                    PayWayWidget(
                        'images/pay_by_alipay_icon.png', '支付宝支付', false,
                        delText: '', () {
                      payWayStr = '支付宝支付';
                      payType = 2;
                      setState(() {
                        isRemainingPay = false;
                        isWeChatPay = false;
                        isAlipayPay = true;
                      });
                    }, isAlipayPay),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 50.h,
                margin: EdgeInsets.only(bottom: 5.h),
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '优惠券',
                      style: MyTextStyle.text17blackStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Future selectCoupon = navigationPush(
                            context,
                            SelectCouponListPage(
                              isResidence: false,
                              model.selectCouponList,
                              purchaseTypes: 2,
                              selectBandwidthIndex: daikuanType(widget.daikuan),
                              maxSelectIndex: 1,
                              timeIndex: _selectedIndex!,
                              orderIdList: widget.orderIdList,
                            ));
                        selectCoupon.then((value) {
                          setState(() {
                            dCode = value.id;
                            model.getPrice(widget.orderIdList, _selectedIndex!,
                                dcode: dCode);
                            model.usableCouponsAPI(model.price, success: () {
                              model.selectCouponText =
                                  '${value.title} 减${value.price}元';
                            });
                          });
                        });
                      },
                      child: Text(
                        model.selectCouponText,
                        style: model.selectCouponList.isEmpty
                            ? MyTextStyle.text17grayStyle
                            : TextStyle(
                                fontSize: 17.sp,
                                color: MyColor.orangeColor,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80.h,
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                decoration: myBoxDecoration(backColor: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '总计：',
                          style: MyTextStyle.text20blackStyle,
                        ),
                        Text(
                          // ///${widget.payMoney}
                          model.price == ''
                              ? '¥${widget.firstPrice}'
                              : '¥${model.price}',
                          style: TextStyle(
                              fontSize: 20.sp, color: MyColor.orangeColor),
                        ),
                        /*
                        *  model.price != model.oPrice
                              ? Text(
                                  '${model.oPrice}',
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      color: MyColor.gray888Color,
                                      decoration: TextDecoration.lineThrough),
                                )
                              : const Center()
                        * */
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            model.oPrice == model.price ? '' : model.oPrice,
                            style: TextStyle(
                                fontSize: 17.sp,
                                color: MyColor.gray888Color,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ],
                    ),
                    ThemeTitleButton(
                        size: Size(120.w, 35.h),
                        backgroudColor: MyColor.themeColor,
                        title: '立即付款',
                        titleFont: 15,
                        titleColor: Colors.white,
                        onTap: () {
                          if (_selectedIndex == null) {
                            MessageToast.toast('请先选择续费时间');
                            return;
                          }
                          if (payType == 4) {
                            MessageToast.alert('确定要余额支付吗', context,
                                confirm: () {
                              model.paymentStatic(
                                  widget.orderIdList, _selectedIndex!, payType,
                                  dcode: dCode, paySuccess: () {
                                MessageToast.toast('余额支付成功');
                                // Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TabBarPage(),
                                  ),
                                  (route) => false,
                                );
                              });
                            });
                          } else {
                            model.paymentStatic(
                                widget.orderIdList, _selectedIndex!, payType,
                                dcode: dCode, wechatPaySuccess: () {
                              MessageToast.toast('暂未开通微信支付，请选择其他支付方式');
                            }, alipayPaySuccess: () {
                              tobias.isAliPayInstalled().then((value) => {
                                    if (!value)
                                      {
                                        MessageToast.toast('请先安装支付宝'),
                                      }
                                    else
                                      {
                                        tobias
                                            .aliPay(model.alipayPay)
                                            .then((payRes) => {
                                                  if (payRes['resultStatus'] ==
                                                          9000 ||
                                                      payRes['resultStatus'] ==
                                                          '9000')
                                                    {
                                                      MessageToast.toast(
                                                          '支付成功'),

                                                      ///进入主页
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const TabBarPage(),
                                                        ),
                                                        (route) => false,
                                                      ),
                                                    }
                                                  else
                                                    {
                                                      MessageToast.toast(
                                                          payRes['memo']),
                                                    }
                                                }),
                                      }
                                  });
                            });
                          }
                        })
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  String discountImageAsset(String value) {
    String discountString = '';
    if (value == '3个月') {
      discountString = 'images/98discount_icon.png';
    }
    if (value == '6个月') {
      discountString = 'images/95discount_icon.png';
    }
    if (value == '1年') {
      discountString = 'images/9discount_icon.png';
    }
    if (value == '3年') {
      discountString = 'images/85discount_icon.png';
    }
    return discountString;
  }

  String daikuanType(int daikuan) {
    String type = '';
    switch (daikuan) {
      case 5:
        type = '1';
        break;
      case 10:
        type = '2';
        break;
      case 20:
        type = '3';
        break;
    }
    return type;
  }

  @override
  // TODO: implement viewModel
  RenewServerListModel get viewModel => RenewServerListModel();
}
