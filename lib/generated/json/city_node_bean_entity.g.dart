import 'package:agent_app_vpn/data/city_node_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

CityNodeBeanEntity $CityNodeBeanEntityFromJson(Map<String, dynamic> json) {
  final CityNodeBeanEntity cityNodeBeanEntity = CityNodeBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    cityNodeBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    cityNodeBeanEntity.info = info;
  }
  final List<CityNodeBeanData>? data = (json['data'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<CityNodeBeanData>(e) as CityNodeBeanData)
      .toList();
  if (data != null) {
    cityNodeBeanEntity.data = data;
  }
  return cityNodeBeanEntity;
}

Map<String, dynamic> $CityNodeBeanEntityToJson(CityNodeBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension CityNodeBeanEntityExtension on CityNodeBeanEntity {
  CityNodeBeanEntity copyWith({
    int? code,
    String? info,
    List<CityNodeBeanData>? data,
  }) {
    return CityNodeBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

CityNodeBeanData $CityNodeBeanDataFromJson(Map<String, dynamic> json) {
  final CityNodeBeanData cityNodeBeanData = CityNodeBeanData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    cityNodeBeanData.name = name;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    cityNodeBeanData.num = num;
  }
  final String? serverId = jsonConvert.convert<String>(json['server_id']);
  if (serverId != null) {
    cityNodeBeanData.serverId = serverId;
  }
  return cityNodeBeanData;
}

Map<String, dynamic> $CityNodeBeanDataToJson(CityNodeBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['num'] = entity.num;
  data['server_id'] = entity.serverId;
  return data;
}

extension CityNodeBeanDataExtension on CityNodeBeanData {
  CityNodeBeanData copyWith({
    String? name,
    int? num,
    String? serverId,
  }) {
    return CityNodeBeanData()
      ..name = name ?? this.name
      ..num = num ?? this.num
      ..serverId = serverId ?? this.serverId;
  }
}
