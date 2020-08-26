import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/utility/network/cz_api.dart';

import 'movie_home_list_item_widget.dart';
import 'movie_root_model.dart';

class MovieHomeListWidget extends StatefulWidget {
  @override
  _MovieHomeListWidgetState createState() => _MovieHomeListWidgetState();

  const MovieHomeListWidget({
    Key key,
    this.categoryId,
  }) : super(key: key);

  // 类别id
  final String categoryId;
}

class _MovieHomeListWidgetState extends State<MovieHomeListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 总数
  int _count = 0;

  //  列表数据
  List<MovieDataModel> models = [];

  // 记录当前页数
  int currentPage = 1;

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
    CZApi.getVideoData(p: currentPage, cid: widget.categoryId)
        .then((model) => {
              for (MovieDataModel model in model.data) {models.add(model)},
              // _controller.finishRefresh();
              setState(() {
                this.models;
              }),
              _controller.finishRefresh(),
              _controller.finishLoad(),
            })
        .catchError((error) => {
              _controller.finishRefresh(),
              _controller.finishLoad(),
              cz_print(error, StackTrace.current)
            });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      //     firstRefresh: true,
      firstRefreshWidget: Center(
        child: SpinKitFadingCube(
          color: Theme.of(context).primaryColor,
          size: 25.0,
        ),
      ),
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      // topBouncing: true,
      //bottomBouncing: true,
      controller: _controller,
      scrollController: _scrollController,
      emptyWidget: models.length == 0
          ? Center(
              child: Text(
                "暂无数据",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(30), color: Colors.grey[400]),
              ),
            )
          : null,
      header: ClassicalHeader(
        textColor: Colors.white70,
        infoColor: Colors.white70,
      ),
      footer: ClassicalFooter(
        enableInfiniteLoad: true,
        textColor: Colors.white70,
        infoColor: Colors.white70,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: ScreenUtil().setWidth(1.2),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          final model = this.models[index];
          return MovieHomeListItemWidget(
              movieName: model.vodName,
              movieImageUrl: model.vodPic,
              lastUpdateSeries: model.vodContinu);
        },
        itemCount: models.length,
      ),
      onRefresh: () async {
        currentPage = 1;
        models.clear();
        getVideoData();
      },
      onLoad: () async {
        currentPage += 1;
        getVideoData();
      },
    );
  }
}
