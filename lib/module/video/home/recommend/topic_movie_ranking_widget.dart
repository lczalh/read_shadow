import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:read_shadow/module/video/home/recommend/topic_movie_ranking_cell_widget.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';

import 'hot_online_dramas_cell_widget.dart';
import 'video_recommend_model.dart';

class TopicMovieRankingWidget extends StatelessWidget {
  TopicMovieRankingWidget({Key key, this.articleListModel}) : super(key: key);

  final MovieHomeRecommendArticleListModel articleListModel;

  @override
  Widget build(BuildContext context) {
    if (articleListModel.relatedMovies != null &&
        articleListModel.relatedMovies.length > 0) {
      return GestureDetector(
          onTap: () {
            CZRouter.cz_push(context, RoutePathRegister.videoDetails, params: {
              "movieName": articleListModel.relatedMovie.name,
              "movieId": articleListModel.relatedMovie.movieId
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().setHeight(600),
                      fit: BoxFit.cover,
                      imageUrl: articleListModel.relatedMovie.img,
                      cacheManager: DefaultCacheManager(),
                      placeholderFadeInDuration: Duration.zero,
                      // errorWidget: (context, url, error) =>
                      //     Image.asset('assets/images/icon_placeholder_figure.png'),
                    )),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().setHeight(600),
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题 和 共多少部
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              articleListModel.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(26),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "共${articleListModel.movieCount}部",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          CZRouter.cz_push(context, RoutePathRegister.pieceSingleDetails,
                              params: {"articleId": articleListModel.articleId});
                        },
                      ),

                      // 名称 和评分
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Text(
                              articleListModel.relatedMovie.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(22),
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "  ${articleListModel.relatedMovie.rating}分",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(22),
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),

                      // 类型
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          articleListModel.relatedMovie.movieType,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(22),
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // 导演
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          articleListModel.relatedMovie.commentSpecial,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(22),
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // 简介
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          articleListModel.relatedMovie.paragraph,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(22),
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                        child: Container(
                          // padding: EdgeInsets.only(),
                          width: ScreenUtil().screenWidth - 40,
                          height: ScreenUtil().setHeight(300),
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              MovieHomeRecommendMovieListModel
                                  movieHomeRecommendMovieListModel =
                                  articleListModel.relatedMovies[index];
                              return GestureDetector(
                                  onTap: () {
                                    CZRouter.cz_push(
                                        context, RoutePathRegister.videoDetails,
                                        params: {
                                          "movieName":
                                              movieHomeRecommendMovieListModel
                                                  .name,
                                          "movieId":
                                              movieHomeRecommendMovieListModel
                                                  .movieId
                                        });
                                  },
                                  child: TopicMovieRankingCellWidget(
                                      title:
                                          movieHomeRecommendMovieListModel.name,
                                      imageUrl:
                                          movieHomeRecommendMovieListModel.img,
                                      score: movieHomeRecommendMovieListModel
                                          .rating));
                            },
                            // itemHeight: ScreenUtil().setHeight(200),
                            // itemWidth: ScreenUtil().setWidth(50),
                            itemCount:
                                articleListModel.relatedMovies.length ?? 0,
                            viewportFraction: 0.8,
                            scale: 0.8,
                            //autoplay: true,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
    } else {
      return Container();
    }
  }
}
