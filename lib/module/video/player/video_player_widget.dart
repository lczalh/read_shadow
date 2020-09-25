import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:read_shadow/components/loading/cz_loading_widget.dart';
import 'package:read_shadow/components/video_player/cz_video_player_widget.dart';
import 'package:read_shadow/module/video/player/video_player_model.dart';
import 'package:read_shadow/module/video/player/video_player_operate_widget.dart';
import 'package:read_shadow/module/video/player/video_player_series_widget.dart';
import 'package:read_shadow/module/video/player/video_player_source_widget.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

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

  CZVideoPlayerController _controller;


  @override
  initState() {
    // TODO: implement initState
    super.initState();
    _controller = CZVideoPlayerController.initialize();
    Future.delayed(Duration(seconds: 1), () {
      Future(() => _videoPlaySourceParsing())
          .then((value) => _videoUrlParsing());
    });
  }

  /// 视频播放源解析
  _videoPlaySourceParsing() async {
    if (widget.videoPlaySource.contains("\$\$\$") == true) {
      /// 存在多个播放源
      _allVideoPlaySources = widget.videoPlaySource.split("\$\$\$");
    } else {
      /// 只有一个播放源
      _allVideoPlaySources.add(widget.videoPlaySource);
    }
  }

  /// 视频播放地址解析
  _videoUrlParsing() async {
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
    setState(() {
      _controller.setTitle("2222");
      _controller.setUrl(
          "https://m3u8.htv009.com/video.m3u8?v=bHRsd3Q0QjBSVE8yRDB1N3ROamZlSTBsS3JXT0VzNmc=");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                /// 常用操作
                return VideoPlayerOperateWidget();
              } else if (index == 1) {
                /// 播放源
                return _allVideoPlaySources.length > 0
                    ? VideoPlayerSourceWidget(
                        allVideoPlaySources: _allVideoPlaySources,
                        tapPlaySourceBlock: (index) async {
                          _currentPlaySourceIndex = index;

                          /// 更新剧集数据
                          _videoPlayerWidgetKey.currentState.updateSeries(
                              _allSeriesTitles[_currentPlaySourceIndex],
                              _allSeriesUrls[_currentPlaySourceIndex]);
                        },
                      )
                    : Container();
              } else {
                /// 剧集
                /// 获取当前播放源的剧集
                return _allSeriesTitles.length > 0
                    ? VideoPlayerSeriesWidget(
                        key: _videoPlayerWidgetKey,
                        seriesTitles: _allSeriesTitles[_currentPlaySourceIndex],
                        seriesUrls: _allSeriesUrls[_currentPlaySourceIndex],
                        tapSeriesBlock: (index) async {
                          String title =
                              _allSeriesTitles[_currentPlaySourceIndex][index];
                          String url =
                              _allSeriesUrls[_currentPlaySourceIndex][index];

                          /// 解析视频播放地址
                          _videoPlayUrlParsing("${widget.videoName}$title", url);
                        },
                      )
                    : Container();
              }
            },
            itemCount: 3,
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(350)),
          ),

          /// 播放器
          Container(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(350),
            child:  CZVideoPlayerWidget(
              controller: _controller,
            ),
          )
        ],
      ),
    );
  }

  /// 视频播放地址解析
  _videoPlayUrlParsing(String title, String url) async {
    var httpClient = new HttpClient();
    var uri = new Uri.http('user.htv009.com', '/json', {
      'url': url
    });
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      VideoPlayerModel videoPlayerModel = VideoPlayerModel.fromJson(json);
      if (videoPlayerModel.url != null &&
          videoPlayerModel.url.isEmpty == false) {
        _controller.setTitle(title);
        _controller.setUrl(videoPlayerModel.url);
      } else {
        Fluttertoast.showToast(
            msg: "视频解析失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "服务器异常：${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).accentColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
