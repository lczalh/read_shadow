import 'dart:async';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/video/player/cz_video_player_widget.dart';
import 'package:read_shadow/module/video/player/video_player_operate_widget.dart';
import 'package:read_shadow/module/video/player/video_player_series_widget.dart';
import 'package:read_shadow/module/video/player/video_player_source_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget(
      {Key key, this.videoName, this.videoUrl, this.videoPlaySource})
      : super(key: key);

  /// 视频名称
  final String videoName;

  /// 视频地址
  final String videoUrl;

  /// 视频播放源
  final String videoPlaySource;

  @override
  _VideoPlayerWidget createState() => _VideoPlayerWidget();
}

class _VideoPlayerWidget extends State<VideoPlayerWidget> {
  GlobalKey<VideoPlayerSeriesWidgetState> _videoPlayerWidgetKey = GlobalKey();

  /// 所有视频播放源
  List<String> _allVideoPlaySources = [];

  /// 所有播放剧集标题
  List<List<String>> _allSeriesTitles = [];

  /// 所有播放剧集地址
  List<List<String>> _allSeriesUrls = [];

  /// 当前播放源索引
  int _currentPlaySourceIndex = 0;

  /// 当前播放剧集索引
  int _currentPlaySeriesIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      Future(() => _videoPlaySourceParsing()).then((value) => _videoUrlParsing());
    });


  }

  /// 视频播放源解析
  _videoPlaySourceParsing() {
    if (widget.videoPlaySource.contains("\$\$\$") == true) {
      /// 存在多个播放源
      _allVideoPlaySources = widget.videoPlaySource.split("\$\$\$");
    } else {
      /// 只有一个播放源
      _allVideoPlaySources.add(widget.videoPlaySource);
    }
  }

  /// 视频播放地址解析
  _videoUrlParsing() {
    List<String> allPlaySourceUrls = [];
    if (widget.videoUrl.contains("\$\$\$") == true) {
      /// 存在多个播放源
      allPlaySourceUrls = widget.videoUrl.split("\$\$\$");
    } else {
      /// 只有一个播放源
      allPlaySourceUrls.add(widget.videoUrl);
    }
    for (String playSourceUrl in allPlaySourceUrls) {
      List<String> allSeries = [];
      if (playSourceUrl.contains("#") == true) {
        /// 存在多集
        allSeries = playSourceUrl.split("#");
      } else {
        /// 单集
        allSeries.add(playSourceUrl);
      }

      /// 存储当前播放源标题
      List<String> currentPlaySourceTitles = [];

      /// 存储当前播放源地址
      List<String> currentPlaySourceUrls = [];

      /// 取出标题和地址
      for (String series in allSeries) {
        List<String> titleAndUrls = series.split("\$");
        currentPlaySourceTitles.add(titleAndUrls.first);
        currentPlaySourceUrls.add(titleAndUrls.last);
      }
      _allSeriesTitles.add(currentPlaySourceTitles);
      _allSeriesUrls.add(currentPlaySourceUrls);
    }
    setState((){});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.videoName),
        ),
        body: _allSeriesTitles.length > 0 ? Stack(
          children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  /// 常用操作
                  return VideoPlayerOperateWidget();
                } else if (index == 1) {
                  /// 播放源
                  return VideoPlayerSourceWidget(
                    allVideoPlaySources: _allVideoPlaySources,
                    tapPlaySourceBlock: (index) async {
                      /// 更新剧集数据
                      _videoPlayerWidgetKey.currentState.updateSeries(
                          _allSeriesTitles[index], _allSeriesUrls[index]);
                    },
                  );
                } else {
                  /// 剧集
                  /// 获取当前播放源的剧集
                  return VideoPlayerSeriesWidget(
                      key: _videoPlayerWidgetKey,
                      seriesTitles: _allSeriesTitles[_currentPlaySourceIndex],
                      seriesUrls: _allSeriesUrls[_currentPlaySourceIndex]);
                }
              },
              itemCount: 3,
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(350)),
            ),

            /// 播放器
            Container(
              width: ScreenUtil.screenWidth,
              height: ScreenUtil().setHeight(350),
              child: CZVideoPlayerWidget(
                movieTitle: "11111",
                movieUrl:
                "https://diaoshi.dehua-kuyun.com/20200819/12783_4cbe5656/index.m3u8",
                coverImageUrl: "widget.model.vodPic",
                playBackBlock: () {
                  // cz_print("playerBack", StackTrace.current);
                },
              ),
            )
          ],
        ): Center(
            child: SpinKitFadingCube(
              color: Theme.of(context).accentColor,
            )));

  }
}
