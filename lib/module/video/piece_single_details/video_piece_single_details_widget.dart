import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/video/piece_single_details/video_piece_single_details_model.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';

class VideoPieceSingleDetailsWidget extends StatefulWidget {
  VideoPieceSingleDetailsWidget({Key key, this.articleId}) : super(key: key);

  /// 片单编号ID
  final int articleId;

  @override
  _VideoPieceSingleDetailsWidget createState() =>
      _VideoPieceSingleDetailsWidget();
}

class _VideoPieceSingleDetailsWidget
    extends State<VideoPieceSingleDetailsWidget> {

  var _future;

  String _title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getPieceSingleDetailsModel();
  }

  getPieceSingleDetailsModel() async {
    return await CZNetwork().get(
        baseUrl: "https://ticket-api-m.mtime.cn",
        path: "/article/detail.api",
        params: {"articleId": widget.articleId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title != null ? _title : ""),
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
    VideoPieceSingleDetailsModel pieceSingleDetailsModel =
        VideoPieceSingleDetailsModel.fromMap(data);



    Future.delayed(Duration(milliseconds: 0),(){
      /// 判断组件是否已被挂载
      if (this.mounted) {
        setState(() {
          _title = pieceSingleDetailsModel.data.publicInfo.name;
        });
      }
    });


    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            children: [
              Padding(
                child: Text(
                  pieceSingleDetailsModel.data.detail.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
                padding:
                    EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
              ),
              Padding(
                child: Text(
                  pieceSingleDetailsModel.data.detail.content,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
              )
            ],
          );
        } else {
          VideoPieceSingleDetailsMovieModel movieModel =
              pieceSingleDetailsModel.data.detail.topList.movies[index - 1];
          return Padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Theme.of(context).accentColor,
                      width: ScreenUtil().setWidth(70),
                      height: ScreenUtil().setHeight(30),
                    ),
                    Text(
                      'No.$index',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                GestureDetector(
                  child: Padding(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 片单图片
                        CachedNetworkImage(
                          width: ScreenUtil().setWidth(220),
                          height: ScreenUtil().setHeight(300),
                          fit: BoxFit.cover,
                          imageUrl: movieModel.img,
                          placeholder: (context, url) =>
                              Image.asset('images/icon_placeholder_figure.png', fit: BoxFit.cover,),
                          cacheManager: DefaultCacheManager(),
                          placeholderFadeInDuration: Duration.zero,
                          errorWidget: (context, url, error) =>
                              Image.asset('images/icon_placeholder_figure.png', fit: BoxFit.cover,),
                        ),

                        /// 片单信息
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieModel.name,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(28)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    movieModel.nameEn,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(26)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      RatingBar(
                                        initialRating: double.parse(
                                                movieModel.rating == null ||
                                                        movieModel.rating
                                                                .isEmpty ==
                                                            true
                                                    ? "0.0"
                                                    : movieModel.rating) /
                                            2.0,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemSize: ScreenUtil().setWidth(30),
                                      ),
                                      Padding(
                                        child: Text(
                                          "${movieModel.rating == null || movieModel.rating.isEmpty == true ? "0.0" : movieModel.rating}",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(26)),
                                          textAlign: TextAlign.left,
                                        ),
                                        padding: EdgeInsets.only(left: 5),
                                      )
                                    ],
                                  ),
                                ),

                                ///
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${movieModel.releaseLocation} · ${movieModel.releaseDate} · ${movieModel.movieType}",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(26)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "导演：${movieModel.director}",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(26)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "主演：${movieModel.actor}",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(26)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.only(top: 10),
                  ),
                  onTap: () {
                    CZRouter.cz_push(context, RoutePathRegister.videoDetails,
                        params: {
                          "movieName": movieModel.name,
                          "movieId": movieModel.movieId
                        });
                  },
                )
              ],
            ),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          );
        }
      },
      itemCount: pieceSingleDetailsModel.data.detail.topList.movies.length + 1,
    );
  }
}
