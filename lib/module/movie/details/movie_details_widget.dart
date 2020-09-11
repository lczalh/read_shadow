import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_shadow/module/movie/details/cz_video_player_widget.dart';
import 'package:read_shadow/module/movie/home/model/movie_root_model.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({
    Key key,
    this.model,
  }) : super(key: key);

  // 视频详情数据模型
  final MovieDataModel model;

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget>
    with TickerProviderStateMixin {

  //这里就是关键的代码，定义一个key
  // GlobalKey<CZVideoPlayerWidgetState> _childViewKey = new GlobalKey<CZVideoPlayerWidgetState>();


  // 注册一个通知, 传值 / 调用iOS 方法
  static const MethodChannel methodChannel = MethodChannel("cz_video_player/method_channel");

  //
  static const eventChannel = EventChannel('cz_video_player/event_channel');

  TabController _tabController;

  // 电影剧集标题数组
  List<String> movieSeriesTitles = [];

  // 电影剧集地址数组
  List<String> movieSeriesUrls = [];

  List<Tab> movieSeriesTabs = [];

  /// 视频当前播放索引
  int _currentPlayIndex = 0;

  /// 视频当前播放地址
  String _currentPlayUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieAddressResolution();

    //监听接收消息
    eventChannel.receiveBroadcastStream().listen(_getData,onError: _getError);

  }

  //获得到xiaoxi
  void _getData(dynamic data) {
    cz_print(data, StackTrace.current);
  }
  //获取到错误
  void _getError(Object err) {

  }

  /// 电影地址解析
  movieAddressResolution() {
    // 存储所有集（包含标题和地址）
    List<String> seriesTitleAndUrls = [];
    // 判断电影是否存在多集
    if (widget.model.vodUrl.contains("\r\n")) {
      // 多集
      // 获取所有集（包含标题和地址）
      seriesTitleAndUrls = widget.model.vodUrl.split("\r\n");
    } else {
      // 单集
      seriesTitleAndUrls.add(widget.model.vodUrl);
    }
    // 获取标题和地址
    for (String seriesTitleAndUrl in seriesTitleAndUrls) {
      // 单集的标题和地址
      var titleAndUrls = seriesTitleAndUrl.split("\$");
      movieSeriesTitles.add(titleAndUrls.first);
      movieSeriesUrls.add(titleAndUrls.last);
      movieSeriesTabs.add(Tab(text: titleAndUrls.first));
    }

    // 实例化 TabController
    _tabController = TabController(
      length: movieSeriesTitles.length,
      vsync: this,
    );

    // setState(() {
    //   _currentPlayUrl = movieSeriesUrls[0];
    // });
  }

  getMovieTitle() {
    if (movieSeriesTitles.length == 1) {

    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(_currentPlayUrl);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
      child: Column(
        children: [
          Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(350),
            child: CZVideoPlayerWidget(
                // key: _childViewKey,
                movieTitle: "${widget.model.vodName} - ${movieSeriesTitles[_currentPlayIndex]}",
                movieUrl: movieSeriesUrls[_currentPlayIndex],
                coverImageUrl: widget.model.vodPic,
              playBackBlock: () {
                  cz_print("playerBack", StackTrace.current);
              },
            ),

          ),
          Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(40),
            // color: Colors.blue,
            child: Padding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.model.vodName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("简介")
                ],
              ),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            ),
          ),
          Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(40),
            child: Padding(
              child: Text(
                "${widget.model.vodYear.length > 0 ? widget.model.vodYear : '未知'} · ${widget.model.vodArea.length > 0 ? widget.model.vodArea : '未知'} · ${widget.model.vodLanguage.length > 0 ? widget.model.vodLanguage : '未知'} · ${widget.model.vodType.length > 0 ? widget.model.vodType : '未知'} · ${widget.model.vodContinu.length > 0 ? widget.model.vodContinu : '未知'}",
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            ),
          ),
          Container(
              width: ScreenUtil.screenWidth,
              height: ScreenUtil().setHeight(60),
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.black,
                  labelColor: Theme.of(context).accentColor,
                  tabs: movieSeriesTabs,
                  controller: _tabController,
                  // 记得要带上tabController
                  onTap: (value) => {
                    setState(() {
                      setState(() {
                        _currentPlayIndex = value;
                      });
                      //_currentPlayUrl = movieSeriesUrls[value];
                      // _childViewKey.currentState.play();
                     // print(_currentPlayUrl);
                      // 发送信息
                      //methodChannel.invokeMethod("playVideoMethod", _currentPlayUrl);

                    })
                  },
                ),
              )),
        ],
      ),
    ));
  }

// createView() {
//   if (Platform.isAndroid) {
//     ///加载安卓原生视图
//     return Text('这个平台老子不支持');
//   } else if (Platform.isIOS) {
//     return UiKitView(
//       creationParams: <String, String>{
//         "url": "https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4",
//       },
//       creationParamsCodec: const StandardMessageCodec(),
//       viewType: "CZVideoPlayerViewFactory",
//     );
//   } else {
//     return Text('这个平台老子不支持');
//   }
// }
}
