import 'package:agent_app_vpn/data/usable_coupon_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

UsableCouponBeanEntity $UsableCouponBeanEntityFromJson(
    Map<String, dynamic> json) {
  final UsableCouponBeanEntity usableCouponBeanEntity =
      UsableCouponBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    usableCouponBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    usableCouponBeanEntity.info = info;
  }
  final UsableCouponBeanData? data =
      jsonConvert.convert<UsableCouponBeanData>(json['data']);
  if (data != null) {
    usableCouponBeanEntity.data = data;
  }
  return usableCouponBeanEntity;
}

Map<String, dynamic> $UsableCouponBeanEntityToJson(
    UsableCouponBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension UsableCouponBeanEntityExtension on UsableCouponBeanEntity {
  UsableCouponBeanEntity copyWith({
    int? code,
    String? info,
    UsableCouponBeanData? data,
  }) {
    return UsableCouponBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

UsableCouponBeanData $UsableCouponBeanDataFromJson(Map<String, dynamic> json) {
  final UsableCouponBeanData usableCouponBeanData = UsableCouponBeanData();
  final List<UsableCouponBeanDataYouhuiquan>? youhuiquan =
      (json['youhuiquan'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<UsableCouponBeanDataYouhuiquan>(e)
              as UsableCouponBeanDataYouhuiquan)
          .toList();
  if (youhuiquan != null) {
    usableCouponBeanData.youhuiquan = youhuiquan;
  }
  return usableCouponBeanData;
}

Map<String, dynamic> $UsableCouponBeanDataToJson(UsableCouponBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['youhuiquan'] = entity.youhuiquan.map((v) => v.toJson()).toList();
  return data;
}

extension UsableCouponBeanDataExtension on UsableCouponBeanData {
  UsableCouponBeanData copyWith({
    List<UsableCouponBeanDataYouhuiquan>? youhuiquan,
  }) {
    return UsableCouponBeanData()..youhuiquan = youhuiquan ?? this.youhuiquan;
  }
}

UsableCouponBeanDataYouhuiquan $UsableCouponBeanDataYouhuiquanFromJson(
    Map<String, dynamic> json) {
  final UsableCouponBeanDataYouhuiquan usableCouponBeanDataYouhuiquan =
      UsableCouponBeanDataYouhuiquan();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    usableCouponBeanDataYouhuiquan.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    usableCouponBeanDataYouhuiquan.title = title;
  }
  final String? useMinPrice =
      jsonConvert.convert<String>(json['use_min_price']);
  if (useMinPrice != null) {
    usableCouponBeanDataYouhuiquan.useMinPrice = useMinPrice;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    usableCouponBeanDataYouhuiquan.price = price;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    usableCouponBeanDataYouhuiquan.type = type;
  }
  final String? timeEnd = jsonConvert.convert<String>(json['time_end']);
  if (timeEnd != null) {
    usableCouponBeanDataYouhuiquan.timeEnd = timeEnd;
  }
  return usableCouponBeanDataYouhuiquan;
}

Map<String, dynamic> $UsableCouponBeanDataYouhuiquanToJson(
    UsableCouponBeanDataYouhuiquan entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['use_min_price'] = entity.useMinPrice;
  data['price'] = entity.price;
  data['type'] = entity.type;
  data['time_end'] = entity.timeEnd;
  return data;
}

extension UsableCouponBeanDataYouhuiquanExtension
    on UsableCouponBeanDataYouhuiquan {
  UsableCouponBeanDataYouhuiquan copyWith({
    int? id,
    String? title,
    String? useMinPrice,
    String? price,
    int? type,
    String? timeEnd,
  }) {
    return UsableCouponBeanDataYouhuiquan()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..useMinPrice = useMinPrice ?? this.useMinPrice
      ..price = price ?? this.price
      ..type = type ?? this.type
      ..timeEnd = timeEnd ?? this.timeEnd;
  }
}
