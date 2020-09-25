import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:read_shadow/components/loading/cz_loading_toast.dart';
import 'package:read_shadow/module/video/player/video_player_model.dart';
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

  final FijkPlayer fijkPlayer = FijkPlayer();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
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
    setState(() {});
    _videoPlayUrlParsing(
        _allSeriesTitles[_currentPlaySourceIndex][_currentPlaySeriesIndex],
        _allSeriesUrls[_currentPlaySourceIndex][_currentPlaySeriesIndex]);
  }

  @override
  void dispose() {
    super.dispose();
    fijkPlayer.release();
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

                          /// 获取当前播放源的所有剧集
                          var titles =
                              _allSeriesTitles[_currentPlaySourceIndex];
                          var urls = _allSeriesUrls[_currentPlaySourceIndex];

                          /// 判断当前播放源的集数 是否大于等于 当前播放的集数 否则 将当前剧集重置为0
                          if (titles.length - 1 > _currentPlaySeriesIndex) {
                            _currentPlaySeriesIndex = 0;
                          }

                          /// 更新剧集数据
                          _videoPlayerWidgetKey.currentState.updateSeries(
                              titles, urls, _currentPlaySeriesIndex);

                          /// 解析播放
                          _videoPlayUrlParsing(titles[_currentPlaySeriesIndex],
                              urls[_currentPlaySeriesIndex]);
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
                        currentSeriesIndex: _currentPlaySeriesIndex,
                        tapSeriesBlock: (index) async {
                          String title =
                              _allSeriesTitles[_currentPlaySourceIndex][index];
                          String url =
                              _allSeriesUrls[_currentPlaySourceIndex][index];

                          /// 解析视频播放地址
                          _videoPlayUrlParsing(
                              "${widget.videoName}$title", url);
                        },
                      )
                    : Container();
              }
            },
            itemCount: 3,
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(400)),
          ),

          /// 播放器
          FijkView(
            player: fijkPlayer,
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(400),
            fit: FijkFit.fill,
            fsFit: FijkFit.fill,
            // panelBuilder: (FijkPlayer player, FijkData data, BuildContext context, Size viewSize, Rect texturePos) {
            //   return CustomFijkPanel(
            //       player: player,
            //       buildContext: context,
            //       viewSize: viewSize,
            //       texturePos: texturePos);
            // },
          ),
        ],
      ),
    );
  }

  /// 视频播放地址解析
  _videoPlayUrlParsing(String title, String url) async {
    //  CZLoadingToast.show('资源解析中', context);
    var httpClient = new HttpClient();
    var uri = new Uri.http('user.htv009.com', '/json', {'url': url});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      VideoPlayerModel videoPlayerModel = VideoPlayerModel.fromJson(json);
      CZLoadingToast.dismiss();
      if (videoPlayerModel.url != null &&
          videoPlayerModel.url.isEmpty == false) {
        await fijkPlayer.reset();
        fijkPlayer.setDataSource(videoPlayerModel.url, autoPlay: true);
      } else {
        Fluttertoast.showToast(
            msg: "资源解析失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      CZLoadingToast.dismiss();
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

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;

  const CustomFijkPanel({
    @required this.player,
    this.buildContext,
    this.viewSize,
    this.texturePos,
  });

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel> {
  FijkPlayer get player => widget.player;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_playerValueChanged);
  }

  void _playerValueChanged() {
    FijkValue value = player.value;

    bool playing = (value.state == FijkState.started);
    if (playing != _playing) {
      setState(() {
        _playing = playing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTRB(
        max(0.0, widget.texturePos.left),
        max(0.0, widget.texturePos.top),
        min(widget.viewSize.width, widget.texturePos.right),
        min(widget.viewSize.height, widget.texturePos.bottom));

    return Positioned.fromRect(
      rect: rect,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: IconButton(
          icon: Icon(
            _playing ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {
            _playing ? widget.player.pause() : widget.player.start();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.removeListener(_playerValueChanged);
  }
}
