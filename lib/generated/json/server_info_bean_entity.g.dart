import 'package:agent_app_vpn/data/server_info_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

ServerInfoBeanEntity $ServerInfoBeanEntityFromJson(Map<String, dynamic> json) {
  final ServerInfoBeanEntity serverInfoBeanEntity = ServerInfoBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    serverInfoBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    serverInfoBeanEntity.info = info;
  }
  final ServerInfoBeanData? data =
      jsonConvert.convert<ServerInfoBeanData>(json['data']);
  if (data != null) {
    serverInfoBeanEntity.data = data;
  }
  return serverInfoBeanEntity;
}

Map<String, dynamic> $ServerInfoBeanEntityToJson(ServerInfoBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension ServerInfoBeanEntityExtension on ServerInfoBeanEntity {
  ServerInfoBeanEntity copyWith({
    int? code,
    String? info,
    ServerInfoBeanData? data,
  }) {
    return ServerInfoBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

ServerInfoBeanData $ServerInfoBeanDataFromJson(Map<String, dynamic> json) {
  final ServerInfoBeanData serverInfoBeanData = ServerInfoBeanData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    serverInfoBeanData.id = id;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    serverInfoBeanData.ip = ip;
  }
  final String? portHttp = jsonConvert.convert<String>(json['port_http']);
  if (portHttp != null) {
    serverInfoBeanData.portHttp = portHttp;
  }
  final String? portSs5 = jsonConvert.convert<String>(json['port_ss5']);
  if (portSs5 != null) {
    serverInfoBeanData.portSs5 = portSs5;
  }
  final String? area = jsonConvert.convert<String>(json['area']);
  if (area != null) {
    serverInfoBeanData.area = area;
  }
  final String? timeEnd = jsonConvert.convert<String>(json['time_end']);
  if (timeEnd != null) {
    serverInfoBeanData.timeEnd = timeEnd;
  }
  final int? diffday = jsonConvert.convert<int>(json['diffday']);
  if (diffday != null) {
    serverInfoBeanData.diffday = diffday;
  }
  final String? uname = jsonConvert.convert<String>(json['uname']);
  if (uname != null) {
    serverInfoBeanData.uname = uname;
  }
  final String? passwd = jsonConvert.convert<String>(json['passwd']);
  if (passwd != null) {
    serverInfoBeanData.passwd = passwd;
  }
  return serverInfoBeanData;
}

Map<String, dynamic> $ServerInfoBeanDataToJson(ServerInfoBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ip'] = entity.ip;
  data['port_http'] = entity.portHttp;
  data['port_ss5'] = entity.portSs5;
  data['area'] = entity.area;
  data['time_end'] = entity.timeEnd;
  data['diffday'] = entity.diffday;
  data['uname'] = entity.uname;
  data['passwd'] = entity.passwd;
  return data;
}

extension ServerInfoBeanDataExtension on ServerInfoBeanData {
  ServerInfoBeanData copyWith({
    int? id,
    String? ip,
    String? portHttp,
    String? portSs5,
    String? area,
    String? timeEnd,
    int? diffday,
    String? uname,
    String? passwd,
  }) {
    return ServerInfoBeanData()
      ..id = id ?? this.id
      ..ip = ip ?? this.ip
      ..portHttp = portHttp ?? this.portHttp
      ..portSs5 = portSs5 ?? this.portSs5
      ..area = area ?? this.area
      ..timeEnd = timeEnd ?? this.timeEnd
      ..diffday = diffday ?? this.diffday
      ..uname = uname ?? this.uname
      ..passwd = passwd ?? this.passwd;
  }
}
