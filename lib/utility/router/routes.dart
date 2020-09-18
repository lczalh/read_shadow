/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
//  // 路由管理
//  static Router router;

  static String root = "/";

  // 电影搜索页
  static String movieSearch = "/movieSearch";

  // 电影详情页
  static String movieDetails = "/movieDetails";

  // 视频详情页
  static String videoDetails = "/videoDetails";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    // 注册
    router.define(movieSearch, handler: movieSearchHandler);
    router.define(videoDetails, handler: videoDetailsHandler);
  }
}
