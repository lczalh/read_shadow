import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:read_shadow/components/loading/cz_loading_toast.dart';
import 'package:read_shadow/module/video/player/video_player_model.dart';
import 'package:read_shadow/module/video/player/video_player_operate_widget.dart';
import 'package:read_shadow/module/video/player/video_player_series_widget.dart';
import 'package:read_shadow/module/video/player/video_player_source_widget.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

enum _VideoParsingStatus {
  parsing,

  /// 解析中
  parsingSuccess,

  /// 解析成功
  parseFailure,

  /// 解析失败
}

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget(
      {Key key,
      this.videoImage,
      this.videoName,
      this.videoUrl,
      this.videoPlaySource})
      : super(key: key);

  /// 视频图片
  final String videoImage;

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
  // GlobalKey<VideoPlayerSeriesWidgetState> _videoPlayerWidgetKey = GlobalKey();

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

  final FijkPlayer _fijkPlayer = FijkPlayer();

  /// 解析状态
  _VideoParsingStatus _isParseState = _VideoParsingStatus.parsing;

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
    //  setState(() {});
    _videoPlayUrlParsing();
  }

  @override
  void dispose() {
    super.dispose();
    _fijkPlayer.release();
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
                return _allSeriesTitles.length > 0
                    ? VideoPlayerOperateWidget(
                        seriesTitles: _allSeriesTitles[_currentPlaySourceIndex],
                        seriesUrls: _allSeriesUrls[_currentPlaySourceIndex],
                        currentSeriesIndex: _currentPlaySeriesIndex,
                        firstPartBlcok: () {
                          _currentPlaySeriesIndex -= 1;
                          setState(() {});

                          /// 解析播放
                          _videoPlayUrlParsing();
                        },
                        nextPartBlock: () {
                          _currentPlaySeriesIndex += 1;
                          //  setState(() {});

                          /// 解析播放
                          _videoPlayUrlParsing();
                        },
                        interfaceBlock: () {
                          Fluttertoast.showToast(
                              msg: "此功能暂不可用",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              fontSize: ScreenUtil().setSp(26)
                          );
                        },
                        refreshBlock: () {
                          Fluttertoast.showToast(
                              msg: "此功能暂不可用",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              fontSize: ScreenUtil().setSp(26)
                          );
                        },
                        shareBlock: () {
                          Fluttertoast.showToast(
                              msg: "此功能暂不可用",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              fontSize: ScreenUtil().setSp(26)
                          );
                        },
                      )
                    : Container();
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
                          /// 解析播放
                          _videoPlayUrlParsing();
                        },
                      )
                    : Container();
              } else {
                /// 剧集
                /// 获取当前播放源的剧集
                return _allSeriesTitles.length > 0
                    ? VideoPlayerSeriesWidget(
                        // key: _videoPlayerWidgetKey,
                        seriesTitles: _allSeriesTitles[_currentPlaySourceIndex],
                        seriesUrls: _allSeriesUrls[_currentPlaySourceIndex],
                        currentSeriesIndex: _currentPlaySeriesIndex,
                        tapSeriesBlock: (index) async {
                          _currentPlaySeriesIndex = index;

                          //  setState(() {});

                          /// 解析视频播放地址
                          _videoPlayUrlParsing();
                        },
                      )
                    : Container();
              }
            },
            itemCount: 3,
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(400)),
          ),

          /// 播放器
          _isParseState == _VideoParsingStatus.parsingSuccess
              ? FijkView(
                  player: _fijkPlayer,
                  width: ScreenUtil.screenWidth,
                  height: ScreenUtil().setHeight(400),
                  fit: FijkFit.cover,
                  fsFit: FijkFit.cover,
                  // panelBuilder: (FijkPlayer player, FijkData data, BuildContext context, Size viewSize, Rect texturePos) {
                  //   return CustomFijkPanel(
                  //       player: player,
                  //       buildContext: context,
                  //       viewSize: viewSize,
                  //       texturePos: texturePos);
                  // },
                )
              : Stack(
                  children: [
                    CachedNetworkImage(
                      width: ScreenUtil.screenWidth,
                      height: ScreenUtil().setHeight(400),
                      fit: BoxFit.cover,
                      imageUrl: widget.videoImage ?? "",
                      placeholder: (context, url) => Image.asset(
                        'images/icon_placeholder_figure.png',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'images/icon_placeholder_figure.png',
                        fit: BoxFit.cover,
                      ),
                      cacheManager: DefaultCacheManager(),
                      placeholderFadeInDuration: Duration.zero,
                    ),
                    Container(
                        width: ScreenUtil.screenWidth,
                        height: ScreenUtil().setHeight(400),
                        color: Colors.black.withOpacity(0.5),
                        child: _isParseState == _VideoParsingStatus.parsing
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitFadingCube(color: Colors.white),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(40)),
                                    child: Text(
                                      "解析中，请稍后",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(26)),
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: Text(
                                  "解析失败，请更换接口",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(26)),
                                ),
                              )),
                  ],
                )
        ],
      ),
    );
  }

  /// 视频播放地址解析
  _videoPlayUrlParsing() async {
    _isParseState = _VideoParsingStatus.parsing;

    /// 重置UI
    setState(() {});

    String title =
        _allSeriesTitles[_currentPlaySourceIndex][_currentPlaySeriesIndex];
    String url =
        _allSeriesUrls[_currentPlaySourceIndex][_currentPlaySeriesIndex];

    var httpClient = new HttpClient();
    var uri = new Uri.http('user.htv009.com', '/json', {'url': url});
    try {
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        VideoPlayerModel videoPlayerModel = VideoPlayerModel.fromJson(json);
        if (videoPlayerModel.url != null &&
            videoPlayerModel.url.isEmpty == false) {
          cz_print(videoPlayerModel.url, StackTrace.current);
          _isParseState = _VideoParsingStatus.parsingSuccess;
          await _fijkPlayer.reset();
          _fijkPlayer.setDataSource(videoPlayerModel.url, autoPlay: true);
        } else {
          _isParseState = _VideoParsingStatus.parseFailure;
        }
      } else {
        _isParseState = _VideoParsingStatus.parseFailure;
      }
    } catch (exception) {
      _isParseState = _VideoParsingStatus.parseFailure;
    }

    setState(() {});
  }
}

