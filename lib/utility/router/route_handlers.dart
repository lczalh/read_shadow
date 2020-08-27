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
import 'package:read_shadow/module/movie/details/movie_details_widget.dart';
import 'package:read_shadow/module/movie/home/movie_root_model.dart';
import 'package:read_shadow/module/movie/search/movie_search_widget.dart';

// 电影搜索
var movieSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print(params);
  return MovieSearchWidget();
});

// 电影详情
var movieDetailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MovieDetailsWidget(model: MovieDataModel.fromJson(params["params"].first),);
});
