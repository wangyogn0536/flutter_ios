import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/product_type_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/product_type_bean_entity.g.dart';

@JsonSerializable()
class ProductTypeBeanEntity {
  late int code;
  late String info;
  late ProductTypeBeanData data;

  ProductTypeBeanEntity();

  factory ProductTypeBeanEntity.fromJson(Map<String, dynamic> json) =>
      $ProductTypeBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductTypeBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductTypeBeanData {
  late List<ProductTypeBeanDataTypes> types;

  ProductTypeBeanData();

  factory ProductTypeBeanData.fromJson(Map<String, dynamic> json) =>
      $ProductTypeBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $ProductTypeBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductTypeBeanDataTypes {
  late String title;
  @JSONField(name: "type_id")
  late String typeId;
  late int daikuan;
  late ProductTypeBeanDataTypesUrl url;

  ProductTypeBeanDataTypes();

  factory ProductTypeBeanDataTypes.fromJson(Map<String, dynamic> json) =>
      $ProductTypeBeanDataTypesFromJson(json);

  Map<String, dynamic> toJson() => $ProductTypeBeanDataTypesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductTypeBeanDataTypesUrl {
  late String pay;
  late String price;
  late String city;
  @JSONField(name: "renew_price")
  late String renewPrice;

  ProductTypeBeanDataTypesUrl();

  factory ProductTypeBeanDataTypesUrl.fromJson(Map<String, dynamic> json) =>
      $ProductTypeBeanDataTypesUrlFromJson(json);

  Map<String, dynamic> toJson() => $ProductTypeBeanDataTypesUrlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
