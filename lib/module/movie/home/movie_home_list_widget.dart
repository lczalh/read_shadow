import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/utility/network/cz_api.dart';

import 'movie_home_list_item_widget.dart';
import 'movie_root_model.dart';

class MovieHomeListWidget extends StatefulWidget {
  @override
  _MovieHomeListWidgetState createState() => _MovieHomeListWidgetState();
}

class _MovieHomeListWidgetState extends State<MovieHomeListWidget> {

  // 总数
  int _count = 0;

  //  列表数据
  List<MovieDataModel> models = [];

  // 记录当前页数
  int currentPage = 1;

  @override
  bool get wantKeepAlive => true;

  EasyRefreshController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  // 获取视频数据
  getVideoData() {
    CZApi.getVideoData(p: currentPage).then((model) => {
      for (MovieDataModel model in model.data) {
        models.add(model)
      },
      setState(() {
        this.models;
      })
    }).catchError((error) => {
      cz_print(error, StackTrace.current)
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      emptyWidget: models.length == 0
          ? Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "S.of(context).noData",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
                  ),
                ],
              ),
            )
          : null,
      header: ClassicalHeader(
        textColor: Colors.white70,
        infoColor: Colors.white70,
      ),
      footer: ClassicalFooter(
        textColor: Colors.white70,
        infoColor: Colors.white70,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {

          final model = this.models[index];
          return MovieHomeListItemWidget(movieName: model.vodName, movieImageUrl: model.vodPic, lastUpdateSeries: model.vodContinu);
        },
        itemCount: models.length,
      ),
      onRefresh: () async {
        currentPage = 1;
        getVideoData();
      },
      onLoad: () async {
        currentPage += 1;
        getVideoData();
      },
    );
  }
}
