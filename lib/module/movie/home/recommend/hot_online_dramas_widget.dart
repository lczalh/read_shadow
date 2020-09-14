
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/movie/home/movie_list_cell_widget.dart';

import '../video_recommend_title_more_widget.dart';
import 'movie_home_recommend_model.dart';

class HotOnlineDramasWidget extends StatelessWidget {

  HotOnlineDramasWidget({Key key, this.title, this.listModel}) : super(key: key);

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
            child: VideoRecommendTitleMoreWidget(title: title,),
          ),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(), // 禁止滚动
          padding: EdgeInsets.only(left: 10, right: 10),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: ScreenUtil().setWidth(1),
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            final model = this.listModel[index];
            return GestureDetector(
              onTap: () {
               // var json = Uri.encodeComponent(model.toJson());
               // print(json);
                //CZRouter.cz_push(context, "${Routes.movieDetails}?params=$json");
              },
              child: MovieListCellWidget(movieName: model.name, movieImageUrl: model.img, movieDirector: model.commentSpecial));
          },
          itemCount: listModel.length,
        )
      ],
    );
  }
}