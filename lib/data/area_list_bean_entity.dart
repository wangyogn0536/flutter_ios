import 'dart:convert';

import 'package:agent_app_vpn/generated/json/area_list_bean_entity.g.dart';
import 'package:agent_app_vpn/generated/json/base/json_field.dart';

export 'package:agent_app_vpn/generated/json/area_list_bean_entity.g.dart';

@JsonSerializable()
class AreaListBeanEntity {
  late int code;
  late String info;
  late AreaListBeanData data;

  AreaListBeanEntity();

  factory AreaListBeanEntity.fromJson(Map<String, dynamic> json) =>
      $AreaListBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $AreaListBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AreaListBeanData {
  late List<AreaListBeanDataAreas> areas;
  late int ipcount;

  AreaListBeanData();

  factory AreaListBeanData.fromJson(Map<String, dynamic> json) =>
      $AreaListBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $AreaListBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AreaListBeanDataAreas {
  late String title;

  AreaListBeanDataAreas();

  factory AreaListBeanDataAreas.fromJson(Map<String, dynamic> json) =>
      $AreaListBeanDataAreasFromJson(json);

  Map<String, dynamic> toJson() => $AreaListBeanDataAreasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
