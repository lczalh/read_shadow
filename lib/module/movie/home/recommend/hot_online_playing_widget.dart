
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../video_recommend_title_more_widget.dart';
import 'movie_home_recommend_model.dart';

class HotOnlinePlayingWidget extends StatelessWidget {

  HotOnlinePlayingWidget({Key key, this.title, this.listModel}) : super(key: key);

  final String title;

  final List<MovieHomeRecommendHotOnlinePlayingModel> listModel;

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
            child: VideoRecommendTitleMoreWidget(title: title,),
          ),
        ),
      ],
    );
  }
}