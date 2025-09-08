import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/server_list_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/server_list_bean_entity.g.dart';

@JsonSerializable()
class ServerListBeanEntity {
  late int code;
  late String info;
  late ServerListBeanData data;

  ServerListBeanEntity();

  factory ServerListBeanEntity.fromJson(Map<String, dynamic> json) =>
      $ServerListBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $ServerListBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ServerListBeanData {
  late int total;
  @JSONField(name: "per_page")
  late int perPage;
  @JSONField(name: "current_page")
  late int currentPage;
  @JSONField(name: "last_page")
  late int lastPage;
  late List<ServerListBeanDataData> data;

  ServerListBeanData();

  factory ServerListBeanData.fromJson(Map<String, dynamic> json) =>
      $ServerListBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $ServerListBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ServerListBeanDataData {
  late int id;
  late String ip;
  @JSONField(name: "port_http")
  late String portHttp;
  @JSONField(name: "port_ss5")
  late String portSs5;
  @JSONField(name: "time_end")
  late String timeEnd;
  late String area;
  late String uname;
  late String passwd;
  late int type;
  @JSONField(name: "is_connect")
  late int isConnect;
  late String daikuan;

  ServerListBeanDataData();

  factory ServerListBeanDataData.fromJson(Map<String, dynamic> json) =>
      $ServerListBeanDataDataFromJson(json);

  Map<String, dynamic> toJson() => $ServerListBeanDataDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
