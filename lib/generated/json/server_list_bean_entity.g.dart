import 'package:agent_app_vpn/data/server_list_bean_entity.dart';
import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';

ServerListBeanEntity $ServerListBeanEntityFromJson(Map<String, dynamic> json) {
  final ServerListBeanEntity serverListBeanEntity = ServerListBeanEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    serverListBeanEntity.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    serverListBeanEntity.info = info;
  }
  final ServerListBeanData? data =
      jsonConvert.convert<ServerListBeanData>(json['data']);
  if (data != null) {
    serverListBeanEntity.data = data;
  }
  return serverListBeanEntity;
}

Map<String, dynamic> $ServerListBeanEntityToJson(ServerListBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.toJson();
  return data;
}

extension ServerListBeanEntityExtension on ServerListBeanEntity {
  ServerListBeanEntity copyWith({
    int? code,
    String? info,
    ServerListBeanData? data,
  }) {
    return ServerListBeanEntity()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

ServerListBeanData $ServerListBeanDataFromJson(Map<String, dynamic> json) {
  final ServerListBeanData serverListBeanData = ServerListBeanData();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    serverListBeanData.total = total;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    serverListBeanData.perPage = perPage;
  }
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    serverListBeanData.currentPage = currentPage;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    serverListBeanData.lastPage = lastPage;
  }
  final List<ServerListBeanDataData>? data = (json['data'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<ServerListBeanDataData>(e)
          as ServerListBeanDataData)
      .toList();
  if (data != null) {
    serverListBeanData.data = data;
  }
  return serverListBeanData;
}

Map<String, dynamic> $ServerListBeanDataToJson(ServerListBeanData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['per_page'] = entity.perPage;
  data['current_page'] = entity.currentPage;
  data['last_page'] = entity.lastPage;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension ServerListBeanDataExtension on ServerListBeanData {
  ServerListBeanData copyWith({
    int? total,
    int? perPage,
    int? currentPage,
    int? lastPage,
    List<ServerListBeanDataData>? data,
  }) {
    return ServerListBeanData()
      ..total = total ?? this.total
      ..perPage = perPage ?? this.perPage
      ..currentPage = currentPage ?? this.currentPage
      ..lastPage = lastPage ?? this.lastPage
      ..data = data ?? this.data;
  }
}

ServerListBeanDataData $ServerListBeanDataDataFromJson(
    Map<String, dynamic> json) {
  final ServerListBeanDataData serverListBeanDataData =
      ServerListBeanDataData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    serverListBeanDataData.id = id;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    serverListBeanDataData.ip = ip;
  }
  final String? portHttp = jsonConvert.convert<String>(json['port_http']);
  if (portHttp != null) {
    serverListBeanDataData.portHttp = portHttp;
  }
  final String? portSs5 = jsonConvert.convert<String>(json['port_ss5']);
  if (portSs5 != null) {
    serverListBeanDataData.portSs5 = portSs5;
  }
  final String? timeEnd = jsonConvert.convert<String>(json['time_end']);
  if (timeEnd != null) {
    serverListBeanDataData.timeEnd = timeEnd;
  }
  final String? area = jsonConvert.convert<String>(json['area']);
  if (area != null) {
    serverListBeanDataData.area = area;
  }
  final String? uname = jsonConvert.convert<String>(json['uname']);
  if (uname != null) {
    serverListBeanDataData.uname = uname;
  }
  final String? passwd = jsonConvert.convert<String>(json['passwd']);
  if (passwd != null) {
    serverListBeanDataData.passwd = passwd;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    serverListBeanDataData.type = type;
  }
  final int? isConnect = jsonConvert.convert<int>(json['is_connect']);
  if (isConnect != null) {
    serverListBeanDataData.isConnect = isConnect;
  }
  final String? daikuan = jsonConvert.convert<String>(json['daikuan']);
  if (daikuan != null) {
    serverListBeanDataData.daikuan = daikuan;
  }
  return serverListBeanDataData;
}

Map<String, dynamic> $ServerListBeanDataDataToJson(
    ServerListBeanDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ip'] = entity.ip;
  data['port_http'] = entity.portHttp;
  data['port_ss5'] = entity.portSs5;
  data['time_end'] = entity.timeEnd;
  data['area'] = entity.area;
  data['uname'] = entity.uname;
  data['passwd'] = entity.passwd;
  data['type'] = entity.type;
  data['is_connect'] = entity.isConnect;
  data['daikuan'] = entity.daikuan;
  return data;
}

extension ServerListBeanDataDataExtension on ServerListBeanDataData {
  ServerListBeanDataData copyWith({
    int? id,
    String? ip,
    String? portHttp,
    String? portSs5,
    String? timeEnd,
    String? area,
    String? uname,
    String? passwd,
    int? type,
    int? isConnect,
    String? daikuan,
  }) {
    return ServerListBeanDataData()
      ..id = id ?? this.id
      ..ip = ip ?? this.ip
      ..portHttp = portHttp ?? this.portHttp
      ..portSs5 = portSs5 ?? this.portSs5
      ..timeEnd = timeEnd ?? this.timeEnd
      ..area = area ?? this.area
      ..uname = uname ?? this.uname
      ..passwd = passwd ?? this.passwd
      ..type = type ?? this.type
      ..isConnect = isConnect ?? this.isConnect
      ..daikuan = daikuan ?? this.daikuan;
  }
}
