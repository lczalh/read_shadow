import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/video/details/video_details_actors_widget.dart';
import 'package:read_shadow/module/video/details/video_details_film_critics_widget.dart';
import 'package:read_shadow/module/video/details/video_details_basic_info_widget.dart';
import 'package:read_shadow/module/video/details/video_details_introduction_widget.dart';
import 'package:read_shadow/module/video/details/video_details_model.dart';
import 'package:read_shadow/module/video/details/video_details_stage_widget.dart';
import 'package:read_shadow/module/video/details/video_details_type_widget.dart';
import 'package:read_shadow/utility/network/cz_network.dart';

class VideoDetailsWidget extends StatefulWidget {
  VideoDetailsWidget({Key key, this.movieName, this.movieId}) : super(key: key);

  /// 电影名称
  final String movieName;

  /// 电影id
  final int movieId;

  @override
  _VideoDetailsWidgetState createState() => _VideoDetailsWidgetState();
}

class _VideoDetailsWidgetState extends State<VideoDetailsWidget>
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
        path: "/movie/detail.api",
        params: {"locationId": 366, "movieId": widget.movieId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
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
      ),
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
    VideoDetailsModel model = VideoDetailsModel.fromMap(data);
    return Stack(
      children: [
        ConstrainedBox(
          child: CachedNetworkImage(
              fit: BoxFit.cover, imageUrl: model.data.basic.img
              // placeholder: (context, url) => Icons.add,
              //errorWidget: (context, url, error) =>
              // Image.asset("images/app.png"),
              ),
          constraints: new BoxConstraints.expand(),
        ),

        /// 蒙版
        Container(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),

        /// 内容
        ListView.builder(
          //padding: EdgeInsets.only(top: 0),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              /// 基本信息
              return VideoDetailsBasicInfoWidget(
                movieImageUrl: model.data.basic.img,
                movieName: model.data.basic.name,
                movieNameEn: model.data.basic.nameEn,
                movieArea: model.data.basic.releaseArea,
                movieMins: model.data.basic.mins,
                movieOverallRating: model.data.basic.overallRating,
                moviePersonCount: model.data.basic.personCount,
                movieRatingCount: model.data.basic.ratingCount,
              );
            } else if (index == 1) {
              /// 所属类型
              return model.data.basic.type.length > 0
                  ? VideoDetailsTypeWidget(types: model.data.basic.type)
                  : Container();
            } else if (index == 2) {
              /// 简介
              return model.data.basic.story.isEmpty == false
                  ? VideoDetailsIntroductionWidget(
                      movieIntroduction: model.data.basic.story,
                    )
                  : Container();
            } else if (index == 3) {
              /// 演职人员
              return model.data.basic.actors.length > 0
                  ? VideoDetailsActorsWidget(
                      actorModels: model.data.basic.actors)
                  : Container();
            } else if (index == 4) {
              /// 剧照
              return model.data.basic.stageImg != null &&
                      model.data.basic.stageImg.list.length > 0
                  ? VideoDetailsStageWidget(
                      listElementModels: model.data.basic.stageImg.list,
                    )
                  : Container();
            } else if (index == 5) {
              /// 预告与花絮
              return VideoDetailsFilmCriticsWidget(movieId: widget.movieId,);
            } else {
              return Text('Item$index');
            }
          },
          itemCount: 100,
        ),
      ],
    );
  }
}
