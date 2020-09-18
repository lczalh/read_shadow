import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/video/home/recommend/video_recommend_model.dart';
import 'package:read_shadow/module/video/home/recommend/hot_online_dramas_more_widget.dart';

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
          // color: Colors.blue,
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
          height: ScreenUtil().setHeight(300),
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              MovieHomeRecommendMovieListModel model = listModel[index];
              return Container(
                width: ScreenUtil().setWidth(200),
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: HotOnlineDramasCellWidget(movieName: model.name, movieImageUrl: model.img, movieDirector: model.commentSpecial),
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
