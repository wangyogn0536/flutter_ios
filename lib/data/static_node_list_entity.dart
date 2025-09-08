import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/static_node_list_entity.g.dart';

export 'package:agent_app_vpn/generated/json/static_node_list_entity.g.dart';

@JsonSerializable()
class StaticNodeListEntity {
  late int code;
  late String info;
  late StaticNodeListData data;

  StaticNodeListEntity();

  factory StaticNodeListEntity.fromJson(Map<String, dynamic> json) =>
      $StaticNodeListEntityFromJson(json);

  Map<String, dynamic> toJson() => $StaticNodeListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StaticNodeListData {
  late List<StaticNodeListDataNode> node;

  StaticNodeListData();

  factory StaticNodeListData.fromJson(Map<String, dynamic> json) =>
      $StaticNodeListDataFromJson(json);

  Map<String, dynamic> toJson() => $StaticNodeListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StaticNodeListDataNode {
  late String name;
  late String initial;
  late int id;
  late List<StaticNodeListDataNodeChilder> childer;

  StaticNodeListDataNode();

  factory StaticNodeListDataNode.fromJson(Map<String, dynamic> json) =>
      $StaticNodeListDataNodeFromJson(json);

  Map<String, dynamic> toJson() => $StaticNodeListDataNodeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StaticNodeListDataNodeChilder {
  late String name;
  late int id;
  late int num;
  late int use;

  StaticNodeListDataNodeChilder();

  factory StaticNodeListDataNodeChilder.fromJson(Map<String, dynamic> json) =>
      $StaticNodeListDataNodeChilderFromJson(json);

  Map<String, dynamic> toJson() => $StaticNodeListDataNodeChilderToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
