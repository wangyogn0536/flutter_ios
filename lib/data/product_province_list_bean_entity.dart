import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/product_province_list_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/product_province_list_bean_entity.g.dart';

@JsonSerializable()
class ProductProvinceListBeanEntity {
  late int code;
  late String info;
  late ProductProvinceListBeanData data;

  ProductProvinceListBeanEntity();

  factory ProductProvinceListBeanEntity.fromJson(Map<String, dynamic> json) =>
      $ProductProvinceListBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductProvinceListBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductProvinceListBeanData {
  late List<ProductProvinceListBeanDataAreas> areas;

  ProductProvinceListBeanData();

  factory ProductProvinceListBeanData.fromJson(Map<String, dynamic> json) =>
      $ProductProvinceListBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $ProductProvinceListBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductProvinceListBeanDataAreas {
  late String name;
  late int id;

  ProductProvinceListBeanDataAreas();

  factory ProductProvinceListBeanDataAreas.fromJson(
          Map<String, dynamic> json) =>
      $ProductProvinceListBeanDataAreasFromJson(json);

  Map<String, dynamic> toJson() =>
      $ProductProvinceListBeanDataAreasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
