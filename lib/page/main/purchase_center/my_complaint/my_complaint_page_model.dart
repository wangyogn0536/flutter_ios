import '../../../../project_imports.dart';

class MyComplaintModel extends BaseViewModel {
  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
  }

  ///投诉入口
  void complaintEntranceAPI(String type, String content, String nickName,
      String phone, Function onTap) {
    Map<String, dynamic> params = {
      "type": type,
      "content": content,
      "nickname": nickName,
      "phone": phone,
    };
    HttpManager.requestData(
        Url.complaintEntrance, true, params, ConfigString.requestPost,
        success: (res) {
      onTap();
    }, complete: () {
      notifyListeners();
    });
  }

  ///反馈接口
  void feedbackEntranceAPI(String type, String content, String nickName,
      String phone, Function onTap) {
    Map<String, dynamic> params = {
      "type": type,
      "content": content,
      "nickname": nickName,
      "phone": phone,
    };
    HttpManager.requestData(
        Url.feedbackEntrance, true, params, ConfigString.requestPost,
        success: (res) {
      onTap();
    }, complete: () {
      notifyListeners();
    });
  }
}
