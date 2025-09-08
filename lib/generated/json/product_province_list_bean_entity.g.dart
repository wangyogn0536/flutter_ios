import 'package:agent_app_vpn/data/product_province_list_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

ProductProvinceListBeanEntity $ProductProvinceListBeanEntityFromJson(
    Map<String, dynamic> json) {
  final ProductProvinceListBeanEntity productProvinceListBeanEntity =
      ProductProvinceListBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    productProvinceListBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    productProvinceListBeanEntity.info = info;
  }
  final ProductProvinceListBeanData? data =
      jsonConvert.convert<ProductProvinceListBeanData>(json['data']);
  if (data != null) {
    productProvinceListBeanEntity.data = data;
  }
  return productProvinceListBeanEntity;
}

Map<String, dynamic> $ProductProvinceListBeanEntityToJson(
    ProductProvinceListBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension ProductProvinceListBeanEntityExtension
    on ProductProvinceListBeanEntity {
  ProductProvinceListBeanEntity copyWith({
    int? code,
    String? info,
    ProductProvinceListBeanData? data,
  }) {
    return ProductProvinceListBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

ProductProvinceListBeanData $ProductProvinceListBeanDataFromJson(
    Map<String, dynamic> json) {
  final ProductProvinceListBeanData productProvinceListBeanData =
      ProductProvinceListBeanData();
  final List<ProductProvinceListBeanDataAreas>? areas =
      (json['areas'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<ProductProvinceListBeanDataAreas>(e)
              as ProductProvinceListBeanDataAreas)
          .toList();
  if (areas != null) {
    productProvinceListBeanData.areas = areas;
  }
  return productProvinceListBeanData;
}

Map<String, dynamic> $ProductProvinceListBeanDataToJson(
    ProductProvinceListBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['areas'] = entity.areas.map((v) => v.toJson()).toList();
  return data;
}

extension ProductProvinceListBeanDataExtension on ProductProvinceListBeanData {
  ProductProvinceListBeanData copyWith({
    List<ProductProvinceListBeanDataAreas>? areas,
  }) {
    return ProductProvinceListBeanData()..areas = areas ?? this.areas;
  }
}

ProductProvinceListBeanDataAreas $ProductProvinceListBeanDataAreasFromJson(
    Map<String, dynamic> json) {
  final ProductProvinceListBeanDataAreas productProvinceListBeanDataAreas =
      ProductProvinceListBeanDataAreas();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    productProvinceListBeanDataAreas.name = name;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productProvinceListBeanDataAreas.id = id;
  }
  return productProvinceListBeanDataAreas;
}

Map<String, dynamic> $ProductProvinceListBeanDataAreasToJson(
    ProductProvinceListBeanDataAreas entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['id'] = entity.id;
  return data;
}

extension ProductProvinceListBeanDataAreasExtension
    on ProductProvinceListBeanDataAreas {
  ProductProvinceListBeanDataAreas copyWith({
    String? name,
    int? id,
  }) {
    return ProductProvinceListBeanDataAreas()
      ..name = name ?? this.name
      ..id = id ?? this.id;
  }
}
