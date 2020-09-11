import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/movie/home/widget/movie_home_list_item_widget.dart';

import '../../../../utility/cz_kit/cz_common.dart';
import '../../../../utility/cz_kit/cz_common.dart';
import '../../../../utility/network/cz_network.dart';
import '../movie_list_cell_widget.dart';
import '../movie_list_section_more_widget.dart';
import '../movie_list_widget.dart';
import 'movie_home_recommend_model.dart';

class MovieHomeRecommendWidget extends StatefulWidget {
  @override
  _MovieHomeRecommendWidgetState createState() =>
      _MovieHomeRecommendWidgetState();
}

class _MovieHomeRecommendWidgetState extends State<MovieHomeRecommendWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // CZNetwork().get(baseUrl: "https://ticket-api-m.mtime.cn", path: "/videoChannel/index.api").then((model) => {
    //   print(model)
    // }).catchError((error) => {
    //   cz_print(error, StackTrace.current)
    // });
    _future = getRecommendMovieData();
  }

  getRecommendMovieData() async {
    return await CZNetwork().get(
        baseUrl: "https://ticket-api-m.mtime.cn",
        path: "/videoChannel/index.api");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    MovieHomeRecommendRootModel model =  MovieHomeRecommendRootModel.fromMap(data);
    cz_print(model, StackTrace.current);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            children: [
              Container(
                // color: Colors.blue,
                width: ScreenUtil.screenWidth,
                height: ScreenUtil().setHeight(60),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: MovieListSectionMoreWidget(),
                ),
              ),
              Container(
              //  margin: EdgeInsets.only(left: 10),
                width: ScreenUtil.screenWidth,
                height: ScreenUtil().setHeight(300),
                child: MovieListWidget(listModel: model.data.freeOnlinePlaying.movieList,),
              )
            ],
          );

            Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(350),
            child: Column(
              children: [
                Container(
                  // color: Colors.blue,
                  width: ScreenUtil.screenWidth,
                  height: ScreenUtil().setHeight(60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("免费电影"), Text('更多')],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: MovieListWidget(listModel: model.data.freeOnlinePlaying.movieList,),
                  ),
                )
              ],
            ),
          );
        } else {
          return Text('Item$index');
        }
      },
    );
  }
}
