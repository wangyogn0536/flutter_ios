import '../../../../project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:我的钱包VM

class MyWalletModel extends BaseViewModel {
  String money = ''; //显示用户余额
  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
    memberInfoAPI();
  }

  /// 获取用户信息余额接口
  void memberInfoAPI() {
    HttpManager.requestData(Url.memberInfo, true, {}, ConfigString.requestPost,
        success: (res) {
      money = res['data']['balance'];
    }, complete: () {
      notifyListeners();
    });
  }

  void payMoneyMessage(String money, String payType, {Function? successOnTap}) {
    HttpManager.requestData(
        Url.payMoney,
        true,
        {'price': money, 'type': payType},
        ConfigString.requestPost, success: (res) {
      successOnTap!(res['data']['pay']);
    });
  }
}
