import 'package:agent_app_vpn/data/coupon_list_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

CouponListBeanEntity $CouponListBeanEntityFromJson(Map<String, dynamic> json) {
  final CouponListBeanEntity couponListBeanEntity = CouponListBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    couponListBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    couponListBeanEntity.info = info;
  }
  final CouponListBeanData? data =
      jsonConvert.convert<CouponListBeanData>(json['data']);
  if (data != null) {
    couponListBeanEntity.data = data;
  }
  return couponListBeanEntity;
}

Map<String, dynamic> $CouponListBeanEntityToJson(CouponListBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension CouponListBeanEntityExtension on CouponListBeanEntity {
  CouponListBeanEntity copyWith({
    int? code,
    String? info,
    CouponListBeanData? data,
  }) {
    return CouponListBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

CouponListBeanData $CouponListBeanDataFromJson(Map<String, dynamic> json) {
  final CouponListBeanData couponListBeanData = CouponListBeanData();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    couponListBeanData.total = total;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    couponListBeanData.perPage = perPage;
  }
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    couponListBeanData.currentPage = currentPage;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    couponListBeanData.lastPage = lastPage;
  }
  final List<CouponListBeanDataData>? data = (json['data'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<CouponListBeanDataData>(e)
          as CouponListBeanDataData)
      .toList();
  if (data != null) {
    couponListBeanData.data = data;
  }
  return couponListBeanData;
}

Map<String, dynamic> $CouponListBeanDataToJson(CouponListBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['per_page'] = entity.perPage;
  data['current_page'] = entity.currentPage;
  data['last_page'] = entity.lastPage;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension CouponListBeanDataExtension on CouponListBeanData {
  CouponListBeanData copyWith({
    int? total,
    int? perPage,
    int? currentPage,
    int? lastPage,
    List<CouponListBeanDataData>? data,
  }) {
    return CouponListBeanData()
      ..total = total ?? this.total
      ..perPage = perPage ?? this.perPage
      ..currentPage = currentPage ?? this.currentPage
      ..lastPage = lastPage ?? this.lastPage
      ..data = data ?? this.data;
  }
}

CouponListBeanDataData $CouponListBeanDataDataFromJson(
    Map<String, dynamic> json) {
  final CouponListBeanDataData couponListBeanDataData =
      CouponListBeanDataData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    couponListBeanDataData.id = id;
  }
  final int? memid = jsonConvert.convert<int>(json['memid']);
  if (memid != null) {
    couponListBeanDataData.memid = memid;
  }
  final int? dcid = jsonConvert.convert<int>(json['dcid']);
  if (dcid != null) {
    couponListBeanDataData.dcid = dcid;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    couponListBeanDataData.title = title;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    couponListBeanDataData.status = status;
  }
  final String? timeStart = jsonConvert.convert<String>(json['time_start']);
  if (timeStart != null) {
    couponListBeanDataData.timeStart = timeStart;
  }
  final String? timeEnd = jsonConvert.convert<String>(json['time_end']);
  if (timeEnd != null) {
    couponListBeanDataData.timeEnd = timeEnd;
  }
  final String? useMinPrice =
      jsonConvert.convert<String>(json['use_min_price']);
  if (useMinPrice != null) {
    couponListBeanDataData.useMinPrice = useMinPrice;
  }
  final String? useMaxPrice =
      jsonConvert.convert<String>(json['use_max_price']);
  if (useMaxPrice != null) {
    couponListBeanDataData.useMaxPrice = useMaxPrice;
  }
  final String? createAt = jsonConvert.convert<String>(json['create_at']);
  if (createAt != null) {
    couponListBeanDataData.createAt = createAt;
  }
  final dynamic mealId = json['meal_id'];
  if (mealId != null) {
    couponListBeanDataData.mealId = mealId;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    couponListBeanDataData.price = price;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    couponListBeanDataData.type = type;
  }
  final dynamic useLog = json['use_log'];
  if (useLog != null) {
    couponListBeanDataData.useLog = useLog;
  }
  final int? typeUse = jsonConvert.convert<int>(json['type_use']);
  if (typeUse != null) {
    couponListBeanDataData.typeUse = typeUse;
  }
  return couponListBeanDataData;
}

Map<String, dynamic> $CouponListBeanDataDataToJson(
    CouponListBeanDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['memid'] = entity.memid;
  data['dcid'] = entity.dcid;
  data['title'] = entity.title;
  data['status'] = entity.status;
  data['time_start'] = entity.timeStart;
  data['time_end'] = entity.timeEnd;
  data['use_min_price'] = entity.useMinPrice;
  data['use_max_price'] = entity.useMaxPrice;
  data['create_at'] = entity.createAt;
  data['meal_id'] = entity.mealId;
  data['price'] = entity.price;
  data['type'] = entity.type;
  data['use_log'] = entity.useLog;
  data['type_use'] = entity.typeUse;
  return data;
}

extension CouponListBeanDataDataExtension on CouponListBeanDataData {
  CouponListBeanDataData copyWith({
    int? id,
    int? memid,
    int? dcid,
    String? title,
    int? status,
    String? timeStart,
    String? timeEnd,
    String? useMinPrice,
    String? useMaxPrice,
    String? createAt,
    dynamic mealId,
    String? price,
    int? type,
    dynamic useLog,
    int? typeUse,
  }) {
    return CouponListBeanDataData()
      ..id = id ?? this.id
      ..memid = memid ?? this.memid
      ..dcid = dcid ?? this.dcid
      ..title = title ?? this.title
      ..status = status ?? this.status
      ..timeStart = timeStart ?? this.timeStart
      ..timeEnd = timeEnd ?? this.timeEnd
      ..useMinPrice = useMinPrice ?? this.useMinPrice
      ..useMaxPrice = useMaxPrice ?? this.useMaxPrice
      ..createAt = createAt ?? this.createAt
      ..mealId = mealId ?? this.mealId
      ..price = price ?? this.price
      ..type = type ?? this.type
      ..useLog = useLog ?? this.useLog
      ..typeUse = typeUse ?? this.typeUse;
  }
}
