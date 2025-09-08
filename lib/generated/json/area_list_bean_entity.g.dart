import 'package:agent_app_vpn/data/area_list_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

AreaListBeanEntity $AreaListBeanEntityFromJson(Map<String, dynamic> json) {
  final AreaListBeanEntity areaListBeanEntity = AreaListBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    areaListBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    areaListBeanEntity.info = info;
  }
  final AreaListBeanData? data =
      jsonConvert.convert<AreaListBeanData>(json['data']);
  if (data != null) {
    areaListBeanEntity.data = data;
  }
  return areaListBeanEntity;
}

Map<String, dynamic> $AreaListBeanEntityToJson(AreaListBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension AreaListBeanEntityExtension on AreaListBeanEntity {
  AreaListBeanEntity copyWith({
    int? code,
    String? info,
    AreaListBeanData? data,
  }) {
    return AreaListBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

AreaListBeanData $AreaListBeanDataFromJson(Map<String, dynamic> json) {
  final AreaListBeanData areaListBeanData = AreaListBeanData();
  final List<AreaListBeanDataAreas>? areas = (json['areas'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<AreaListBeanDataAreas>(e)
          as AreaListBeanDataAreas)
      .toList();
  if (areas != null) {
    areaListBeanData.areas = areas;
  }
  final int? ipcount = jsonConvert.convert<int>(json['ipcount']);
  if (ipcount != null) {
    areaListBeanData.ipcount = ipcount;
  }
  return areaListBeanData;
}

Map<String, dynamic> $AreaListBeanDataToJson(AreaListBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['areas'] = entity.areas.map((v) => v.toJson()).toList();
  data['ipcount'] = entity.ipcount;
  return data;
}

extension AreaListBeanDataExtension on AreaListBeanData {
  AreaListBeanData copyWith({
    List<AreaListBeanDataAreas>? areas,
    int? ipcount,
  }) {
    return AreaListBeanData()
      ..areas = areas ?? this.areas
      ..ipcount = ipcount ?? this.ipcount;
  }
}

AreaListBeanDataAreas $AreaListBeanDataAreasFromJson(
    Map<String, dynamic> json) {
  final AreaListBeanDataAreas areaListBeanDataAreas = AreaListBeanDataAreas();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    areaListBeanDataAreas.title = title;
  }
  return areaListBeanDataAreas;
}

Map<String, dynamic> $AreaListBeanDataAreasToJson(
    AreaListBeanDataAreas entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  return data;
}

extension AreaListBeanDataAreasExtension on AreaListBeanDataAreas {
  AreaListBeanDataAreas copyWith({
    String? title,
  }) {
    return AreaListBeanDataAreas()..title = title ?? this.title;
  }
}
