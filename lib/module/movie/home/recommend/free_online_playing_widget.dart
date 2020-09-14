import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/movie/home/movie_list_widget.dart';
import 'package:read_shadow/module/movie/home/recommend/movie_home_recommend_model.dart';
import 'package:read_shadow/module/movie/home/video_recommend_title_more_widget.dart';

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
          // color: Colors.blue,
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(60),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: VideoRecommendTitleMoreWidget(
              title: title,
            ),
          ),
        ),
        Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(300),
          child: MovieListWidget(
            listModel: listModel,
          ),
        )
      ],
    );
  }
}
