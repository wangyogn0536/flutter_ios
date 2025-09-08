import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/usable_coupon_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/usable_coupon_bean_entity.g.dart';

@JsonSerializable()
class UsableCouponBeanEntity {
  late int code;
  late String info;
  late UsableCouponBeanData data;

  UsableCouponBeanEntity();

  factory UsableCouponBeanEntity.fromJson(Map<String, dynamic> json) =>
      $UsableCouponBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $UsableCouponBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UsableCouponBeanData {
  late List<UsableCouponBeanDataYouhuiquan> youhuiquan;

  UsableCouponBeanData();

  factory UsableCouponBeanData.fromJson(Map<String, dynamic> json) =>
      $UsableCouponBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $UsableCouponBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UsableCouponBeanDataYouhuiquan {
  late int id;
  late String title;
  @JSONField(name: "use_min_price")
  late String useMinPrice;
  late String price;
  late int type;
  @JSONField(name: "time_end")
  late String timeEnd;

  UsableCouponBeanDataYouhuiquan();

  factory UsableCouponBeanDataYouhuiquan.fromJson(Map<String, dynamic> json) =>
      $UsableCouponBeanDataYouhuiquanFromJson(json);

  Map<String, dynamic> toJson() => $UsableCouponBeanDataYouhuiquanToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
