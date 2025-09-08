import 'package:agent_app_vpn/page/main/personal/personal_page.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../../project_imports.dart';
import 'my_complaint_page_model.dart';

/// Created by 刘冰.
/// Date:2024/10/16
/// des:投诉页面
class MyComplaintPage extends StatefulWidget {
  const MyComplaintPage({super.key});

  @override
  State<MyComplaintPage> createState() => _MyComplaintPageState();
}

class _MyComplaintPageState extends BaseState<MyComplaintModel, MyComplaintPage>
    with SingleTickerProviderStateMixin {
  bool _isOneMHighlight = true;
  bool _isTwoMHighlight = false;
  bool _isThreeMHighlight = false;
  bool _isFourMHighlight = false;

  final _articleController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  late TabController controller;
  List tabs = ['投诉', '反馈'];
  int currentIndex = 0;

  ///选择的类型（投诉或者反馈）
  List<String> complaintList = ['产品不好用', '退不了款', '客服服务态度差', '其他'];
  List<String> feedbackList = [
    '注册',
    '登陆',
    '购买',
    '提取',
    '白名単',
    '扣费',
    '改进',
    '其他',
    'BUG',
    '建议'
  ];
  int selectCurrentIndex = 0;

  ///下方选择的类型
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
    if (CacheManager.getInstance()?.get('complaintPageIndex') != null) {
      currentIndex =
          CacheManager.getInstance()?.get('complaintPageIndex') as int;
      CacheManager.clearKey('complaintPageIndex');
    }
    controller.animateTo(currentIndex);
  }

  @override
  Widget getContentChild(MyComplaintModel model) {
    return Scaffold(
      appBar: const CustomAppBar('投诉与反馈', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: const BoxDecoration(color: MyColor.tvDDDColor),
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
                      setState(() {
                        currentIndex = value;
                        selectCurrentIndex = 0;
                      });
                    },
                    tabs: tabs.map((e) {
                      return Tab(
                        text: e,
                      );
                    }).toList())),
            Expanded(
              child: KeyboardAvoider(
                  autoScroll: true,
                  child: Container(
                    color: MyColor.tvDDDColor,
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight,
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AllContainerPage(
                          title: currentIndex == 0 ? '投诉类型' : '反馈类型',
                          columnWidgets: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < listInfo(currentIndex).length;
                                  i++)
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: PersonalSelectBandwidthBtn(
                                    title: currentIndex == 0
                                        ? complaintList[i]
                                        : feedbackList[i],
                                    value: i,
                                    isHighlight: selectCurrentIndex == i,
                                    onChanged: (value) {
                                      setState(() {
                                        selectCurrentIndex = value;
                                      });
                                    },
                                  ),
                                ),
                            ],
                          ),
                          rowWidgets: const Center(),
                        ),
                        // KeyboardAvoider(child: child),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: AllContainerPage(
                            title: currentIndex == 0 ? '投诉原因' : '反馈内容',
                            columnWidgets: Container(
                              height: 120.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: TextField(
                                controller: _articleController,
                                enableInteractiveSelection: false,
                                decoration: InputDecoration(
                                  hintText: currentIndex == 0
                                      ? '请描述你要投诉的原因'
                                      : '请描述你要反馈的内容',
                                  hintStyle: MyTextStyle.text15grayStyle,
                                  labelStyle: MyTextStyle.text15blackStyle,
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                keyboardType: TextInputType.text,
                                // textCapitalization: TextCapitalization.sentences,
                                maxLines: null, // 允许多行输入
                                expands: true,
                              ),
                            ),
                            rowWidgets: const Center(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, left: 10.w),
                          child: Text(
                            '为了更好解決您的问题，请认真填写联系信息',
                            style: MyTextStyle.text15gray888Style,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: AllContainerPage(
                            title: '联系人姓名',
                            columnWidgets: const Center(),
                            rowWidgets: Container(
                              margin: EdgeInsets.only(top: 1.h),
                              width: 120.w,
                              height: 30.h,
                              child: TextField(
                                controller: _nameController,
                                textAlign: TextAlign.right,
                                enableInteractiveSelection: false,
                                decoration: InputDecoration(
                                  hintText: '请填写您的姓名',
                                  hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: MyColor.tabTextColor),
                                  labelStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: MyColor.gray333Color),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        AllContainerPage(
                          title: '联系电话',
                          columnWidgets: const Center(),
                          rowWidgets: Center(
                            child: SizedBox(
                              width: 150.w,
                              height: 30.h,
                              child: TextField(
                                controller: _phoneController,
                                textAlign: TextAlign.right,
                                enableInteractiveSelection: false,
                                decoration: InputDecoration(
                                  hintText: '请填写您的联系电话',
                                  hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: MyColor.tabTextColor),
                                  labelStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: MyColor.gray333Color),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h, left: 20.w, right: 20.w),
                          child: ThemeTitleButton(
                              size: Size(double.infinity, 50.h),
                              backgroudColor: MyColor.themeColor,
                              title: currentIndex == 0 ? '提交投诉' : '提交反馈',
                              titleFont: 15,
                              titleColor: Colors.white,
                              onTap: () {
                                if (_articleController.text.isEmpty) {
                                  MessageToast.toast(currentIndex == 0
                                      ? '请描述投诉原因'
                                      : '请填写反馈的内容');
                                  return;
                                }
                                if (_nameController.text.isEmpty) {
                                  MessageToast.toast('请填写您的姓名');
                                  return;
                                }
                                if (_phoneController.text.isEmpty) {
                                  MessageToast.toast('请填写您的联系方式');
                                  return;
                                }
                                if (currentIndex == 0) {
                                  model.complaintEntranceAPI(
                                      '${selectCurrentIndex + 1}',
                                      _articleController.text,
                                      _nameController.text,
                                      _phoneController.text, () {
                                    MessageToast.noCancelAlert(
                                        '提示', '提交投诉成功', context, confirm: () {
                                      Navigator.of(context).pop();
                                    });
                                  });
                                } else {
                                  model.feedbackEntranceAPI(
                                      '${selectCurrentIndex + 1}',
                                      _articleController.text,
                                      _nameController.text,
                                      _phoneController.text, () {
                                    MessageToast.noCancelAlert(
                                        '提示', '提交反馈成功', context, confirm: () {
                                      Navigator.of(context).pop();
                                    });
                                  });
                                }
                              }),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  ///信息栏颜色选择
  List listInfo(int index) {
    List qqq;
    if (index == 0) {
      qqq = complaintList;
    } else {
      qqq = feedbackList;
    }
    return qqq;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _articleController.dispose();
  }

  @override
  // TODO: implement viewModel
  MyComplaintModel get viewModel => MyComplaintModel();
}

class AllContainerPage extends StatefulWidget {
  String title;
  Widget columnWidgets;
  Widget rowWidgets;
  AllContainerPage({
    super.key,
    required this.title,
    required this.columnWidgets,
    required this.rowWidgets,
  });

  @override
  State<AllContainerPage> createState() => _AllContainerPageState();
}

class _AllContainerPageState extends State<AllContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: myBoxDecoration(backColor: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '*',
                    style: TextStyle(fontSize: 15.sp, color: Colors.red),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      widget.title,
                      style: MyTextStyle.text15blackStyle,
                    ),
                  ),
                ],
              ),
              widget.rowWidgets,
            ],
          ),
          widget.columnWidgets
        ],
      ),
    );
  }
}
