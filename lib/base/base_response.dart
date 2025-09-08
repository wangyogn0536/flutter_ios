/// Created by 刘冰.
/// Date:2024/2/21
/// des:网络数据处理基类

class BaseResponse<T> {
  late int? code;
  late String? info;
  BaseResponse({this.code, this.info});
  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    info = json['info'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['info'] = this.info;
    return data;
  }
}

// class Data<T> {
//   Data({
//     T? data,
//   }) {
//     _data = data;
//   }
//   Data.fromJson(dynamic json) {
//     _data = json['data'];
//   }
//
//   dynamic _data;
//
//   Data copyWith({
//     dynamic data,
//   }) =>
//       Data(
//         data: data ?? _data,
//       );
//   dynamic get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['data'] = _data;
//     return map;
//   }
// }
