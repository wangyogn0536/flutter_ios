import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/vip_list_entity.g.dart';

@JsonSerializable()
class VIPRuleListData {
  late int code;
  late String info;
  late List<VIPRuleData> data;

  VIPRuleListData();

  factory VIPRuleListData.fromJson(Map<String, dynamic> json) =>
      $VIPRuleListDataFromJson(json);

  Map<String, dynamic> toJson() => $VIPRuleListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VIPRuleData {
  late String title;
  late String content;

  VIPRuleData();

  factory VIPRuleData.fromJson(Map<String, dynamic> json) =>
      $VIPRuleDataFromJson(json);

  Map<String, dynamic> toJson() => $VIPRuleDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VIPInfoData {
  late int code;
  late String info;
  late VIPInfoObjectData data;

  VIPInfoData();

  factory VIPInfoData.fromJson(Map<String, dynamic> json) =>
      $VIPInfoDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VIPInfoObjectData {
  late int point = 0; //当前积分
  late String balance = '0'; //用户余额
  late int youhuiquan = 0; //优惠券数量
  late int qiandao = 1; //2已签到 1去签到
  late int zhuce = 1; //2已领取 1去领取
  late int auth = 1; //个人 2已领取 1去领取 0去认证
  @JSONField(name: "auth_company")
  late int authcompany = 1; //企业 2已领取 1去领取 0去认证
  late int yaoqingnum = 0; //邀请人的数量 跳转邀请
  @JSONField(name: "product_bug")
  late int productbug; //通过建议的数量 跳转提交意见
  @JSONField(name: "tg_url")
  late String tgurl; //邀请链接
  VIPGradeinfoData gradeinfo = VIPGradeinfoData(); //等级信息
  VIPPointConfigData pointConfig = VIPPointConfigData(); //积分配置

  VIPInfoObjectData();

  factory VIPInfoObjectData.fromJson(Map<String, dynamic> json) =>
      $VIPInfoObjectDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VIPPointConfigData {
  late int zhuce = 0; //注册积分
  late int auth = 0; //个人认证积分
  @JSONField(name: "auth_company")
  late int authcompany = 0; //企业认证积分
  late int qiandao = 0; //签到积分
  late int yaoqing = 0; //邀请积分
  late int bug = 0; //bug/意见积分
  late String consume = '0'; //消费得积分

  VIPPointConfigData();

  factory VIPPointConfigData.fromJson(Map<String, dynamic> json) =>
      $VIPPointConfigDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VIPGradeinfoData {
  late int level = 0; //当前等级 0普通用户 1普通会员 2345
  late String price = '0'; //消费金额
  VIPLevelcurData levelcur = VIPLevelcurData(); //
  VIPLevelnextData levelnext = VIPLevelnextData(); //

  VIPGradeinfoData();

  factory VIPGradeinfoData.fromJson(Map<String, dynamic> json) =>
      $VIPGradeinfoDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VIPLevelcurData {
  late int min = 0; //消费金额开始
  late int max = 0; //消费金额结束
  late int discount = 0; //折扣%
  late String name = ''; //会员等级名称

  VIPLevelcurData();

  factory VIPLevelcurData.fromJson(Map<String, dynamic> json) =>
      $VIPLevelcurDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VIPLevelnextData {
  late int min = 0; //消费金额开始
  late int max = 0; //消费金额结束
  late int discount = 0; //折扣%
  late String name = ''; //会员等级名称

  VIPLevelnextData();

  factory VIPLevelnextData.fromJson(Map<String, dynamic> json) =>
      $VIPLevelnextDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PointInfoData {
  late int code;
  late String info;
  late PointInfoPageData data;

  PointInfoData();

  factory PointInfoData.fromJson(Map<String, dynamic> json) =>
      $PointInfoDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PointInfoPageData {
  late int total = 0;
  @JSONField(name: "per_page")
  late int perpage = 0;
  @JSONField(name: "current_page")
  late int currentpage = 0;
  @JSONField(name: "last_page")
  late int lastpage = 0;
  late List<PointInfoListData> data;

  PointInfoPageData();

  factory PointInfoPageData.fromJson(Map<String, dynamic> json) =>
      $PointInfoPageDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PointInfoListData {
  late String type = '';
  @JSONField(name: "create_at")
  late String createat = '';
  late String msg = '';
  late int price = 0; //

  PointInfoListData();

  factory PointInfoListData.fromJson(Map<String, dynamic> json) =>
      $PointInfoListDataFromJson(json);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
