import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  int _currentPageIndex = 0;

  /// 存储所有列表模型
  List<VideoPieceSingleListElementModel> listModel = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getVideoPieceSingleModel() {
    CZNetwork().get(
        baseUrl: "https://content-api-m.mtime.cn",
        path: "/movieList/channel/list.api",
        params: {
          "channelId": widget.channelId,
          "pageIndex": _currentPageIndex,
          "pageSize": "30"
        }).then((map) {
      VideoPieceSingleModel videoPieceSingleModel =
          VideoPieceSingleModel.fromMap(map);
      if (_currentPageIndex == 1) listModel.clear();
      for (VideoPieceSingleListElementModel model
          in videoPieceSingleModel.data.list) {
        listModel.add(model);
      }
      setState(() {});
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: () async {
        _currentPageIndex = 1;
        await getVideoPieceSingleModel();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        _currentPageIndex += 1;
        await getVideoPieceSingleModel();
        _refreshController.loadComplete();
      },
      child: GridView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 3,
          childAspectRatio: ScreenUtil().setWidth(1),
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
    );

    //   EasyRefresh.custom(
    //   firstRefresh: true,
    //   firstRefreshWidget: Center(
    //       child: SpinKitFadingCube(
    //     color: Theme.of(context).accentColor,
    //   )),
    //   // scrollController: _scrollController,
    //   emptyWidget: listModel.length > 0 ? Center(
    //     child: Text(
    //       "暂无片单更新",
    //       // style: TextStyle(
    //       //fontSize: ScreenUtil().setSp(30), color: Colors.grey[400]),
    //     ),
    //   ) : null,
    //   header: SpaceHeader(),
    //   footer: ClassicalFooter(
    //     enableInfiniteLoad: true,
    //   ),
    //   slivers: <Widget>[
    //     SliverPadding(
    //       padding: EdgeInsets.all(10),
    //       sliver: listModel.length > 0 ? SliverGrid(
    //         // padding: EdgeInsets.all(10),
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 3, childAspectRatio: ScreenUtil().setWidth(1),),
    //         delegate:
    //         SliverChildBuilderDelegate((BuildContext context, int index) {
    //           VideoPieceSingleListElementModel model = listModel[index];
    //           return GestureDetector(
    //               onTap: () {
    //                 CZRouter.cz_push(
    //                     context, RoutePathRegister.pieceSingleDetails,
    //                     params: {"articleId": model.articleId});
    //               },
    //               child: VideoPieceSingleInfoWidget(
    //                 pieceSingleName: model.title,
    //                 pieceSingleImageUrl: model.movieImg,
    //                 pieceSingleNum: model.movieCount,
    //               ));
    //         }, childCount: listModel.length),
    //       ) : null,
    //     )
    //   ],
    //   onRefresh: () async {
    //     currentPage = 1;
    //     await getVideoPieceSingleModel();
    //   },
    //   onLoad: () async {
    //     currentPage += 1;
    //     await getVideoPieceSingleModel();
    //   },
    // );
  }
}
