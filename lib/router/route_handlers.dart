import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:read_shadow/components/loading/cz_loading_toast.dart';
import 'package:read_shadow/module/video/details/video_details_widget.dart';
import 'package:read_shadow/module/video/piece_single_details/video_piece_single_details_widget.dart';
import 'package:read_shadow/module/video/player/video_player_widget.dart';
import 'package:read_shadow/module/video/search/movie_search_widget.dart';

// 电影搜索
var movieSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  print(params);
  return MovieSearchWidget();
});

/// 视频详情
var videoDetailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String movieName = params["movieName"].first;
  int movieId = int.parse(params["movieId"].first);
  return VideoDetailsWidget(
    movieName: movieName,
    movieId: movieId,
  );
});

/// 片单详情
var pieceSingleDetailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int articleId = int.parse(params["articleId"].first);
  return VideoPieceSingleDetailsWidget(articleId: articleId);
});

/// 视频播放页
var videoPlayerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String videoName = params["videoName"].first;
  String videoUrl = params["videoUrl"].first;
  String videoPlaySource = params["videoPlaySource"].first;
  return VideoPlayerWidget(
      videoName: videoName,
      videoUrl: videoUrl,
      videoPlaySource: videoPlaySource);
});
