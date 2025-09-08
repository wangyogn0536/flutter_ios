import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/coupon_list_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/coupon_list_bean_entity.g.dart';

@JsonSerializable()
class CouponListBeanEntity {
  late int code;
  late String info;
  late CouponListBeanData data;

  CouponListBeanEntity();

  factory CouponListBeanEntity.fromJson(Map<String, dynamic> json) =>
      $CouponListBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $CouponListBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CouponListBeanData {
  late int total;
  @JSONField(name: "per_page")
  late int perPage;
  @JSONField(name: "current_page")
  late int currentPage;
  @JSONField(name: "last_page")
  late int lastPage;
  late List<CouponListBeanDataData> data;

  CouponListBeanData();

  factory CouponListBeanData.fromJson(Map<String, dynamic> json) =>
      $CouponListBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $CouponListBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CouponListBeanDataData {
  late int id;
  late int memid;
  late int dcid;
  late String title;
  late int status;
  @JSONField(name: "time_start")
  late String timeStart;
  @JSONField(name: "time_end")
  late String timeEnd;
  @JSONField(name: "use_min_price")
  late String useMinPrice;
  @JSONField(name: "use_max_price")
  late String useMaxPrice;
  @JSONField(name: "create_at")
  late String createAt;
  @JSONField(name: "meal_id")
  dynamic mealId;
  late String price;
  late int type;
  @JSONField(name: "use_log")
  dynamic useLog;
  @JSONField(name: "type_use")
  late int typeUse;

  CouponListBeanDataData();

  factory CouponListBeanDataData.fromJson(Map<String, dynamic> json) =>
      $CouponListBeanDataDataFromJson(json);

  Map<String, dynamic> toJson() => $CouponListBeanDataDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
