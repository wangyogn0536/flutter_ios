import 'package:agent_app_vpn/data/product_node_list_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

ProductNodeListEntity $ProductNodeListEntityFromJson(
    Map<String, dynamic> json) {
  final ProductNodeListEntity productNodeListEntity = ProductNodeListEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    productNodeListEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    productNodeListEntity.info = info;
  }
  final ProductNodeListData? data =
      jsonConvert.convert<ProductNodeListData>(json['data']);
  if (data != null) {
    productNodeListEntity.data = data;
  }
  return productNodeListEntity;
}

Map<String, dynamic> $ProductNodeListEntityToJson(
    ProductNodeListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension ProductNodeListEntityExtension on ProductNodeListEntity {
  ProductNodeListEntity copyWith({
    int? code,
    String? info,
    ProductNodeListData? data,
  }) {
    return ProductNodeListEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

ProductNodeListData $ProductNodeListDataFromJson(Map<String, dynamic> json) {
  final ProductNodeListData productNodeListData = ProductNodeListData();
  final List<ProductNodeListDataNode>? node = (json['node'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<ProductNodeListDataNode>(e)
          as ProductNodeListDataNode)
      .toList();
  if (node != null) {
    productNodeListData.node = node;
  }
  return productNodeListData;
}

Map<String, dynamic> $ProductNodeListDataToJson(ProductNodeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['node'] = entity.node.map((v) => v.toJson()).toList();
  return data;
}

extension ProductNodeListDataExtension on ProductNodeListData {
  ProductNodeListData copyWith({
    List<ProductNodeListDataNode>? node,
  }) {
    return ProductNodeListData()..node = node ?? this.node;
  }
}

ProductNodeListDataNode $ProductNodeListDataNodeFromJson(
    Map<String, dynamic> json) {
  final ProductNodeListDataNode productNodeListDataNode =
      ProductNodeListDataNode();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productNodeListDataNode.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    productNodeListDataNode.name = name;
  }
  final List<ProductNodeListDataNodeChilder>? childer =
      (json['childer'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<ProductNodeListDataNodeChilder>(e)
              as ProductNodeListDataNodeChilder)
          .toList();
  if (childer != null) {
    productNodeListDataNode.childer = childer;
  }
  final String? initial = jsonConvert.convert<String>(json['initial']);
  if (initial != null) {
    productNodeListDataNode.initial = initial;
  }
  return productNodeListDataNode;
}

Map<String, dynamic> $ProductNodeListDataNodeToJson(
    ProductNodeListDataNode entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['childer'] = entity.childer.map((v) => v.toJson()).toList();
  data['initial'] = entity.initial;
  return data;
}

extension ProductNodeListDataNodeExtension on ProductNodeListDataNode {
  ProductNodeListDataNode copyWith({
    int? id,
    String? name,
    List<ProductNodeListDataNodeChilder>? childer,
    String? initial,
  }) {
    return ProductNodeListDataNode()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..childer = childer ?? this.childer
      ..initial = initial ?? this.initial;
  }
}

ProductNodeListDataNodeChilder $ProductNodeListDataNodeChilderFromJson(
    Map<String, dynamic> json) {
  final ProductNodeListDataNodeChilder productNodeListDataNodeChilder =
      ProductNodeListDataNodeChilder();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productNodeListDataNodeChilder.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    productNodeListDataNodeChilder.name = name;
  }
  final int? dx = jsonConvert.convert<int>(json['dx']);
  if (dx != null) {
    productNodeListDataNodeChilder.dx = dx;
  }
  final int? lt = jsonConvert.convert<int>(json['lt']);
  if (lt != null) {
    productNodeListDataNodeChilder.lt = lt;
  }
  final int? yd = jsonConvert.convert<int>(json['yd']);
  if (yd != null) {
    productNodeListDataNodeChilder.yd = yd;
  }
  final int? use = jsonConvert.convert<int>(json['use']);
  if (use != null) {
    productNodeListDataNodeChilder.use = use;
  }
  return productNodeListDataNodeChilder;
}

Map<String, dynamic> $ProductNodeListDataNodeChilderToJson(
    ProductNodeListDataNodeChilder entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['dx'] = entity.dx;
  data['lt'] = entity.lt;
  data['yd'] = entity.yd;
  data['use'] = entity.use;
  return data;
}

extension ProductNodeListDataNodeChilderExtension
    on ProductNodeListDataNodeChilder {
  ProductNodeListDataNodeChilder copyWith({
    int? id,
    String? name,
    int? dx,
    int? lt,
    int? yd,
    int? use,
  }) {
    return ProductNodeListDataNodeChilder()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..dx = dx ?? this.dx
      ..lt = lt ?? this.lt
      ..yd = yd ?? this.yd
      ..use = use ?? this.use;
  }
}
