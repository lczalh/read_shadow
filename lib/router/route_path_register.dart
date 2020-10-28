
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handlers.dart';

class RoutePathRegister {

  static String root = "/";

  /// 电影搜索页
  static String movieSearch = "/movieSearch";

  /// 视频详情页
  static String videoDetails = "/videoDetails";

  /// 片单详情
  static String pieceSingleDetails = "/pieceSingleDetails";

  /// 视频播放页
  static String videoPlayer = "/videoPlayer";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    // 注册
    router.define(movieSearch, handler: movieSearchHandler);
    router.define(videoDetails, handler: videoDetailsHandler);
    router.define(pieceSingleDetails, handler: pieceSingleDetailsHandler);
    router.define(videoPlayer, handler: videoPlayerHandler);
  }
}
