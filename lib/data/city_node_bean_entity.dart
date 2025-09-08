import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/city_node_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/city_node_bean_entity.g.dart';

@JsonSerializable()
class CityNodeBeanEntity {
  late int code;
  late String info;
  late List<CityNodeBeanData> data;

  CityNodeBeanEntity();

  factory CityNodeBeanEntity.fromJson(Map<String, dynamic> json) =>
      $CityNodeBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $CityNodeBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CityNodeBeanData {
  late String name;
  late int num;
  @JSONField(name: "server_id")
  late String serverId;

  CityNodeBeanData();

  factory CityNodeBeanData.fromJson(Map<String, dynamic> json) =>
      $CityNodeBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $CityNodeBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
