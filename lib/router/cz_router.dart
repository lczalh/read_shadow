import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

import 'application.dart';

class CZRouter {
  // 跳转 不带回调
  static cz_push(BuildContext context, String path,
      {Map<String, dynamic> params,
      bool replace = false,
      bool clearStack = false,
      TransitionType transition = TransitionType.native,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    String query = "";
    if (params != null) {
      query = "?";
      for (var key in params.keys) {
        var value = params[key];

        /// 是字符串才转义
        if (value is String) {
          value = Uri.encodeComponent(value);
        }

        /// 路径拼接
        query += "$key=$value&";
      }
    }
    print('路由器跳转传递的参数：${query.substring(0, query.length - 1)}');
    path = path + query.substring(0, query.length - 1);
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder);
  }

  // 跳转 带回调
  static cz_pushBlcok(BuildContext context, String path, Function(Object) block,
      {Map<String, dynamic> params,
      bool replace = false,
      bool clearStack = false,
      TransitionType transition = TransitionType.native,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    String query = "";
    if (params != null) {
      query = "?";
      for (var key in params.keys) {
        var value = params[key];

        /// 是字符串才转义
        if (value is String) {
          value = Uri.encodeComponent(value);
        }

        /// 路径拼接
        query += "$key=$value&";
      }
    }
    print('路由器跳转传递的参数：${query.substring(0, query.length - 1)}');
    Application.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: transition,
            transitionDuration: transitionDuration,
            transitionBuilder: transitionBuilder)
        .then((result) {
      cz_print(result, StackTrace.current);
      block(result);
    }).catchError((error) {
      cz_print(error, StackTrace.current);
    });
  }

  // 返回 不带参数
  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  // 返回 带参数
  static popParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }
}
