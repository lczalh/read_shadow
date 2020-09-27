import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:read_shadow/module/video/home/recommend/hot_online_dramas_widget.dart';
import 'package:read_shadow/module/video/home/recommend/topic_movie_ranking_widget.dart';
import 'package:read_shadow/module/video/home/recommend/video_recommend_swiper_widget.dart';
import 'package:read_shadow/network/cz_network.dart';

import '../../../../utility/cz_kit/cz_common.dart';
import 'free_online_playing_widget.dart';
import 'video_recommend_model.dart';

class VideoRecommendWidget extends StatefulWidget {
  @override
  _VideoRecommendWidgetState createState() => _VideoRecommendWidgetState();
}

class _VideoRecommendWidgetState extends State<VideoRecommendWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getRecommendMovieData();
  }

  getRecommendMovieData() async {
    return await CZNetwork().get(
        baseUrl: "https://ticket-api-m.mtime.cn",
        path: "/videoChannel/index.api");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        var widget;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            widget = _loadingErrorWidget();
          } else {
            widget = _dataWidget(snapshot.data);
          }
        } else {
          widget = _loadingWidget();
        }
        return widget;
      },
    );
  }

  _loadingWidget() {
    return Center(
        child: SpinKitFadingCube(
      color: Theme.of(context).accentColor,
    ));
  }

  _loadingErrorWidget() {
    return Center(
      child: Text('数据加载失败，请重试。'),
    );
  }

  _dataWidget(data) {
    if (data == null) { return Container(); }
    MovieHomeRecommendRootModel model =
        MovieHomeRecommendRootModel.fromMap(data);

    if (model.data == null) {
      return Center(
        child: Text("暂无数据"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            /// 轮播图
            return VideoRecommendSwiperWidget();
          } else if (index == 1) {
            if (model.data.latestOnlinePlaying.movieList != null &&
                model.data.latestOnlinePlaying.movieList.length > 0) {
              return HotOnlineDramasWidget(
                title: "最新上线",
                listModel: model.data.latestOnlinePlaying.movieList ?? [],
              );
            } else {
              return Container();
            }
          } else if (index == 2) {
            if (model.data.freeOnlinePlaying.movieList != null &&
                model.data.freeOnlinePlaying.movieList.length > 0) {
              return FreeOnlinePlayingWidget(
                title: "免费电影",
                listModel: model.data.freeOnlinePlaying.movieList ?? [],
              );
            } else {
              return Container();
            }
          } else if (index == 3) {
            if (model.data.hotOnlineDramas.movieList != null &&
                model.data.hotOnlineDramas.movieList.length > 0) {
              return FreeOnlinePlayingWidget(
                title: "热门电视剧",
                listModel: model.data.hotOnlineDramas.movieList ?? [],
              );
            } else {
              return Container();
            }
          } else {
            MovieHomeRecommendArticleListModel
                movieHomeRecommendArticleListModel =
                model.data.topicMovieRanking.articleList[index - 4];
            return TopicMovieRankingWidget(
                articleListModel: movieHomeRecommendArticleListModel);
          }
        },
        itemCount: model.data.topicMovieRanking != null &&
                model.data.topicMovieRanking.articleList.length > 0
            ? (model.data.topicMovieRanking.articleList.length + 4)
            : 4,
      );
    }
  }
}
