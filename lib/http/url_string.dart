/// Created by 刘冰.
/// Date:2024/5/23
/// des:网络接口字符串

class Url {
  ///正式根路径
  // static String baseUrl = "http://v2.api.siyetian.com";
  static String baseUrl = "http://api.s10.cn/v5/";

  ///测试跟路径

  // static String baseUrl = "http://192.168.0.17:8890/";
  // static String baseUrl = "http://ceshi.api.s10.cn/v5/";

  static String iosPayBaseUrl = "https://www.siyetian.com/";

  ///请求头设置
  static Map<String, String> httpHeader = {
    'Content-Type': 'application/json',
  };

  /// 登陆接口
  static String login = "sign/login";

  ///注册发送短信接口
  static String registerSmsSend = 'sign/sms_send';

  ///忘记密码发送短信接口
  static String forgetSmsSend = 'sign/sms_send_forget';

  ///注册接口
  static String smsRegister = "sign/sms_reg";

  ///忘记密码
  static String forget = "sign/forget";

  ///静态列表城市
  static String staticAreaList = 'member/jingtai/area';

  ///住宅列表城市
  static String residenceStaticAreaList = 'member/box/area';

  ///静态ip列表
  static String staticList = 'member/jingtai/list';

  ///住宅ip列表
  static String residenceList = 'member/box/list';

  ///节点信息详情
  static String serverContent = 'member/jingtai/info';

  ///修改密码借口
  static String changePassword = 'member/index/upass';

  ///实时监测接口(暂不用)
  static String rectDetection = 'check';

  ///实时监测2接口(暂不用)
  static String rectDetection2 = 'check2';

  ///用户隐私政策
  static String userPolicy = 'help/policy';

  ///网站服务条款
  static String webServiceTerms = 'help/service';

  ///连接VPN接口
  static String useStart = 'member/jingtai/use_start';

  ///断开VPN接口
  static String useEnd = 'member/jingtai/use_end';

  ///获取省份列表
  static String productProvince = 'product/province';

  ///静态节点接口
  static String productCity = 'product/node_static';

  ///住宅节点接口
  static String residenceNode = 'product/node_box';

  ///获取带宽选项
  // static String getDaikuanData = 'product/type';

  ///获取静态价格
  static String getStaticPrice = 'price/jingtai';

  ///获取住宅价格
  static String getResidencePrice = 'price/box';

  ///获取用户信息
  static String memberInfo = 'member/index/info';

  ///余额充值接口
  static String payMoney = 'payment/recharge';

  ///静态提交订单
  static String paymentStatic = 'payment/jingtai';

  ///住宅提交订单
  static String paymentResidence = 'payment/box';

  ///获取优惠券列表
  static String couponsList = 'member/coupons/list';

  ///获取可用优惠券列表购买支付使用
  static String productCoupons = 'product/coupons';

  ///实名认证获取url接口
  static String aliRealName = 'member/authent/create_url';

  ///检测是否完成认证接口
  static String checkAuthentication = 'member/authent/check';

  ///订单管理
  static String orderMember = 'member/order/list';

  ///续费服务器列表
  static String renewList = 'member/jingtai/renewlist';

  ///获取续费价格
  static String renewPrice = 'product/renew_price';

  ///提交续费订单
  static String renewStatic = 'payment/renewJ';

  ///投诉接口
  static String complaintEntrance = 'member/complaint/tijiao';

  ///反馈接口
  static String feedbackEntrance = 'member/complaint/yijian';

  ///苹果端内购接口
  static String iOSPurchase = 'data.paycall/iosnotifyCheck';

  ///苹果端注册接口
  static String iOSRegister = 'sign/sms_send_testing';

  ///购买须知
  static String purchaseNotes = 'tool/buynotice';

  ///注销接口
  static String loginOut = 'member/index/logoff';

  ///会员须知
  static String centerrules = 'member/center/rules';

  ///VIP获取基本信息
  static String centergetinfo = 'member/center/getinfo';

  ///VIP去签到
  static String centerqiandao = 'member/center/qiandao';

  ///VIP注册去领取
  static String centerzhuce = 'member/center/zhuce';

  ///VIP认证去领取
  static String centerauth = 'member/center/auth';

  ///VIP企业认证去领取
  static String centerauthCompany = 'member/center/auth_company';

  ///积分明细
  static String pointsGetlist = 'member/points/getlist';
}
