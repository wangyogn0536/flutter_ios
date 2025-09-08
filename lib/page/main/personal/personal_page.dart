import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:tobias/tobias.dart' as tobias;

import '../../../project_imports.dart';
import '../home/server_list/server_list_page.dart';
import '../tab_bar_page.dart';
import 'Personal_page_model.dart';
import 'city_select_node/city_select_node_page.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:购买UI

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends BaseState<PersonalPageModel, PersonalPage> {
  bool isResidence = false; //是否是住宅
  bool isShare = false; //是否是共享
  bool isLink = false; //是否是联通
  bool _is5MHighlight = true;
  bool _is10MHighlight = false;
  bool _is20MHighlight = false;
  int selectBandwidthIndex = 1;
  int iosTimeIndex = 1; //购买时长
  int payIndex = 0; //购买数量
  int iosSelectBandwidthIndex = 0;
  String selectNodeText = ConfigString.pleaseSelectServer;
  String selectTimeText = ConfigString.pleaseSelectTime;
  int maxSelectIndex = 0; //最大选择数量
  int areaId = 0; //省份id
  int serverId = 0; //节点id
  int? iOSSelectIndex;
  int? dCode;
  BuyEngine buyEngine = BuyEngine();

  ///苹果端数据(静态)
  List<Map<String, dynamic>> data = [
    {
      '5M': [
        {
          'title': '包月套餐',
          'price': 38,
          'time': 1,
        },
        {
          'title': '包季套餐',
          'price': 108,
          'time': 3,
        },
        {
          'title': '半年套餐',
          'price': 218,
          'time': 6,
        },
        {
          'title': '包年套餐',
          'price': 433,
          'time': 12,
        }
      ]
    },
    {
      '10M': [
        {
          'title': '包月套餐',
          'price': 48,
          'time': 1,
        },
        {
          'title': '包季套餐',
          'price': 144,
          'time': 3,
        },
        {
          'title': '半年套餐',
          'price': 288,
          'time': 6,
        },
        {
          'title': '包年套餐',
          'price': 578,
          'time': 12,
        }
      ]
    },
    {
      '20M': [
        {
          'title': '包月套餐',
          'price': 84,
          'time': 1,
        },
        {
          'title': '包季套餐',
          'price': 253,
          'time': 3,
        },
        {
          'title': '半年套餐',
          'price': 508,
          'time': 6,
        },
        {
          'title': '包年套餐',
          'price': 1048,
          'time': 12,
        }
      ]
    },
  ];
  List<Map<String, dynamic>> selectList(int bandwidthIndex) {
    List<Map<String, dynamic>> selectList = [];
    switch (bandwidthIndex) {
      case 0:
        selectList = data.firstWhere((item) => item.keys.contains('5M'),
            orElse: () => {})['5M'];
        break;
      case 1:
        selectList = data.firstWhere((item) => item.keys.contains('10M'),
            orElse: () => {})['10M'];
        break;
      case 2:
        selectList = data.firstWhere((item) => item.keys.contains('20M'),
            orElse: () => {})['20M'];
        break;
    }
    return selectList;
  }

  ///苹果端数据(住宅)
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget getContentChild(PersonalPageModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar(
        '套餐购买',
        [],
        isBack: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: MyColor.tvDDDColor,
              // height: ScreenUtil().screenHeight,
              margin: EdgeInsets.only(bottom: 70.h),
              padding: EdgeInsets.only(
                  top: 20.h, left: 20.w, right: 20.w, bottom: 90.h),
              child: Column(
                children: [
                  isResidence
                      ? Container(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
                          decoration: myBoxDecoration(backColor: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    ConfigString.selectType,
                                    style: MyTextStyle.text17blackStyle,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 40.w),
                                    child: Row(
                                      children: [
                                        PersonalSelectBandwidthBtn(
                                            title: '共享型',
                                            value: 0,
                                            isHighlight: !isShare,
                                            onChanged: (value) {
                                              setState(() {
                                                isShare = false;
                                              });
                                            }),
                                        // PersonalSelectBandwidthBtn(
                                        //     title: '独享型',
                                        //     value: 0,
                                        //     isHighlight: isShare,
                                        //     onChanged: (value) {
                                        //       setState(() {
                                        //         isShare = true;
                                        //       });
                                        //     }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      ConfigString.selectBusiness,
                                      style: MyTextStyle.text17blackStyle,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 40.w),
                                      child: Row(
                                        children: [
                                          PersonalSelectBandwidthBtn(
                                              title: '联通',
                                              value: 0,
                                              isHighlight: isLink,
                                              onChanged: (value) {
                                                setState(() {
                                                  isLink = true;
                                                });
                                              }),
                                          PersonalSelectBandwidthBtn(
                                              title: '电信',
                                              value: 0,
                                              isHighlight: !isLink,
                                              onChanged: (value) {
                                                setState(() {
                                                  isLink = false;
                                                });
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 50.h,
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                          ),
                          decoration: myBoxDecoration(backColor: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Text(
                                  ConfigString.selectBandwidth,
                                  style: MyTextStyle.text17blackStyle,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PersonalSelectBandwidthBtn(
                                      title: ConfigString.text5M,
                                      value: 1,
                                      isHighlight: _is5MHighlight,
                                      onChanged: (value) {
                                        setState(() {
                                          _is5MHighlight = true;
                                          _is10MHighlight = false;
                                          _is20MHighlight = false;
                                          selectNodeText =
                                              ConfigString.pleaseSelectServer;
                                          selectBandwidthIndex = 1;
                                          iosSelectBandwidthIndex = 0;
                                          iOSSelectIndex = null;
                                        });
                                        model.price = '0.00';
                                        model.oPrice = '0.00';
                                      }),
                                  PersonalSelectBandwidthBtn(
                                      title: ConfigString.text10M,
                                      value: 1,
                                      isHighlight: _is10MHighlight,
                                      onChanged: (value) {
                                        setState(() {
                                          _is5MHighlight = false;
                                          _is10MHighlight = true;
                                          _is20MHighlight = false;
                                          selectNodeText =
                                              ConfigString.pleaseSelectServer;
                                          selectBandwidthIndex = 2;
                                          iosSelectBandwidthIndex = 1;
                                          iOSSelectIndex = null;
                                        });
                                        model.price = '0.00';
                                        model.oPrice = '0.00';
                                      }),
                                  PersonalSelectBandwidthBtn(
                                      title: ConfigString.text20M,
                                      value: 1,
                                      isHighlight: _is20MHighlight,
                                      onChanged: (value) {
                                        setState(() {
                                          _is5MHighlight = false;
                                          _is10MHighlight = false;
                                          _is20MHighlight = true;
                                          selectNodeText =
                                              ConfigString.pleaseSelectServer;
                                          selectBandwidthIndex = 3;
                                          iosSelectBandwidthIndex = 2;
                                          iOSSelectIndex = null;
                                        });
                                        model.price = '0.00';
                                        model.oPrice = '0.00';
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                  Column(
                    children: [
                      Container(
                        decoration: myBoxDecoration(backColor: Colors.white),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        height: 50.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '城市节点',
                              style: MyTextStyle.text17blackStyle,
                            ),
                            GestureDetector(
                              onTap: () {
                                Future selectCityNode = navigationPush(
                                    context,
                                    CitySelectNodePage('$selectBandwidthIndex',
                                        isResidence, isShare, isLink));
                                selectCityNode.then((value) {
                                  final result = value as StaticCustomParams;
                                  setState(() {
                                    // model.price = '5.00';
                                    maxSelectIndex = result
                                        .staticNodeListDataNodeChilder.num;
                                    areaId = result.staticNodeListDataNode.id;
                                    serverId =
                                        result.staticNodeListDataNodeChilder.id;
                                    selectNodeText = result
                                        .staticNodeListDataNodeChilder.name;
                                    dCode = null;
                                  });
                                });
                              },
                              child: Text(
                                selectNodeText,
                                style: selectNodeText ==
                                        ConfigString.pleaseSelectServer
                                    ? MyTextStyle.text17grayStyle
                                    : MyTextStyle.text17blackStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20.h),
                        padding: EdgeInsets.all(15.w),
                        decoration: myBoxDecoration(backColor: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '选择套餐',
                              style: MyTextStyle.text17blackStyle,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              height: 278.h,
                              child: ListView.builder(
                                itemBuilder: (c, index) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      iOSSelectIndex = index;
                                      model.price =
                                          '${selectList(iosSelectBandwidthIndex)[iOSSelectIndex!]['price']}';
                                      model.oPrice =
                                          '${selectList(iosSelectBandwidthIndex)[iOSSelectIndex!]['price']}';
                                      iosTimeIndex =
                                          selectList(iosSelectBandwidthIndex)[
                                              iOSSelectIndex!]['time'];
                                    });
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 5.h, bottom: 5.h),
                                    padding: EdgeInsets.only(
                                        left: 20.w, right: 20.w),
                                    decoration: myBoxDecoration(
                                        backColor: iOSSelectIndex == index
                                            ? MyColor.orangeColor
                                            : MyColor.iOSSelectColor),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          selectList(iosSelectBandwidthIndex)[
                                              index]['title'],
                                          style: iOSSelectIndex == index
                                              ? MyTextStyle.text17whiteStyle
                                              : MyTextStyle.text17blackStyle,
                                        ),
                                        Text(
                                          '¥${selectList(iosSelectBandwidthIndex)[index]['price']}',
                                          style: iOSSelectIndex == index
                                              ? MyTextStyle.text17whiteStyle
                                              : MyTextStyle.text17blackStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                itemCount:
                                    selectList(iosSelectBandwidthIndex).length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    padding: EdgeInsets.all(20.w),
                    width: double.infinity,
                    decoration: myBoxDecoration(backColor: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '购买须知：',
                          style: MyTextStyle.text17blackStyle,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            model.purchaseNotesText,
                            style: MyTextStyle.text15grayStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0.h,
              child: Container(
                height: 60.h,
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                decoration: myBoxDecoration(backColor: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '总计',
                          style: MyTextStyle.text20blackStyle,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '¥${model.price}',
                            style: TextStyle(
                                fontSize: 20.sp, color: MyColor.orangeColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: model.price != model.oPrice
                              ? Text(
                                  '¥${model.oPrice}',
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      color: MyColor.gray888Color,
                                      decoration: TextDecoration.lineThrough),
                                )
                              : const Center(),
                        ),
                      ],
                    ),
                    ThemeTitleButton(
                        size: Size(120.w, 35.h),
                        backgroudColor: MyColor.themeColor,
                        title: '去支付',
                        titleFont: 15,
                        titleColor: Colors.white,
                        onTap: () {
                          if (selectNodeText ==
                              ConfigString.pleaseSelectServer) {
                            Future selectCityNode = navigationPush(
                                context,
                                CitySelectNodePage('$selectBandwidthIndex',
                                    isResidence, isShare, isLink));
                            selectCityNode.then((value) {
                              if (isResidence) {
                                final residenceResult =
                                    value as ProductCustomParams;
                                setState(() {
                                  if (isLink) {
                                    maxSelectIndex = residenceResult
                                        .productNodeListDataNodeChilder.lt;
                                  } else {
                                    maxSelectIndex = residenceResult
                                        .productNodeListDataNodeChilder.dx;
                                  }

                                  areaId = residenceResult
                                      .productNodeListDataNode.id;
                                  serverId = residenceResult
                                      .productNodeListDataNodeChilder.id;
                                  selectNodeText = residenceResult
                                      .productNodeListDataNodeChilder.name;
                                });
                              } else {
                                final staticResult =
                                    value as StaticCustomParams;
                                setState(() {
                                  maxSelectIndex = staticResult
                                      .staticNodeListDataNodeChilder.num;
                                  areaId =
                                      staticResult.staticNodeListDataNode.id;
                                  serverId = staticResult
                                      .staticNodeListDataNodeChilder.id;
                                  selectNodeText = staticResult
                                      .staticNodeListDataNodeChilder.name;
                                });
                              }
                            });
                            MessageToast.toast(ConfigString.pleaseSelectServer);
                            return;
                          }
                          if (Platform.isIOS) {
                            if (iOSSelectIndex == null) {
                              MessageToast.toast('请选择套餐');
                              return;
                            }
                            model.paymentStatic(
                                100,
                                '$selectBandwidthIndex',
                                iosTimeIndex,
                                selectNodeText,
                                areaId,
                                serverId,
                                1, iOSPaySuccess: () {
                              String appProductID = '';
                              // VoidCallback onTop;
                              switch (selectBandwidthIndex) {
                                case 1:
                                  switch (iosTimeIndex) {
                                    case 1:
                                      appProductID =
                                          'com.zhongqi.app.agent.5M.monthly.package';
                                      break;
                                    case 3:
                                      appProductID =
                                          'com.zhongqi.app.agent.5M.quarter.package';
                                      break;
                                    case 6:
                                      appProductID =
                                          'com.zhongqi.app.agent.5M.half.year.package';
                                      break;
                                    case 12:
                                      appProductID =
                                          'com.zhongqi.app.agent.5M.year.package';
                                      break;
                                  }
                                  break;
                                case 2:
                                  switch (iosTimeIndex) {
                                    case 1:
                                      appProductID =
                                          'com.zhongqi.app.agent.10M.monthly.package';
                                      break;
                                    case 3:
                                      appProductID =
                                          'com.zhongqi.app.agent.10M.quarter.package';
                                      break;
                                    case 6:
                                      appProductID =
                                          'com.zhongqi.app.agent.10M.half.year.package';
                                      break;
                                    case 12:
                                      appProductID =
                                          'com.zhongqi.app.agent.10M.year.package';
                                      break;
                                  }
                                  break;
                                case 3:
                                  switch (iosTimeIndex) {
                                    case 1:
                                      appProductID =
                                          'com.zhongqi.app.agent.20M.monthly.package';
                                      break;
                                    case 3:
                                      appProductID =
                                          'com.zhongqi.app.agent.20M.quarter.package';
                                      break;
                                    case 6:
                                      appProductID =
                                          'com.zhongqi.app.agent.20M.half.year.package';
                                      break;
                                    case 12:
                                      appProductID =
                                          'com.zhongqi.app.agent.20M.year.package';
                                      break;
                                  }
                                  break;
                              }
                              print('我所选择的ID：$appProductID');
                              buyEngine.buyProduct(appProductID, (iosData) {
                                DateTime nowTime = DateTime.now();
                                String dateTime =
                                    '${nowTime.millisecondsSinceEpoch ~/ 1000}';
                                var sign = md5.convert(const Utf8Encoder().convert(
                                    'orderno:${model.iOSOrderNo};datetime:$dateTime;token:kjhkldfalasdhflihgikjdolajikldsh${DateFormat('yyyyMMdd').format(nowTime)}'));
                                model.iosPaySuccessData(
                                    sign.toString(),
                                    dateTime,
                                    iosData['transaction_id'],
                                    iosData);
                              });
                              _subscription.cancel();
                              // buyEngine.buyProduct(appProductID, (tradeNo) {
                              //
                              // });
                            });
                          }
                        })
                  ],
                ),
              ))
        ],
      ),
    );
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  // TODO: implement viewModel
  PersonalPageModel get viewModel => PersonalPageModel();
}

class PersonalSelectBandwidthBtn extends StatelessWidget {
  final String title;
  final int value;
  final bool isHighlight;
  final ValueChanged<int> onChanged;
  const PersonalSelectBandwidthBtn(
      {super.key,
      required this.title,
      required this.value,
      required this.isHighlight,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: SelectBandwidthBtn(title, isHighlight, onChanged,
          value: value,
          selectImage: 'images/select_radio_button_icon.png',
          image: 'images/radio_button_icon.png',
          titleSize: 17,
          imageSize: Size(17.w, 17.w)),
    );
  }
}

///-------------------------付款方式页面-----------------------////
///付款模态弹窗
class PaymentWayWidget extends StatefulWidget {
  bool isResidence;
  String payMoney;
  int areaId;
  int month;
  String title;
  int num;
  int serverId;
  String daikuan;
  int? dcode;
  String money;
  PaymentWayWidget({
    super.key,
    required this.isResidence,
    required this.payMoney,
    required this.areaId,
    required this.month,
    required this.title,
    required this.num,
    required this.serverId,
    required this.daikuan,
    required this.money,
    this.dcode,
  });
  @override
  State<PaymentWayWidget> createState() => _PaymentWayWidgetState();
}

class _PaymentWayWidgetState
    extends BaseState<PersonalPageModel, PaymentWayWidget> {
  bool isRemainingPay = true;
  bool isWeChatPay = false;
  bool isAlipayPay = false;
  String payWayStr = '余额支付';
  int payType = 4;
  @override
  Widget getContentChild(PersonalPageModel model) {
    // TODO: implement getContentChild
    return showDialogWidget(Container(
      height: 320.h,
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
                    PayWayWidget('images/balance_payment.png', '余额支付', true,
                        delText: '（可用:${widget.money}元）', () {
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
              )
            ],
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
                      '¥ ${widget.payMoney}',
                      style: TextStyle(
                          fontSize: 20.sp, color: MyColor.orangeColor),
                    )
                  ],
                ),
                ThemeTitleButton(
                    size: Size(120.w, 35.h),
                    backgroudColor: MyColor.themeColor,
                    title: '立即付款',
                    titleFont: 15,
                    titleColor: Colors.white,
                    onTap: () {
                      if (payType == 4) {
                        MessageToast.alert('确定使用余额支付么？', context, confirm: () {
                          if (widget.isResidence) {
                            print(
                                '住宅订单接口：${widget.isResidence}  url:${Url.baseUrl + Url.paymentResidence}\n type:$payType,buy_type:22,time:${widget.month},dcode:${widget.dcode},title:${widget.title},areaid:${widget.areaId},cityid:${widget.serverId},number:${widget.num}');
                            model.paymentResidence(
                                payType,
                                widget.daikuan,
                                widget.month,
                                widget.title,
                                widget.areaId,
                                widget.serverId,
                                widget.num,
                                dcode: widget.dcode, paySuccess: () {
                              MessageToast.alert('支付成功\n是否选择进入IP节点列表？', context,
                                  confirm: () {
                                Navigator.pop(context);
                                navigationPush(context, const ServerListPage());
                              }, callback: () {
                                Navigator.pop(context);
                              });
                            });
                          } else {
                            print(
                                '静态订单接口：${widget.isResidence}  url:${Url.baseUrl + Url.paymentStatic}\n type:$payType,buy_type:${widget.daikuan},time:${widget.month},dcode:${widget.dcode},title:${widget.title},areaid:${widget.areaId},cityid:${widget.serverId},number:${widget.num}');
                            model.paymentStatic(
                                payType,
                                widget.daikuan,
                                widget.month,
                                widget.title,
                                widget.areaId,
                                widget.serverId,
                                widget.num,
                                dcode: widget.dcode, paySuccess: () {
                              MessageToast.alert('支付成功\n是否选择进入IP节点列表？', context,
                                  confirm: () {
                                Navigator.pop(context);
                                navigationPush(context, const ServerListPage());
                              }, callback: () {
                                Navigator.pop(context);
                              });
                            });
                          }
                        }, callback: () {
                          Navigator.pop(context);
                        });
                      } else {
                        if (widget.isResidence) {
                          print(
                              '住宅订单接口：${widget.isResidence} url:${Url.baseUrl + Url.paymentResidence}\n type:$payType,buy_type:${widget.daikuan},time:${widget.month},dcode:${widget.dcode},title:${widget.title},areaid:${widget.areaId},cityid:${widget.serverId},number:${widget.num}');
                          model.paymentResidence(
                              payType,
                              widget.daikuan,
                              widget.month,
                              widget.title,
                              widget.areaId,
                              widget.serverId,
                              widget.num,
                              dcode: widget.dcode, wechatPaySuccess: () {
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
                                                        '支付成功------$payRes'),

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
                        } else {
                          print(
                              '静态接口：${widget.isResidence}  url:${Url.baseUrl + Url.paymentStatic}\n type:$payType,buy_type:${widget.daikuan},time:${widget.month},dcode:${widget.dcode},title:${widget.title},areaid:${widget.areaId},cityid:${widget.serverId},number:${widget.num}');
                          model.paymentStatic(
                              payType,
                              widget.daikuan,
                              widget.month,
                              widget.title,
                              widget.areaId,
                              widget.serverId,
                              widget.num,
                              dcode: widget.dcode, wechatPaySuccess: () {
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
                                                        '支付成功------$payRes'),

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
                      }
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  @override
  // TODO: implement viewModel
  PersonalPageModel get viewModel => PersonalPageModel();
}

class PayWayWidget extends StatelessWidget {
  final String imageName;
  final String title;
  final bool isDel; //是否显示可用余额
  final String? delText;
  final VoidCallback onTap;
  final bool isSelect;
  const PayWayWidget(
      this.imageName, this.title, this.isDel, this.onTap, this.isSelect,
      {super.key, this.delText});

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
                Text(
                  delText!,
                  style: MyTextStyle.text15grayStyle,
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

///苹果端内购
class BuyEngine {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  void initializeInAppPurchase(Function paySuccess) {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) =>
          _listenToPurchaseUpdated(purchaseDetailsList, paySuccess),
      onDone: () => _subscription?.cancel(),
      onError: (error) => () {
        print("购买失败: $error");
      },
    );
  }

  ///监听购买事件
  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList, Function paySuccess) {
    for (PurchaseDetails purchase in purchaseDetailsList) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        // String? receiptData = purchase.verificationData.serverVerificationData;
        // String? originalTransactionId;
        print("购买成功，交易ID: ${purchase.purchaseID}");
        print('购买成功2，------¥${purchase.productID}');
        print('购买成功3，------¥${purchase.transactionDate}');
        print('购买成功3，------¥${purchase.verificationData}');
        print('购买成功3，------¥${purchase.pendingCompletePurchase}');
        paySuccess({
          'transaction_id': purchase.purchaseID,
          'product_id': purchase.productID,
          'transaction_date': purchase.transactionDate,
          'verification_data': purchase.verificationData.serverVerificationData,
          'pending_complete_purchase': purchase.pendingCompletePurchase
        });
        _subscription?.cancel();
      } else if (purchase.status == PurchaseStatus.error) {
        MessageToast.toast('购买失败');
        print("购买失败: ${purchase.error}");
      } else if (purchase.status == PurchaseStatus.canceled) {
        MessageToast.toast('取消购买');
        _subscription?.cancel();
        print("取消购买}");
      }
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  ///查询商品详情
  Future<void> queryProducts(
      List<String> productIds, Function paySuccess) async {
    final response =
        await _inAppPurchase.queryProductDetails(productIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      print("未找到商品: ${response.notFoundIDs}");
      _subscription?.cancel();
      return;
    }
    // 处理查询到的商品
    print("查询到的商品: ${response}");
    buyProduct(productIds[0], paySuccess);
  }

  ///根据商品信息发起购买请求
  Future<void> buyProduct(String productId, Function paySuccess) async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      print("无法连接到商店");
      _subscription?.cancel();
      return;
    }
    final response = await _inAppPurchase.queryProductDetails({productId});
    if (response.productDetails.isNotEmpty) {
      final product = response.productDetails.first;
      await _inAppPurchase.buyConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );
      print("查询到的商品: ${response}");
      print('11111--------$product');
      initializeInAppPurchase(paySuccess);
    } else {
      print("未找到商品: $productId");
      _subscription?.cancel();
    }
  }
}
