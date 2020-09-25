import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';

class VideoDetailsBasicInfoWidget extends StatelessWidget {
  VideoDetailsBasicInfoWidget({
    Key key,
    this.movieImageUrl,
    this.movieName,
    this.movieNameEn,
    this.movieArea,
    this.movieMins,
    this.movieOverallRating,
    this.movieRatingCount,
    this.moviePersonCount,
  }) : super(key: key);

  /// 电影图片
  final String movieImageUrl;

  /// 电影名称
  final String movieName;

  /// 电影英文名称
  final String movieNameEn;

  /// 电影发布区域
  final String movieArea;

  /// 电影总时长
  final String movieMins;

  /// 电影评分
  final double movieOverallRating;

  /// 电影评分人数
  final int movieRatingCount;

  /// 电影想看人数
  final int moviePersonCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidth,
      //  height: ScreenUtil().setHeight(350),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Padding(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    width: ScreenUtil().setWidth(250),
                    height: ScreenUtil().setHeight(350),
                    fit: BoxFit.cover,
                    imageUrl: movieImageUrl,
                    placeholder: (context, url) =>
                        Image.asset('images/icon_placeholder_figure.png'),
                    cacheManager: DefaultCacheManager(),
                    placeholderFadeInDuration: Duration.zero,
                    errorWidget: (context, url, error) =>
                        Image.asset('images/icon_placeholder_figure.png'),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(250),
                    height: ScreenUtil().setHeight(350),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: ScreenUtil().setWidth(70),
                  )
                ],
              ),
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            ),
            onTap: () {
              CZRouter.cz_push(context, RoutePathRegister.movieSearch);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    maxLines: 2,
                  ),
                  Padding(
                    child: Text(
                      movieNameEn,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: Colors.white),
                    ),
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      "${movieArea} · ${movieMins} · ${movieOverallRating}分",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(26),
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      "${movieRatingCount}人评分 / ${moviePersonCount}人想看",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(26),
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
