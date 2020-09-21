import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/video/home/piece_single/video_piece_single_info_widget.dart';
import 'package:read_shadow/module/video/home/piece_single/video_piece_single_model.dart';
import 'package:read_shadow/module/video/home/recommend/hot_online_dramas_cell_widget.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

class VideoPieceSingleWidget extends StatefulWidget {
  VideoPieceSingleWidget({Key key, this.channelId}) : super(key: key);

  /// 1：小编强推 2：明星推荐 3：追剧向导 4：时光热榜
  final int channelId;

  @override
  _VideoPieceSingleWidget createState() => _VideoPieceSingleWidget();
}

class _VideoPieceSingleWidget extends State<VideoPieceSingleWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // var _future;

  // 记录当前页数
  int currentPage = 0;

  /// 存储所有列表模型
  List<VideoPieceSingleListElementModel> listModel = [];

  EasyRefreshController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
    //cz_print(widget.channelId, StackTrace.current);
    //cz_print(currentPage, StackTrace.current);
  }

  getVideoPieceSingleModel() {
    CZNetwork().get(
        baseUrl: "https://content-api-m.mtime.cn",
        path: "/movieList/channel/list.api",
        params: {
          "channelId": widget.channelId,
          "pageIndex": currentPage,
          "pageSize": "30"
        }).then((map) {
      VideoPieceSingleModel videoPieceSingleModel =
          VideoPieceSingleModel.fromMap(map);
      if (currentPage == 1) listModel.clear();
      for (VideoPieceSingleListElementModel model
          in videoPieceSingleModel.data.list) {
        listModel.add(model);
      }
      setState(() {});
      _controller.finishRefresh();
      _controller.finishLoad();
    }).catchError((error) {
      _controller.finishRefresh();
      _controller.finishLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      firstRefresh: true,
      firstRefreshWidget: Center(
          child: SpinKitFadingCube(
        color: Theme.of(context).accentColor,
      )),
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      // topBouncing: true,
      //bottomBouncing: true,
      controller: _controller,
      scrollController: _scrollController,
      emptyWidget: listModel.length == 0
          ? Center(
              child: Text(
                "暂无片单更新",
                // style: TextStyle(
                //fontSize: ScreenUtil().setSp(30), color: Colors.grey[400]),
              ),
            )
          : null,
      header: ClassicalHeader(),
      footer: ClassicalFooter(
        enableInfiniteLoad: true,
      ),
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: ScreenUtil().setWidth(1),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          VideoPieceSingleListElementModel model = listModel[index];
          return GestureDetector(
              onTap: () {
                CZRouter.cz_push(context, RoutePathRegister.pieceSingleDetails,
                    params: {"articleId": model.articleId});
              },
              child: VideoPieceSingleInfoWidget(
                pieceSingleName: model.title,
                pieceSingleImageUrl: model.movieImg,
                pieceSingleNum: model.movieCount,
              ));
        },
        itemCount: listModel.length,
      ),
      onRefresh: () async {
        currentPage = 1;
        cz_print(currentPage, StackTrace.current);
        getVideoPieceSingleModel();
      },
      onLoad: () async {
        currentPage += 1;
        cz_print(currentPage, StackTrace.current);
        getVideoPieceSingleModel();
      },
    );
  }
}
