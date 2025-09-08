import 'package:agent_app_vpn/data/order_member_list_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

OrderMemberListBeanEntity $OrderMemberListBeanEntityFromJson(
    Map<String, dynamic> json) {
  final OrderMemberListBeanEntity orderMemberListBeanEntity =
      OrderMemberListBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    orderMemberListBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    orderMemberListBeanEntity.info = info;
  }
  final OrderMemberListBeanData? data =
      jsonConvert.convert<OrderMemberListBeanData>(json['data']);
  if (data != null) {
    orderMemberListBeanEntity.data = data;
  }
  return orderMemberListBeanEntity;
}

Map<String, dynamic> $OrderMemberListBeanEntityToJson(
    OrderMemberListBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension OrderMemberListBeanEntityExtension on OrderMemberListBeanEntity {
  OrderMemberListBeanEntity copyWith({
    int? code,
    String? info,
    OrderMemberListBeanData? data,
  }) {
    return OrderMemberListBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

OrderMemberListBeanData $OrderMemberListBeanDataFromJson(
    Map<String, dynamic> json) {
  final OrderMemberListBeanData orderMemberListBeanData =
      OrderMemberListBeanData();
  final OrderMemberListBeanDataList? list =
      jsonConvert.convert<OrderMemberListBeanDataList>(json['list']);
  if (list != null) {
    orderMemberListBeanData.list = list;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    orderMemberListBeanData.price = price;
  }
  return orderMemberListBeanData;
}

Map<String, dynamic> $OrderMemberListBeanDataToJson(
    OrderMemberListBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list.toJson();
  data['price'] = entity.price;
  return data;
}

extension OrderMemberListBeanDataExtension on OrderMemberListBeanData {
  OrderMemberListBeanData copyWith({
    OrderMemberListBeanDataList? list,
    int? price,
  }) {
    return OrderMemberListBeanData()
      ..list = list ?? this.list
      ..price = price ?? this.price;
  }
}

OrderMemberListBeanDataList $OrderMemberListBeanDataListFromJson(
    Map<String, dynamic> json) {
  final OrderMemberListBeanDataList orderMemberListBeanDataList =
      OrderMemberListBeanDataList();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    orderMemberListBeanDataList.total = total;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    orderMemberListBeanDataList.perPage = perPage;
  }
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    orderMemberListBeanDataList.currentPage = currentPage;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    orderMemberListBeanDataList.lastPage = lastPage;
  }
  final List<OrderMemberListBeanDataListData>? data =
      (json['data'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<OrderMemberListBeanDataListData>(e)
              as OrderMemberListBeanDataListData)
          .toList();
  if (data != null) {
    orderMemberListBeanDataList.data = data;
  }
  return orderMemberListBeanDataList;
}

Map<String, dynamic> $OrderMemberListBeanDataListToJson(
    OrderMemberListBeanDataList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['per_page'] = entity.perPage;
  data['current_page'] = entity.currentPage;
  data['last_page'] = entity.lastPage;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension OrderMemberListBeanDataListExtension on OrderMemberListBeanDataList {
  OrderMemberListBeanDataList copyWith({
    int? total,
    int? perPage,
    int? currentPage,
    int? lastPage,
    List<OrderMemberListBeanDataListData>? data,
  }) {
    return OrderMemberListBeanDataList()
      ..total = total ?? this.total
      ..perPage = perPage ?? this.perPage
      ..currentPage = currentPage ?? this.currentPage
      ..lastPage = lastPage ?? this.lastPage
      ..data = data ?? this.data;
  }
}

OrderMemberListBeanDataListData $OrderMemberListBeanDataListDataFromJson(
    Map<String, dynamic> json) {
  final OrderMemberListBeanDataListData orderMemberListBeanDataListData =
      OrderMemberListBeanDataListData();
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    orderMemberListBeanDataListData.price = price;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    orderMemberListBeanDataListData.type = type;
  }
  final String? createAt = jsonConvert.convert<String>(json['create_at']);
  if (createAt != null) {
    orderMemberListBeanDataListData.createAt = createAt;
  }
  return orderMemberListBeanDataListData;
}

Map<String, dynamic> $OrderMemberListBeanDataListDataToJson(
    OrderMemberListBeanDataListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['price'] = entity.price;
  data['type'] = entity.type;
  data['create_at'] = entity.createAt;
  return data;
}

extension OrderMemberListBeanDataListDataExtension
    on OrderMemberListBeanDataListData {
  OrderMemberListBeanDataListData copyWith({
    String? price,
    int? type,
    String? createAt,
  }) {
    return OrderMemberListBeanDataListData()
      ..price = price ?? this.price
      ..type = type ?? this.type
      ..createAt = createAt ?? this.createAt;
  }
}
