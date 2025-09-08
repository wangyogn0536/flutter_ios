import 'package:agent_app_vpn/generated/json/base/json_convert_content.dart';
import 'package:agent_app_vpn/data/vip_list_entity.dart';

VIPRuleListData $VIPRuleListDataFromJson(Map<String, dynamic> json) {
  final VIPRuleListData vipRuleListData = VIPRuleListData();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    vipRuleListData.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    vipRuleListData.info = info;
  }
  final List<VIPRuleData>? data = (json['data'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<VIPRuleData>(e) as VIPRuleData)
      .toList();
  if (data != null) {
    vipRuleListData.data = data;
  }

  return vipRuleListData;
}

Map<String, dynamic> $VIPRuleListDataToJson(VIPRuleListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['info'] = entity.info;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension VIPRuleListDataExtension on VIPRuleListData {
  VIPRuleListData copyWith({int? code, String? info, List<VIPRuleData>? data}) {
    return VIPRuleListData()
      ..code = code ?? this.code
      ..info = info ?? this.info
      ..data = data ?? this.data;
  }
}

VIPRuleData $VIPRuleDataFromJson(Map<String, dynamic> json) {
  final VIPRuleData vipRuleData = VIPRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    vipRuleData.title = title;
  }

  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    vipRuleData.content = content;
  }

  return vipRuleData;
}

Map<String, dynamic> $VIPRuleDataToJson(VIPRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['content'] = entity.content;
  return data;
}

extension VIPRuleDataExtension on VIPRuleData {
  VIPRuleData copyWith({
    String? title,
    String? content,
  }) {
    return VIPRuleData()
      ..content = content ?? this.content
      ..title = title ?? this.title;
  }
}

VIPInfoData $VIPInfoDataFromJson(Map<String, dynamic> json) {
  final VIPInfoData viInfoData = VIPInfoData();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    viInfoData.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    viInfoData.info = info;
  }

  final VIPInfoObjectData? data =
      jsonConvert.convert<VIPInfoObjectData>(json['data']);
  if (data != null) {
    viInfoData.data = data;
  }
  return viInfoData;
}

VIPInfoObjectData $VIPInfoObjectDataFromJson(Map<String, dynamic> json) {
  final VIPInfoObjectData viInfoData = VIPInfoObjectData();
  final int? point = jsonConvert.convert<int>(json['point']);
  if (point != null) {
    viInfoData.point = point;
  }

  final String? balance = jsonConvert.convert<String>(json['balance']);
  if (balance != null) {
    viInfoData.balance = balance;
  }

  final int? youhuiquan = jsonConvert.convert<int>(json['youhuiquan']);
  if (youhuiquan != null) {
    viInfoData.youhuiquan = youhuiquan;
  }

  final int? qiandao = jsonConvert.convert<int>(json['qiandao']);
  if (qiandao != null) {
    viInfoData.qiandao = qiandao;
  }

  final int? zhuce = jsonConvert.convert<int>(json['zhuce']);
  if (zhuce != null) {
    viInfoData.zhuce = zhuce;
  }

  final int? auth = jsonConvert.convert<int>(json['auth']);
  if (auth != null) {
    viInfoData.auth = auth;
  }

  final int? authcompany = jsonConvert.convert<int>(json['auth_company']);
  if (authcompany != null) {
    viInfoData.authcompany = authcompany;
  }

  final int? yaoqingnum = jsonConvert.convert<int>(json['yaoqingnum']);
  if (yaoqingnum != null) {
    viInfoData.yaoqingnum = yaoqingnum;
  }

  final int? productbug = jsonConvert.convert<int>(json['product_bug']);
  if (productbug != null) {
    viInfoData.productbug = productbug;
  }

  final String? tgurl = jsonConvert.convert<String>(json['tg_url']);
  if (tgurl != null) {
    viInfoData.tgurl = tgurl;
  }

  final VIPGradeinfoData? gradeinfo =
      jsonConvert.convert<VIPGradeinfoData>(json['gradeinfo']);
  if (gradeinfo != null) {
    viInfoData.gradeinfo = gradeinfo;
  }

  final VIPPointConfigData? pointConfig =
      jsonConvert.convert<VIPPointConfigData>(json['pointConfig']);
  if (pointConfig != null) {
    viInfoData.pointConfig = pointConfig;
  }
  return viInfoData;
}

