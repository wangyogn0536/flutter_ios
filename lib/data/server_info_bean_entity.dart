import 'dart:convert';

import 'package:agent_app_vpn/generated/json/base/json_field.dart';
import 'package:agent_app_vpn/generated/json/server_info_bean_entity.g.dart';

export 'package:agent_app_vpn/generated/json/server_info_bean_entity.g.dart';

@JsonSerializable()
class ServerInfoBeanEntity {
  late int code;
  late String info;
  late ServerInfoBeanData data;

  ServerInfoBeanEntity();

  factory ServerInfoBeanEntity.fromJson(Map<String, dynamic> json) =>
      $ServerInfoBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $ServerInfoBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ServerInfoBeanData {
  late int id;
  late String ip;
  @JSONField(name: "port_http")
  late String portHttp;
  @JSONField(name: "port_ss5")
  late String portSs5;
  late String area;
  @JSONField(name: "time_end")
  late String timeEnd;
  late int diffday;
  late String uname;
  late String passwd;

  ServerInfoBeanData();

  factory ServerInfoBeanData.fromJson(Map<String, dynamic> json) =>
      $ServerInfoBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $ServerInfoBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
