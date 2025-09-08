import 'package:agent_app_vpn/page/main/purchase_center/vip/vip_rule_model.dart';
import 'package:agent_app_vpn/project_imports.dart';

class VIPRule extends StatefulWidget {
  const VIPRule({super.key});

  @override
  State<StatefulWidget> createState() => _VIPRuleState();
}

class _VIPRuleState extends BaseState<VIPRuleModel, VIPRule> {
  @override
  Widget getContentChild(VIPRuleModel model) {
    return Scaffold(
      appBar: const CustomAppBar('会员规则', [], isBack: true),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(17.w, 30.h, 17.w, 30.h),
        child: ListView.builder(
          itemCount: model.dataList.length,
          itemBuilder: (c, index) => Container(
            padding: EdgeInsets.only(bottom: 33.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      color: const Color(0xFFffffff),
                      child: Text(
                        model.dataList[index].title,
                        style: MyTextStyle.text17blackStyle,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 10.w,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xFF36AB9C).withAlpha(76),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 21.h),
                Text(
                  model.dataList[index].content,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  VIPRuleModel get viewModel => VIPRuleModel();
}
