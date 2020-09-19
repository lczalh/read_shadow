import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/video/home/recommend/video_recommend_model.dart';
import 'package:read_shadow/module/video/home/recommend/hot_online_dramas_more_widget.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';

import 'hot_online_dramas_cell_widget.dart';

class FreeOnlinePlayingWidget extends StatelessWidget {
  FreeOnlinePlayingWidget({Key key, this.title, this.listModel})
      : super(key: key);

  final String title;

  final List<MovieHomeRecommendMovieListModel> listModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(60),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: HotOnlineDramasMoreWidget(
              title: title,
            ),
          ),
        ),
        Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(400),
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              MovieHomeRecommendMovieListModel model = listModel[index];
              return Container(
                width: ScreenUtil().setWidth(250),
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                      onTap: () {
                        CZRouter.cz_push(context, RoutePathRegister.videoDetails, params: {"movieName": model.name, "movieId": model.movieId});
                      },
                      child: HotOnlineDramasCellWidget(
                          movieName: model.name,
                          movieImageUrl: model.img,
                          movieDirector: model.commentSpecial)),
                ),
              );
            },
            itemCount: listModel.length,
          ),
        )
      ],
    );
  }
}
