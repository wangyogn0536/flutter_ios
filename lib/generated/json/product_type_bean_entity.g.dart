import 'package:agent_app_vpn/data/product_type_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

ProductTypeBeanEntity $ProductTypeBeanEntityFromJson(
    Map<String, dynamic> json) {
  final ProductTypeBeanEntity productTypeBeanEntity = ProductTypeBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    productTypeBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    productTypeBeanEntity.info = info;
  }
  final ProductTypeBeanData? data =
      jsonConvert.convert<ProductTypeBeanData>(json['data']);
  if (data != null) {
    productTypeBeanEntity.data = data;
  }
  return productTypeBeanEntity;
}

Map<String, dynamic> $ProductTypeBeanEntityToJson(
    ProductTypeBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension ProductTypeBeanEntityExtension on ProductTypeBeanEntity {
  ProductTypeBeanEntity copyWith({
    int? code,
    String? info,
    ProductTypeBeanData? data,
  }) {
    return ProductTypeBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

ProductTypeBeanData $ProductTypeBeanDataFromJson(Map<String, dynamic> json) {
  final ProductTypeBeanData productTypeBeanData = ProductTypeBeanData();
  final List<ProductTypeBeanDataTypes>? types =
      (json['types'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<ProductTypeBeanDataTypes>(e)
              as ProductTypeBeanDataTypes)
          .toList();
  if (types != null) {
    productTypeBeanData.types = types;
  }
  return productTypeBeanData;
}

Map<String, dynamic> $ProductTypeBeanDataToJson(ProductTypeBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['types'] = entity.types.map((v) => v.toJson()).toList();
  return data;
}

extension ProductTypeBeanDataExtension on ProductTypeBeanData {
  ProductTypeBeanData copyWith({
    List<ProductTypeBeanDataTypes>? types,
  }) {
    return ProductTypeBeanData()..types = types ?? this.types;
  }
}

ProductTypeBeanDataTypes $ProductTypeBeanDataTypesFromJson(
    Map<String, dynamic> json) {
  final ProductTypeBeanDataTypes productTypeBeanDataTypes =
      ProductTypeBeanDataTypes();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    productTypeBeanDataTypes.title = title;
  }
  final String? typeId = jsonConvert.convert<String>(json['type_id']);
  if (typeId != null) {
    productTypeBeanDataTypes.typeId = typeId;
  }
  final int? daikuan = jsonConvert.convert<int>(json['daikuan']);
  if (daikuan != null) {
    productTypeBeanDataTypes.daikuan = daikuan;
  }
  final ProductTypeBeanDataTypesUrl? url =
      jsonConvert.convert<ProductTypeBeanDataTypesUrl>(json['url']);
  if (url != null) {
    productTypeBeanDataTypes.url = url;
  }
  return productTypeBeanDataTypes;
}

Map<String, dynamic> $ProductTypeBeanDataTypesToJson(
    ProductTypeBeanDataTypes entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['type_id'] = entity.typeId;
  data['daikuan'] = entity.daikuan;
  data['url'] = entity.url.toJson();
  return data;
}

extension ProductTypeBeanDataTypesExtension on ProductTypeBeanDataTypes {
  ProductTypeBeanDataTypes copyWith({
    String? title,
    String? typeId,
    int? daikuan,
    ProductTypeBeanDataTypesUrl? url,
  }) {
    return ProductTypeBeanDataTypes()
      ..title = title ?? this.title
      ..typeId = typeId ?? this.typeId
      ..daikuan = daikuan ?? this.daikuan
      ..url = url ?? this.url;
  }
}

ProductTypeBeanDataTypesUrl $ProductTypeBeanDataTypesUrlFromJson(
    Map<String, dynamic> json) {
  final ProductTypeBeanDataTypesUrl productTypeBeanDataTypesUrl =
      ProductTypeBeanDataTypesUrl();
  final String? pay = jsonConvert.convert<String>(json['pay']);
  if (pay != null) {
    productTypeBeanDataTypesUrl.pay = pay;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    productTypeBeanDataTypesUrl.price = price;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    productTypeBeanDataTypesUrl.city = city;
  }
  final String? renewPrice = jsonConvert.convert<String>(json['renew_price']);
  if (renewPrice != null) {
    productTypeBeanDataTypesUrl.renewPrice = renewPrice;
  }
  return productTypeBeanDataTypesUrl;
}

Map<String, dynamic> $ProductTypeBeanDataTypesUrlToJson(
    ProductTypeBeanDataTypesUrl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pay'] = entity.pay;
  data['price'] = entity.price;
  data['city'] = entity.city;
  data['renew_price'] = entity.renewPrice;
  return data;
}

extension ProductTypeBeanDataTypesUrlExtension on ProductTypeBeanDataTypesUrl {
  ProductTypeBeanDataTypesUrl copyWith({
    String? pay,
    String? price,
    String? city,
    String? renewPrice,
  }) {
    return ProductTypeBeanDataTypesUrl()
      ..pay = pay ?? this.pay
      ..price = price ?? this.price
      ..city = city ?? this.city
      ..renewPrice = renewPrice ?? this.renewPrice;
  }
}
