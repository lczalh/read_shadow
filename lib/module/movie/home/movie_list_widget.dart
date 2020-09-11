import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/movie/home/recommend/movie_home_recommend_model.dart';

import 'movie_list_cell_widget.dart';

class MovieListWidget extends StatefulWidget {

  const MovieListWidget({
    Key key,
    @required this.listModel,
  }) : super(key: key);

  final List<MovieHomeRecommendMovieListModel> listModel;

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 10),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        MovieHomeRecommendMovieListModel model = widget.listModel[index];
        return Container(
          width: ScreenUtil().setWidth(200),
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: MovieListCellWidget(movieName: model.name, movieImageUrl: model.img, movieDirector: model.commentSpecial),
          ),
        );
      },
      itemCount: widget.listModel.length,
    );
  }
}