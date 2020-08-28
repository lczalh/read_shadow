//import 'package:fijkplayer/core/lib.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_shadow/module/movie/home/movie_root_model.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:video_player/video_player.dart';

import 'cz_video_player_widget.dart';
//import 'package:video_player/video_player.dart';

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
  VideoPlayerController _controller;

  TabController tabController;

  // 电影剧集标题数组
  List<String> movieSeriesTitles = [];

  // 电影剧集地址数组
  List<String> movieSeriesUrls = [];

  List<Tab> movieSeriesTabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieAddressResolution();
    print("111111");
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

    _controller = VideoPlayerController.network(
        'https://tudou.diediao-kuyun.com/20200106/9868_5cfe5214/index.m3u8')
      ..initialize().then((_) {
        print(111111);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          print(111111);
          _controller.play();
        });
      });
    // _controller.

    // 实例化 TabController
    tabController = TabController(
      length: movieSeriesTitles.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fijkplayer Example")),
      body: Column(
        children: [
          CZVideoPlayerWidget(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(400),
            url:
                "https://tudou.diediao-kuyun.com/20200106/9868_5cfe5214/index.m3u8",
            imageUrl: widget.model.vodPic,
          ),
          // _controller.value.initialized
          //     ? Container(
          //         height: ScreenUtil().setHeight(400),
          //         width: ScreenUtil.screenWidth,
          //         child: Stack(
          //           alignment: Alignment.bottomLeft,
          //           children: [
          //             VideoPlayer(_controller),
          //             Row(
          //               children: [
          //                 Icon(
          //                   Icons.play_arrow,
          //                 )
          //               ],
          //             )
          //           ],
          //         ),
          //       )
          //     : CachedNetworkImage(
          //         fit: BoxFit.cover,
          //         height: ScreenUtil().setHeight(400),
          //         width: ScreenUtil.screenWidth,
          //         imageUrl: widget.model.vodPic
          //         // placeholder: (context, url) => Icons.add,
          //         //errorWidget: (context, url, error) =>
          //         // Image.asset("images/app.png"),
          //         ),
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
              padding: EdgeInsets.only(left: 10, right: 10),
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
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
          ),
          Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(44),
            child: TabBar(
              // labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Theme.of(context).accentColor,
              tabs: movieSeriesTabs,
              controller: tabController,
              // 记得要带上tabController
              onTap: (value) => {cz_print(value, StackTrace.current)},
            ),
          ),
        ],
      ),
    );
  }
}
