import 'dart:convert';
import 'dart:developer';

import 'package:agent_app_vpn/project_imports.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../base/base_response.dart';
import '../config/global.dart';
import '../page/login_register/login/login_page.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:封装的网络数据请求
typedef BackError = Function(int code, String msg);

class HttpManager {
  static Utf8Decoder utf8decoder = const Utf8Decoder();
  static final BaseOptions options = BaseOptions(
    baseUrl: Url.baseUrl,
    headers: Url.httpHeader,
  );
  static Dio dio = Dio(options);
  late BuildContext context;

  ///post和get接口请求
  static void requestData(
    String url,
    bool showLoading,
    Map<String, dynamic> params,
    String requestType, {
    Function? success,
    Function? fail,
    Function? complete,
  }) async {
    if (!url.contains('login')) {
      dio.options.headers['authorization'] =
          '${CacheManager.getInstance()?.get(ConfigString.token)}';
    }

    ///*${CacheManager.getInstance()?.get<String>(ConfigString.uuid)}
    try {
      if (showLoading) {
        SmartDialog.showLoading(msg: ConfigString.dataLoading);
      }
      debugPrint(
          '🙏🙏🙏方式——POST——接口：${Url.baseUrl}$url \n————传参————\n：$params');

      ///发起请求
      Response response;
      if (requestType == ConfigString.requestPost) {
        var jsonParams = utf8.encode(json.encode(params));
        response = await dio.post(
          url,
          data: jsonParams,
        );
      } else {
        String newUrl = '$url?';
        params.forEach((key, value) {
          newUrl = '$newUrl&$key=$value';
        });
        debugPrint('🙏🙏🙏方式——GET——接口：${Url.baseUrl}$newUrl\n——传参——\n:$params');

        response = await dio.get(newUrl, queryParameters: params);
      }
      if (response.statusCode == 200) {
        ///原始JSON数据格式
        debugPrint('😊😊😊url==${response.requestOptions.uri}');
        debugPrint('😊😊😊返回值$response');
        BaseResponse baseResponse = BaseResponse.fromJson(response.data);
        if (baseResponse.code == 1) {
          success!(response.data);
        } else if (baseResponse.code == 666) {
          MessageToast.toast(ConfigString.expirationLogin);
          reLogin();
        } else {
          MessageToast.toast('${baseResponse.info}');
          // if (url.contains('login')) {
          //   Future.delayed(Duration(milliseconds: 1), () {
          //     MessageToast.toast('${baseResponse.info}-------靠靠靠靠');
          //   });
          // } else {
          //   MessageToast.toast('${baseResponse.info}');
          // }
          fail!('${baseResponse.info}');
        }
      } else if (response.statusCode == 401) {
        MessageToast.toast(ConfigString.expirationLogin);
        reLogin();
      }
    } catch (e) {
      /// 处理Exception
      fail!(e);
      debugPrint('😭😭😭😭$e');
      MessageToast.toast(ConfigString.netRequestFail);
      // throw Exception(e);
    } finally {
      if (showLoading) {
        SmartDialog.dismiss();
      }
    }
    if (complete != null) {
      complete();
    }
  }

  ///跳转到登录页面
  static void reLogin() {
    CacheManager.clear();
    Navigator.of(Global.navigatorKey.currentState!.context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const LoginPage();
    }), (route) => false);
  }
}

class IosPayHttpManager {
  static Utf8Decoder utf8decoder = const Utf8Decoder();
  static final BaseOptions options = BaseOptions(
    baseUrl: Url.iosPayBaseUrl,
    headers: Url.httpHeader,
  );
  static Dio dio = Dio(options);
  late BuildContext context;

  ///post和get接口请求
  static void requestData(
    String url,
    Map<String, dynamic> params, {
    Function? success,
    Function? fail,
    Function? complete,
  }) async {
    try {
      SmartDialog.showLoading(msg: ConfigString.dataLoading);

      ///发起请求
      Response response;
      var jsonParams = utf8.encode(json.encode(params));
      response = await dio.post(
        url,
        data: jsonParams,
      );
      log('🙏🙏🙏方式——POST——接口：${Url.iosPayBaseUrl}$url \n————传参————\n：$params');
      if (response.statusCode == 200) {
        ///原始JSON数据格式
        log('😊😊😊返回值$response');
        BaseResponse baseResponse = BaseResponse.fromJson(response.data);
        if (baseResponse.code == 1) {
          success!(response.data);
        } else {
          MessageToast.toast('${baseResponse.info}');
          fail!('${baseResponse.info}');
        }
      }
    } catch (e) {
      /// 处理Exception
      fail!(e);
      log('😭😭😭😭$e');
      MessageToast.toast(ConfigString.netRequestFail);
      // throw Exception(e);
    } finally {
      SmartDialog.dismiss();
    }
    if (complete != null) {
      complete();
    }
  }
}