// class CustomFijkPanel extends StatefulWidget {
//   final FijkPlayer player;
//   final BuildContext buildContext;
//   final Size viewSize;
//   final Rect texturePos;
//
//   const CustomFijkPanel({
//     @required this.player,
//     this.buildContext,
//     this.viewSize,
//     this.texturePos,
//   });
//
//   @override
//   _CustomFijkPanelState createState() => _CustomFijkPanelState();
// }
//
// class _CustomFijkPanelState extends State<CustomFijkPanel> {
//   FijkPlayer get player => widget.player;
//   bool _playing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.player.addListener(_playerValueChanged);
//   }
//
//   void _playerValueChanged() {
//     FijkValue value = player.value;
//
//     bool playing = (value.state == FijkState.started);
//     if (playing != _playing) {
//       setState(() {
//         _playing = playing;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Rect rect = Rect.fromLTRB(
//         max(0.0, widget.texturePos.left),
//         max(0.0, widget.texturePos.top),
//         min(widget.viewSize.width, widget.texturePos.right),
//         min(widget.viewSize.height, widget.texturePos.bottom));
//
//     return Positioned.fromRect(
//       rect: rect,
//       child: Container(
//         alignment: Alignment.bottomLeft,
//         child: IconButton(
//           icon: Icon(
//             _playing ? Icons.pause : Icons.play_arrow,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             _playing ? widget.player.pause() : widget.player.start();
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     player.removeListener(_playerValueChanged);
//   }
// }
