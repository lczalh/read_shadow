import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:read_shadow/module/video/details/video_details_film_critics_model.dart';
import 'package:read_shadow/utility/network/cz_network.dart';

class VideoDetailsFilmCriticsWidget extends StatefulWidget {
  VideoDetailsFilmCriticsWidget({Key key, this.movieId}) : super(key: key);

  final int movieId;

  @override
  _VideoDetailsAdvanceTidbitsWidget createState() =>
      _VideoDetailsAdvanceTidbitsWidget();
}

class _VideoDetailsAdvanceTidbitsWidget
    extends State<VideoDetailsFilmCriticsWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getVideoTrailerInfoModel();
  }

  getVideoTrailerInfoModel() async {
    return await CZNetwork().get(
        baseUrl: "https://ticket-api-m.mtime.cn",
        path: "/movie/hotComment201905.api",
        params: {"movieId": widget.movieId});
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
    return Center();
  }

  _loadingErrorWidget() {
    return Center();
  }

  _dataWidget(data) {
    VideoDetailsFilmCriticsModel model =
        VideoDetailsFilmCriticsModel.fromMap(data);

    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: ScreenUtil().setHeight(50),
            child: Text(
              "短评",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
        ListView.builder(
          shrinkWrap: true,
          //解决无限高度问题
          physics: new NeverScrollableScrollPhysics(),
          //禁用滑动事件
          itemBuilder: (BuildContext context, int index) {
            VideoDetailsFilmCriticsMiniListModel miniListModel =
                model.data.mini.list[index];
            DateTime now = DateTime.now(); //获取当前时间
            /// 短评时间
            String shortDate = new DateFormat('yyyy-MM-dd hh:mm').format(
                DateTime.fromMillisecondsSinceEpoch(miniListModel.commentDate));
            return Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.topLeft,
              width: ScreenUtil.screenWidth,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          /// 头像
                          ClipRRect(
                            child: CachedNetworkImage(
                              width: ScreenUtil().setWidth(50),
                              height: ScreenUtil().setWidth(50),
                              imageUrl: miniListModel.img,
                              placeholder: (context, url) => Center(
                                  child: SpinKitFadingCube(
                                color: Theme.of(context).accentColor,
                              )),
                              errorWidget: (context, url, error) => Image.asset(
                                  'images/icon_placeholder_figure.png'),
                              fit: BoxFit.cover,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(25)),
                          ),

                          /// 名称
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              miniListModel.nickname,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(26)),
                            ),
                          ),

                          /// 时间
                          Text(
                            " · $shortDate",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(20)),
                          )
                        ],
                      ),
                      Text('9.0分',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(22))),
                    ],
                  ),

                  /// 短评内容
                  Padding(
                    child: Text(
                      miniListModel.content,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(24)),
                    ),
                    padding:
                        EdgeInsets.only(left: ScreenUtil().setWidth(50) + 10),
                  )
                ],
              ),
            );
          },
          itemCount: model.data.mini.list.length ?? 0,
        ),
        /// 影评
        Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: ScreenUtil().setHeight(50),
            child: Text(
              "影评",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
      ],
    );
  }
}
