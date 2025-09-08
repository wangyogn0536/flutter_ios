import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/order_member_list_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/order_member_list_bean_entity.g.dart';

@JsonSerializable()
class OrderMemberListBeanEntity {
  late int code;
  late String info;
  late OrderMemberListBeanData data;

  OrderMemberListBeanEntity();

  factory OrderMemberListBeanEntity.fromJson(Map<String, dynamic> json) =>
      $OrderMemberListBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderMemberListBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderMemberListBeanData {
  late OrderMemberListBeanDataList list;
  late int price;

  OrderMemberListBeanData();

  factory OrderMemberListBeanData.fromJson(Map<String, dynamic> json) =>
      $OrderMemberListBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $OrderMemberListBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderMemberListBeanDataList {
  late int total;
  @JSONField(name: "per_page")
  late int perPage;
  @JSONField(name: "current_page")
  late int currentPage;
  @JSONField(name: "last_page")
  late int lastPage;
  late List<OrderMemberListBeanDataListData> data;

  OrderMemberListBeanDataList();

  factory OrderMemberListBeanDataList.fromJson(Map<String, dynamic> json) =>
      $OrderMemberListBeanDataListFromJson(json);

  Map<String, dynamic> toJson() => $OrderMemberListBeanDataListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderMemberListBeanDataListData {
  late String price;
  late int type;
  @JSONField(name: "create_at")
  late String createAt;

  OrderMemberListBeanDataListData();

  factory OrderMemberListBeanDataListData.fromJson(Map<String, dynamic> json) =>
      $OrderMemberListBeanDataListDataFromJson(json);

  Map<String, dynamic> toJson() => $OrderMemberListBeanDataListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
