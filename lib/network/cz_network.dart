import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'dart:convert';

class CZNetwork {
  static final CZNetwork _instance = CZNetwork._internal();

  factory CZNetwork() => _instance;

  Dio _dio;

  CZNetwork._internal() {
    if (_dio == null) {
      BaseOptions _options = BaseOptions(
        /// 请求基地址,可以包含子路径
      //  baseUrl: 'http://caiji.kuyun98.com',

        /// 连接服务器超时时间，单位是毫秒.
        connectTimeout: 5000,

        /// 接收数据的最长时限
        receiveTimeout: 3000,
      );

      _dio = Dio(_options);
      // 添加拦截器
      _dio.interceptors.add(CZInterceptors());
    }
  }

  /*
    GET 
    param 路径
    param 重试请求时间间隔
    param 最大重试次数
    param 请求成功回调
    param 请求失败回调
    ,
      Function(Map<String, dynamic> map) success,
      Function(String error) failure
  */
  /*
    GET
    param 请求基地址
    param 路径
    param 重试请求时间间隔
    param 最大重试次数
    param 请求成功回调
    param 请求失败回调
    ,
      Function(Map<String, dynamic> map) success,
      Function(String error) failure
  */
  dynamic get({@required String baseUrl, @required String path, Map<String, dynamic> params, int delay = 3, int max = 3}) async {
    try {
      Response response = await _dio.get("$baseUrl$path", queryParameters: params);
      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        throw Exception("服务器异常${response.statusCode}");
      }
    } catch (e) {
      if (max == 1) {
        throw Exception("似乎已断开与互联网的连接");
      } else {
        max -= 1;
        await Future.delayed(Duration(seconds: delay), () async {
          return await get(baseUrl: baseUrl, path: path, params: params, delay: delay, max: max);
        });
      }
    }
  }

  /*
    POST
    param 路径
    param 重试请求时间间隔
    param 最大重试次数
    param 请求成功回调
    param 请求失败回调
  */
  post(String path, Map<String, dynamic> params, int delay, int max) async {
    try {
      Response response = await _dio.post(path, data: params);
      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        throw Exception("服务器异常${response.statusCode}");
      }
    } catch (e) {
      if (max == 1) {
        throw Exception("似乎已断开与互联网的连接");
      } else {
        max -= 1;
        await Future.delayed(Duration(seconds: delay), () async {
          return await post(path, params, delay, max);
        });
      }
    }
  }
}

/// 拦截器
class CZInterceptors extends InterceptorsWrapper {
  /// 在请求被发送之前做一些事情
  @override
  Future onRequest(RequestOptions options) {
    cz_print(
        '请求基地址: ${options.baseUrl}, 请求路径: ${options.path}, 请求头: ${options.headers.toString()}, 请求参数: ${options.data.toString()}',
        StackTrace.current);
    return super.onRequest(options);
  }

  /// 在返回响应数据之前做一些预处理
  @override
  Future onResponse(Response response) {
    cz_print('请求响应状态: ${response.statusCode}, 请求响应数据: ${response.toString()}',
        StackTrace.current);
    return super.onResponse(response);
  }

  /// 当请求失败时做一些预处理
  @override
  Future onError(DioError err) {
    cz_print(
        '请求异常状态: ${err.response.statusCode}, 请求异常信息: ${err.response?.toString()}',
        StackTrace.current);
    return super.onError(err);
  }
}
