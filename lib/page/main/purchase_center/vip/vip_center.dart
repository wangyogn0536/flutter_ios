import 'package:agent_app_vpn/page/login_register/register/real_name/one_real_name/one_real_name_page.dart';
import 'package:agent_app_vpn/page/main/purchase_center/my_complaint/my_complaint_page.dart';
import 'package:agent_app_vpn/page/main/purchase_center/vip/vip_center_model.dart';
import 'package:agent_app_vpn/page/main/purchase_center/vip/vip_rule.dart';
import 'package:agent_app_vpn/page/main/tab_bar_page.dart';
import 'package:agent_app_vpn/project_imports.dart';
import 'package:flutter/services.dart';

class VIPCenter extends StatefulWidget {
  const VIPCenter({super.key});

  @override
  State<StatefulWidget> createState() => _VIPCenterState();
}

class _VIPCenterState extends BaseState<VIPCenterModel, VIPCenter> {
  @override
  Widget getContentChild(VIPCenterModel model) {
    return Scaffold(
      appBar: CustomAppBar(
          '会员中心',
          [
            GestureDetector(
              onTap: () {
                navigationPush(context, const VIPRule());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Text('会员规则', style: MyTextStyle.text17whiteStyle),
              ),
            ),
          ],
          isBack: true),
      body: SingleChildScrollView(
        child: Container(
          color: MyColor.tvDDDColor,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    alignment: Alignment.topCenter,
                    height: 425.h,
                    child: Image.asset(
                      'images/vip_bg.png',
                      width: double.infinity,
                      height: 184.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    child: Column(
                      children: [
                        getVIPInfoWidget(model),
                        SizedBox(height: 20.h),
                        Text(
                          '我的特权',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: MyColor.desTextColor,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          width: ScreenUtil().screenWidth,
                          padding: EdgeInsets.only(left: 32.w, right: 32.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              getPrerogative(
                                '${model.objectData.gradeinfo.levelcur.discount}%抵扣券',
                                'images/vip_tq01.png',
                              ),
                              getPrerogative('积分抵现', 'images/vip_tq02.png'),
                              getPrerogative('客服优先', 'images/vip_tq03.png'),
                              getPrerogative('待解锁', 'images/vip_tq04.png'),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.h),
                          padding: EdgeInsets.fromLTRB(24.w, 7.w, 24.w, 7.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFFDB984A),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Text(
                            '敬请期待',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.fromLTRB(23.h, 17.w, 23.h, 17.w),
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      '玩赚积分',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: MyColor.desTextColor,
                      ),
                    ),
                    getBomWidget(
                      model,
                      'images/vip_points01.png',
                      '消费得积分',
                      model.objectData.pointConfig.consume,
                      '去消费',
                      false,
                      '01',
                    ),
                    getBomWidget(
                      model,
                      'images/vip_points02.png',
                      '完成注册',
                      '+${model.objectData.pointConfig.zhuce}积分',
                      model.objectData.zhuce == 1 ? '待领取' : '已领取',
                      model.objectData.zhuce == 2,
                      '02',
                    ),
                    getBomWidget(
                      model,
                      'images/vip_points03.png',
                      '完成个人认证',
                      '+${model.objectData.pointConfig.auth}积分',
                      model.objectData.auth == 1
                          ? '待领取'
                          : model.objectData.auth == 0
                              ? '去认证'
                              : '已领取',
                      model.objectData.auth == 2,
                      '03',
                    ),
                    Offstage(
                      offstage: model.objectData.authcompany == 0,
                      child: getBomWidget(
                        model,
                        'images/vip_points04.png',
                        '完成企业认证',
                        '+${model.objectData.pointConfig.authcompany}积分',
                        model.objectData.authcompany == 1
                            ? '待领取'
                            : model.objectData.authcompany == 0
                                ? '去认证'
                                : '已领取',
                        model.objectData.authcompany == 2,
                        '04',
                      ),
                    ),
                    // getBomWidget('images/vip_points05.png', '每月首次消费满100元',
                    //     '+100积分', '去消费', false, '05'),
                    getBomWidget(
                      model,
                      'images/vip_points06.png',
                      '每日签到',
                      '+${model.objectData.pointConfig.qiandao}积分',
                      model.objectData.qiandao == 1 ? '去签到' : '已完成',
                      model.objectData.qiandao == 2,
                      '05',
                    ),
                    getBomWidget(
                      model,
                      'images/vip_points07.png',
                      '邀请好友注册并认证',
                      '+${model.objectData.pointConfig.yaoqing}积分',
                      '去邀请',
                      false,
                      '06',
                    ),
                    getBomWidget(
                      model,
                      'images/vip_points08.png',
                      '提交高质量问题和产品建议',
                      '+${model.objectData.pointConfig.bug}积分',
                      '去提交',
                      false,
                      '07',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBomWidget(
    VIPCenterModel model,
    String imageName,
    String topString,
    String botString,
    String rightBtn,
    bool isDone,
    String type,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(imageName, width: 41.w, height: 41.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 11.w, right: 11.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.w),
                        Text(
                          topString,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF333333),
                          ),
                        ),
                        SizedBox(height: 3.w),
                        Text(
                          botString,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFDB984A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (type == '01') {
                CacheManager.getInstance()?.set('tabBarPageIndex', 1);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const TabBarPage()),
                  (route) => false,
                );
              } else if (type == '02') {
                model.getZhuce();
              } else if (type == '03') {
                // 个人 2已领取 1去领取 0去认证
                if (model.objectData.auth == 1) {
                  model.getAuth();
                } else if (model.objectData.auth == 0) {
                  navigationPush(context, const OneRealNamePage());
                }
              } else if (type == '04') {
                // 企业 2已领取 1去领取 0去认证
                if (model.objectData.authcompany == 1) {
                  model.getAuthCompany();
                }
              } else if (type == '05') {
                // 2已签到 1去签到
                if (model.objectData.qiandao == 1) {
                  model.centerQiandao();
                }
              } else if (type == '06') {
                await Clipboard.setData(
                  ClipboardData(text: model.objectData.tgurl),
                );
                MessageToast.toast('邀请链接已复制到粘贴板');
              } else if (type == '07') {
                CacheManager.getInstance()?.set('complaintPageIndex', 1);
                navigationPush(context, const MyComplaintPage());
              }
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(17.w, 6.w, 17.w, 6.w),
              decoration: BoxDecoration(
                color:
                    isDone ? const Color(0xFFEEEEEE) : const Color(0xFF36AB9C),
                borderRadius: const BorderRadius.all(Radius.circular(2)),
              ),
              child: Text(
                rightBtn,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDone ? const Color(0xFF666666) : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getPrerogative(String title, String imageName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imageName, width: 57.w, height: 57.w),
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Text(title, style: MyTextStyle.text15blackStyle),
        ),
      ],
    );
  }

  Widget getVIPInfoWidget(VIPCenterModel model) {
    double chaPrice = 0;
    double price = double.parse(model.objectData.gradeinfo.price);
    if (model.objectData.gradeinfo.levelcur.max > 0) {
      chaPrice = model.objectData.gradeinfo.levelcur.max - price;
    }
    return Container(
      width: ScreenUtil().screenWidth - 32.w,
      height: 180.h,
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 14.w),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage('images/vip_bg2.png'),
          fit: BoxFit.fill,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A100501), // 阴影颜色，这里使用了半透明的灰色
            offset: Offset(3, 3), // 阴影偏移量，水平向右3px，垂直向下3px
            blurRadius: 5.0, // 阴影的模糊半径
            spreadRadius: 1.0, //偏移量
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.1,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 90.w,
                      maxWidth: 80.w,
                      minHeight: 0,
                      minWidth: 0,
                    ),
                    child: Image.asset(
                      'images/vip_upgrade_2.png',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/vip_grade_${model.objectData.gradeinfo.level}.png',
                          width: 42.w,
                          height: 37.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: model.objectData.gradeinfo.level == 0
                                  ? 0
                                  : 12.w,
                              right: 12.w),
                          child: Text(
                            model.objectData.gradeinfo.levelcur.name,
                            style: MyTextStyle.text20blackStyle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.sp),
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(3.w, 2.w, 3.w, 2.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF9F6829),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Text(
                            '当前等级',
                            style:
                                TextStyle(fontSize: 9.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          // '已消费: 32131ffs112',
                          '已消费: ${model.objectData.gradeinfo.price}',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF976A32),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 18.w, right: 18.w),
                          child: Text(
                            '|',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xFF976A32),
                            ),
                          ),
                        ),
                        Text(
                          '可用积分: ${model.objectData.point}',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF976A32),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(height: 22.h),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 9.h,
                  inactiveTrackColor: const Color(0xFFFFF0D5),
                  activeTrackColor: const Color(0xFFCE8C4C),
                  thumbColor: Colors.white,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 3,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: SizedBox(
                  child: Slider(
                    min: 0,
                    max: model.objectData.gradeinfo.levelcur.max.toDouble() > 0
                        ? model.objectData.gradeinfo.levelcur.max.toDouble()
                        : 1,
                    value:
                        model.objectData.gradeinfo.levelcur.max.toDouble() > 0
                            ? price
                            : 1,
                    onChanged: (vale) {},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.w),
                child: Text(
                  model.objectData.gradeinfo.levelcur.max > 0
                      ? '${price.toStringAsFixed(2)}/${model.objectData.gradeinfo.levelcur.max}'
                      : '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF222222),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '已消费',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    TextSpan(
                      text: price.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFFF07829),
                      ),
                    ),
                    TextSpan(
                      text: '元',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: model.objectData.gradeinfo.levelcur.max <= 0,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '，还差',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF222222),
                        ),
                      ),
                      TextSpan(
                        text: chaPrice.toStringAsFixed(2),
                        // text: '123',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFFF07829),
                        ),
                      ),
                      TextSpan(
                        text: '元升级${model.objectData.gradeinfo.levelnext.name}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  VIPCenterModel get viewModel => VIPCenterModel();
}
