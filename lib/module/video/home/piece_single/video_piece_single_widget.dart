import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/video/home/piece_single/video_piece_single_model.dart';
import 'package:read_shadow/network/cz_network.dart';

class VideoPieceSingleWidget extends StatefulWidget {
  VideoPieceSingleWidget({Key key, this.channelId}) : super(key: key);

  /// 1：小编强推 2：明星推荐 3：追剧向导 4：时光热榜
  final int channelId;

  @override
  _VideoPieceSingleWidget createState() => _VideoPieceSingleWidget();
}

class _VideoPieceSingleWidget extends State<VideoPieceSingleWidget> {
  @override
  bool get wantKeepAlive => true;

  var _future;

  // 记录当前页数
  int currentPage = 1;

  EasyRefreshController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
    _future = getVideoTrailerInfoModel();
  }

  getVideoTrailerInfoModel() async {
    return await CZNetwork().get(
        baseUrl: "https://content-api-m.mtime.cn",
        path: "/movieList/channel/list.api",
        params: {
          "channelId": widget.channelId,
          "pageIndex": currentPage,
          "pageSize": "30"
        });
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
    VideoPieceSingleModel videoPieceSingleModel = VideoPieceSingleModel.fromMap(data);
    return EasyRefresh(
      // firstRefresh: true,
      // firstRefreshWidget: Center(
      //   child: SpinKitFadingCube(
      //     color: Theme.of(context).primaryColor,
      //     size: 25.0,
      //   ),
      // ),
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      // topBouncing: true,
      //bottomBouncing: true,
      controller: _controller,
      scrollController: _scrollController,
      // emptyWidget: models.length == 0
      //     ? Center(
      //   child: Text(
      //     "暂无数据",
      //    // style: TextStyle(
      //         //fontSize: ScreenUtil().setSp(30), color: Colors.grey[400]),
      //   ),
      // )
      //     : null,
      header: ClassicalHeader(),
      footer: ClassicalFooter(
        enableInfiniteLoad: true,
      ),
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: ScreenUtil().setWidth(1.2),
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.red,
          );
        },
        itemCount: videoPieceSingleModel.data.list.length,
      ),
      onRefresh: () async {},
      onLoad: () async {},
    );
  }
}
