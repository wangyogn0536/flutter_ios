import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/product_node_list_entity.g.dart';

export 'package:agent_app_vpn/generated/json/product_node_list_entity.g.dart';

@JsonSerializable()
class ProductNodeListEntity {
  late int code;
  late String info;
  late ProductNodeListData data;

  ProductNodeListEntity();

  factory ProductNodeListEntity.fromJson(Map<String, dynamic> json) =>
      $ProductNodeListEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductNodeListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductNodeListData {
  late List<ProductNodeListDataNode> node;

  ProductNodeListData();

  factory ProductNodeListData.fromJson(Map<String, dynamic> json) =>
      $ProductNodeListDataFromJson(json);

  Map<String, dynamic> toJson() => $ProductNodeListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductNodeListDataNode {
  late int id;
  late String name;
  late List<ProductNodeListDataNodeChilder> childer;
  late String initial;

  ProductNodeListDataNode();

  factory ProductNodeListDataNode.fromJson(Map<String, dynamic> json) =>
      $ProductNodeListDataNodeFromJson(json);

  Map<String, dynamic> toJson() => $ProductNodeListDataNodeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductNodeListDataNodeChilder {
  late int id;
  late String name;
  late int dx;
  late int lt;
  late int yd;
  late int use;

  ProductNodeListDataNodeChilder();

  factory ProductNodeListDataNodeChilder.fromJson(Map<String, dynamic> json) =>
      $ProductNodeListDataNodeChilderFromJson(json);

  Map<String, dynamic> toJson() => $ProductNodeListDataNodeChilderToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
