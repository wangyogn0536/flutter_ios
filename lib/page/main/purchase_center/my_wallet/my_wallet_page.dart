import 'dart:io';

import 'package:tobias/tobias.dart' as tobias;

import '../../../../project_imports.dart';
import 'my_wallet_page_model.dart';

///支付方式全局变量
/// Created by 刘冰.
/// Date:2024/5/23
/// des:我的钱包UI

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends BaseState<MyWalletModel, MyWalletPage> {
  List<int> sumList = [50, 100, 200, 500, 1000, 3000];
  //测试数据
  // List<double> sumList = [0.01, 0.01, 0.01, 0.01, 0.01, 0.01];
  final List<bool> _selected = List.generate(6, (index) => false);
  int payMoney = 0;
  int payType = 1;
  @override
  Widget getContentChild(MyWalletModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('我的钱包', [], isBack: true),
      body: Container(
        color: MyColor.tvDDDColor,
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              height: 145.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5.r),
                image: const DecorationImage(
                  image: AssetImage('images/my_wallet_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '钱包余额(元）',
                    style: MyTextStyle.text20whiteStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(model.money,
                        style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              // height: 235.h,
              margin: EdgeInsets.only(top: 20.h),
              padding: EdgeInsets.all(15.w),
              decoration: myBoxDecoration(backColor: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '充值金额',
                    style: MyTextStyle.text17blackStyle,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.h),
                    color: Colors.white,
                    child: Stack(
                      children: [
                        GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20.h, // 主轴（垂直）间距
                          crossAxisSpacing: 20.w, // 交叉轴（水平）间距
                          childAspectRatio: 1.6, // 宽高比
                          shrinkWrap: true,
                          children: List.generate(
                              sumList.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < _selected.length;
                                            i++) {
                                          _selected[i] = false;
                                        }
                                        _selected[index] = true;
                                        payMoney = sumList[index];
                                      });
                                    },
                                    child: Container(
                                      decoration: myBoxDecoration(
                                          backColor: _selected[index]
                                              ? MyColor.realNameColor
                                              : Colors.white),
                                      child: Center(
                                        child: Text(
                                          '¥${sumList[index]}',
                                          style: MyTextStyle.text20blackStyle,
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                        // Positioned(
                        //     bottom: 0,
                        //     right: 0,
                        //     child: SizedBox(
                        //       height: 68.h,
                        //       width: 105.w,
                        //       child: Container(
                        //         decoration:
                        //             myBoxDecoration(backColor: Colors.white),
                        //         child: Center(
                        //           child: Text(
                        //             '自定义',
                        //             style: MyTextStyle.text17blackStyle,
                        //           ),
                        //         ),
                        //       ),
                        //     )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Platform.isAndroid
                ? Container(
                    // height: 175.h,
                    margin: EdgeInsets.only(top: 20.w),
                    decoration: myBoxDecoration(backColor: Colors.white),
                    child: PaymentWayWidget(_updateValue),
                  )
                : const Center(),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: ThemeTitleButton(
                  size: Size(double.infinity, 50.h),
                  backgroudColor: MyColor.themeColor,
                  title: '立即充值',
                  titleFont: 15,
                  titleColor: Colors.white,
                  onTap: () {
                    if (Platform.isAndroid) {
                      if (payMoney == 0) {
                        MessageToast.toast('请选择充值金额');
                        return;
                      }
                      if (payType == 1) {
                        MessageToast.toast('暂未开通微信支付');
                        return;
                      }
                      print('立即充值金额--$payMoney---支付方式------$payType');
                      model.payMoneyMessage('$payMoney', '$payType',
                          successOnTap: (pay) {
                        tobias.isAliPayInstalled().then((value) => {
                              if (!value)
                                {
                                  MessageToast.toast('请先安装支付宝'),
                                }
                              else
                                {
                                  tobias.aliPay(pay).then((payRes) => {
                                        if (payRes['resultStatus'] == 9000 ||
                                            payRes['resultStatus'] == '9000')
                                          {
                                            MessageToast.toast('支付成功'),
                                            model.memberInfoAPI(),
                                          }
                                        else
                                          {
                                            MessageToast.toast(payRes['memo']),
                                          }
                                      }),
                                }
                            });
                      });
                    } else {
                      MessageToast.noCancelAlert(
                          '提示', '暂未开通苹果充值功能，请到官网进行充值', context);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _updateValue(int newValue) {
    setState(() {
      payType = newValue;
    });
  }

  @override
  // TODO: implement viewModel
  MyWalletModel get viewModel => MyWalletModel();
}

class PaymentWayWidget extends StatefulWidget {
  final ValueChanged<int> onValueChanged;
  const PaymentWayWidget(this.onValueChanged, {super.key});

  @override
  State<PaymentWayWidget> createState() => _PaymentWayWidgetState();
}

class _PaymentWayWidgetState extends State<PaymentWayWidget> {
  bool isWeChatPay = true;
  bool isAlipayPay = false;
  String payWayStr = '支付宝支付';
  int payType = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 250.h,
      padding: EdgeInsets.only(top: 20.h),
      decoration: myBoxDecoration(backColor: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  '付款方式',
                  style: MyTextStyle.text17blackStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                color: MyColor.tvDDDColor,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    //   child: PayWayWidget('images/weChat_pay_icon.png', '微信支付',
                    //       () {
                    //     payWayStr = '微信支付';
                    //     setState(() {
                    //       isWeChatPay = true;
                    //       isAlipayPay = false;
                    //       payType = 1;
                    //       widget.onValueChanged(payType);
                    //     });
                    //   }, isWeChatPay),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 1.h),
                      height: 60.h,
                      child: PayWayWidget(
                          'images/pay_by_alipay_icon.png', '支付宝支付', () {
                        payWayStr = '支付宝支付';
                        setState(() {
                          isWeChatPay = false;
                          isAlipayPay = true;
                          payType = 2;
                          widget.onValueChanged(payType);
                        });
                      }, isAlipayPay),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PayWayWidget extends StatelessWidget {
  final String imageName;
  final String title;
  final VoidCallback onTap;
  final bool isSelect;
  const PayWayWidget(this.imageName, this.title, this.onTap, this.isSelect,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        height: 45.h,
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  imageName,
                  width: 20,
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    title,
                    style: MyTextStyle.text15blackStyle,
                  ),
                ),
              ],
            ),
            Image.asset(
              isSelect
                  ? 'images/succeed_icon.png'
                  : 'images/not_selected_icon.png',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
// class SelectSumWidget extends StatelessWidget {
//   final int sum;
//   final int index;
//   const SelectSumWidget(this.sum, this.index, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }
