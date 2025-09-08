import 'package:agent_app_vpn/data/static_node_list_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

StaticNodeListEntity $StaticNodeListEntityFromJson(Map<String, dynamic> json) {
  final StaticNodeListEntity staticNodeListEntity = StaticNodeListEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    staticNodeListEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    staticNodeListEntity.info = info;
  }
  final StaticNodeListData? data =
      jsonConvert.convert<StaticNodeListData>(json['data']);
  if (data != null) {
    staticNodeListEntity.data = data;
  }
  return staticNodeListEntity;
}

Map<String, dynamic> $StaticNodeListEntityToJson(StaticNodeListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension StaticNodeListEntityExtension on StaticNodeListEntity {
  StaticNodeListEntity copyWith({
    int? code,
    String? info,
    StaticNodeListData? data,
  }) {
    return StaticNodeListEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

StaticNodeListData $StaticNodeListDataFromJson(Map<String, dynamic> json) {
  final StaticNodeListData staticNodeListData = StaticNodeListData();
  final List<StaticNodeListDataNode>? node = (json['node'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<StaticNodeListDataNode>(e)
          as StaticNodeListDataNode)
      .toList();
  if (node != null) {
    staticNodeListData.node = node;
  }
  return staticNodeListData;
}

Map<String, dynamic> $StaticNodeListDataToJson(StaticNodeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['node'] = entity.node.map((v) => v.toJson()).toList();
  return data;
}

extension StaticNodeListDataExtension on StaticNodeListData {
  StaticNodeListData copyWith({
    List<StaticNodeListDataNode>? node,
  }) {
    return StaticNodeListData()..node = node ?? this.node;
  }
}

StaticNodeListDataNode $StaticNodeListDataNodeFromJson(
    Map<String, dynamic> json) {
  final StaticNodeListDataNode staticNodeListDataNode =
      StaticNodeListDataNode();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    staticNodeListDataNode.name = name;
  }
  final String? initial = jsonConvert.convert<String>(json['initial']);
  if (initial != null) {
    staticNodeListDataNode.initial = initial;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    staticNodeListDataNode.id = id;
  }
  final List<StaticNodeListDataNodeChilder>? childer =
      (json['childer'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<StaticNodeListDataNodeChilder>(e)
              as StaticNodeListDataNodeChilder)
          .toList();
  if (childer != null) {
    staticNodeListDataNode.childer = childer;
  }
  return staticNodeListDataNode;
}

Map<String, dynamic> $StaticNodeListDataNodeToJson(
    StaticNodeListDataNode entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['initial'] = entity.initial;
  data['id'] = entity.id;
  data['childer'] = entity.childer.map((v) => v.toJson()).toList();
  return data;
}

extension StaticNodeListDataNodeExtension on StaticNodeListDataNode {
  StaticNodeListDataNode copyWith({
    String? name,
    String? initial,
    int? id,
    List<StaticNodeListDataNodeChilder>? childer,
  }) {
    return StaticNodeListDataNode()
      ..name = name ?? this.name
      ..initial = initial ?? this.initial
      ..id = id ?? this.id
      ..childer = childer ?? this.childer;
  }
}

StaticNodeListDataNodeChilder $StaticNodeListDataNodeChilderFromJson(
    Map<String, dynamic> json) {
  final StaticNodeListDataNodeChilder staticNodeListDataNodeChilder =
      StaticNodeListDataNodeChilder();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    staticNodeListDataNodeChilder.name = name;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    staticNodeListDataNodeChilder.id = id;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    staticNodeListDataNodeChilder.num = num;
  }
  final int? use = jsonConvert.convert<int>(json['use']);
  if (use != null) {
    staticNodeListDataNodeChilder.use = use;
  }
  return staticNodeListDataNodeChilder;
}

Map<String, dynamic> $StaticNodeListDataNodeChilderToJson(
    StaticNodeListDataNodeChilder entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['id'] = entity.id;
  data['num'] = entity.num;
  data['use'] = entity.use;
  return data;
}

extension StaticNodeListDataNodeChilderExtension
    on StaticNodeListDataNodeChilder {
  StaticNodeListDataNodeChilder copyWith({
    String? name,
    int? id,
    int? num,
    int? use,
  }) {
    return StaticNodeListDataNodeChilder()
      ..name = name ?? this.name
      ..id = id ?? this.id
      ..num = num ?? this.num
      ..use = use ?? this.use;
  }
}