VIPGradeinfoData $VIPGradeinfoDataFromJson(Map<String, dynamic> json) {
  final VIPGradeinfoData gradeinfo = VIPGradeinfoData();
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    gradeinfo.level = level;
  }

  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    gradeinfo.price = price;
  }

  final VIPLevelcurData? levelcur =
      jsonConvert.convert<VIPLevelcurData>(json['levelcur']);
  if (levelcur != null) {
    gradeinfo.levelcur = levelcur;
  }

  final VIPLevelnextData? levelnext =
      jsonConvert.convert<VIPLevelnextData>(json['levelnext']);
  if (levelnext != null) {
    gradeinfo.levelnext = levelnext;
  }

  return gradeinfo;
}

VIPPointConfigData $VIPPointConfigDataFromJson(Map<String, dynamic> json) {
  final VIPPointConfigData pointConfig = VIPPointConfigData();
  final int? zhuce = jsonConvert.convert<int>(json['zhuce']);
  if (zhuce != null) {
    pointConfig.zhuce = zhuce;
  }

  final int? auth = jsonConvert.convert<int>(json['auth']);
  if (auth != null) {
    pointConfig.auth = auth;
  }

  final int? authcompany = jsonConvert.convert<int>(json['auth_company']);
  if (authcompany != null) {
    pointConfig.authcompany = authcompany;
  }

  final int? qiandao = jsonConvert.convert<int>(json['qiandao']);
  if (qiandao != null) {
    pointConfig.qiandao = qiandao;
  }

  final int? yaoqing = jsonConvert.convert<int>(json['yaoqing']);
  if (yaoqing != null) {
    pointConfig.yaoqing = yaoqing;
  }

  final int? bug = jsonConvert.convert<int>(json['bug']);
  if (bug != null) {
    pointConfig.bug = bug;
  }

  final String? consume = jsonConvert.convert<String>(json['consume']);
  if (consume != null) {
    pointConfig.consume = consume;
  }

  return pointConfig;
}

VIPLevelcurData $VIPLevelcurDataFromJson(Map<String, dynamic> json) {
  final VIPLevelcurData level = VIPLevelcurData();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    level.min = min;
  }

  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    level.max = max;
  }

  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    level.discount = discount;
  }

  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    level.name = name;
  }

  return level;
}

VIPLevelnextData $VIPLevelnextDataFromJson(Map<String, dynamic> json) {
  final VIPLevelnextData level = VIPLevelnextData();
  final int? min = jsonConvert.convert<int>(json['min']);
  if (min != null) {
    level.min = min;
  }

  final int? max = jsonConvert.convert<int>(json['max']);
  if (max != null) {
    level.max = max;
  }

  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    level.discount = discount;
  }

  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    level.name = name;
  }

  return level;
}

PointInfoData $PointInfoDataFromJson(Map<String, dynamic> json) {
  final PointInfoData pointInfoData = PointInfoData();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    pointInfoData.code = code;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    pointInfoData.info = info;
  }

  final PointInfoPageData? data = jsonConvert.convert<PointInfoPageData>(
    json['data'],
  );
  if (data != null) {
    pointInfoData.data = data;
  }
  return pointInfoData;
}

PointInfoPageData $PointInfoPageDataFromJson(Map<String, dynamic> json) {
  final PointInfoPageData pointInfoData = PointInfoPageData();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    pointInfoData.total = total;
  }

  final int? perpage = jsonConvert.convert<int>(json['per_page']);
  if (perpage != null) {
    pointInfoData.perpage = perpage;
  }

  final int? currentpage = jsonConvert.convert<int>(json['current_page']);
  if (currentpage != null) {
    pointInfoData.currentpage = currentpage;
  }

  final int? lastpage = jsonConvert.convert<int>(json['last_page']);
  if (lastpage != null) {
    pointInfoData.lastpage = lastpage;
  }

  final List<PointInfoListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
        (e) => jsonConvert.convert<PointInfoListData>(e) as PointInfoListData,
      )
      .toList();
  if (data != null) {
    pointInfoData.data = data;
  }
  return pointInfoData;
}

PointInfoListData $PointInfoListDataFromJson(Map<String, dynamic> json) {
  final PointInfoListData pointInfoData = PointInfoListData();
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    pointInfoData.price = price;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    pointInfoData.type = type;
  }
  final String? createat = jsonConvert.convert<String>(json['create_at']);
  if (createat != null) {
    pointInfoData.createat = createat;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    pointInfoData.msg = msg;
  }
  return pointInfoData;
}
