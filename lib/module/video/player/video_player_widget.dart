import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cdnbye/cdnbye.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:share/share.dart';

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

  /// 当前接口索引
  int _currentInterfaceIndex = 0;

  final FijkPlayer _fijkPlayer = FijkPlayer();

  StreamSubscription _currentPosSubs;

  Duration _currentPos;

  /// 解析状态
  _VideoParsingStatus _isParseState = _VideoParsingStatus.parsing;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    // Init p2p engine
    _initEngine();
    Future.delayed(Duration(seconds: 1), () {
      Future(() => _videoPlaySourceParsing())
          .then((value) => _videoUrlParsing());
    });

    _fijkPlayer.addListener(_fijkValueListener);

    ///
    _currentPosSubs = _fijkPlayer.onCurrentPosUpdate.listen((currentPlayTime) {
      cz_print(_fijkPlayer.value.duration, StackTrace.current);
      cz_print(currentPlayTime, StackTrace.current);
      /// 当前时间等于总时间则播放完成
      if (currentPlayTime > Duration(seconds: 1) && _fijkPlayer.value.duration > Duration(seconds: 1) && currentPlayTime == _fijkPlayer.value.duration) {
        /// 若当前是全屏状态 则关闭全屏
        if (_fijkPlayer.value.fullScreen == true) {
          _fijkPlayer.exitFullScreen();
        }
        /// 自动解析下一级
        if (_currentPlaySeriesIndex < _allSeriesTitles[_currentPlaySourceIndex].length - 1) {
          _currentPlaySeriesIndex += 1;
          _videoPlayUrlParsing();
        }
      }
    });
  }

  /// 监听播放状态
  void _fijkValueListener() {
    // FijkValue fijkValue = _fijkPlayer.value;
    // cz_print(fijkValue.completed, StackTrace.current);
    // cz_print(fijkValue.fullScreen, StackTrace.current);
    // if (fijkValue.completed == true) {
    //   if (fijkValue.fullScreen == true) {
    //     _fijkPlayer.exitFullScreen();
    //   }
    // }

    // double width = _vWidth;
    // double height = _vHeight;
    //
    // if (value.prepared) {
    //   width = value.size.width;
    //   height = value.size.height;
    // }
    //
    // if (width != _vWidth || height != _vHeight) {
    //   setState(() {
    //     _vWidth = width;
    //     _vHeight = height;
    //   });
    // }
  }

  _initEngine() async {
    await Cdnbye.init(
        "xsspVPvMg",
        config: P2pConfig.byDefault()
    );
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
    _currentPosSubs?.cancel();
    _fijkPlayer.removeListener(_fijkValueListener);
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
                        currentInterfaceIndex: _currentInterfaceIndex,
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
                        interfaceBlock: (index) {
                          _currentInterfaceIndex = index;
                          _videoPlayUrlParsing();
                        },
                        refreshBlock: () {
                          _videoPlayUrlParsing();
                        },
                        shareBlock: () {
                          Share.share(
                              'http://movie.letaoshijie.com/letaoshijie.apk');
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
                        'assets/images/icon_placeholder_figure.png',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/icon_placeholder_figure.png',
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

    /// 重置播放器
    await _fijkPlayer.reset();

    /// 重置UI
    setState(() {});

    String baseUrl;
    String path;
    if (_currentInterfaceIndex == 0) {
      baseUrl = "json.itono.cn";
      path = "/";
    } else if (_currentInterfaceIndex == 1) {
      baseUrl = "user.htv009.com";
      path = "/json";
    } else if (_currentInterfaceIndex == 2) {
      baseUrl = "js.voooe.cn";
      path = "/1787799317json";
    }

    String title =
        _allSeriesTitles[_currentPlaySourceIndex][_currentPlaySeriesIndex];
    String url =
        _allSeriesUrls[_currentPlaySourceIndex][_currentPlaySeriesIndex];

    var httpClient = new HttpClient();
    var uri = new Uri.http(baseUrl, path, {'url': url});
    try {
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var playJson = await response.transform(utf8.decoder).join();
        Map<String, dynamic> playMap = json.decode(playJson);
        var playUrl = playMap["url"];
        if (playUrl != null && playUrl.isEmpty == false) {
          var cdnUrl = await Cdnbye.parseStreamURL(playUrl);
          cz_print(cdnUrl, StackTrace.current);
          _isParseState = _VideoParsingStatus.parsingSuccess;
          _fijkPlayer.setDataSource(cdnUrl, autoPlay: true);
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

  StreamSubscription _currentPlayTimePosSubs;
  String _currentPlayTime;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_playerValueChanged);
    /// 监听当前播放时间
    _currentPlayTimePosSubs = widget.player.onCurrentPosUpdate.listen((currentPlayTime) {
      List<String> parts = currentPlayTime.toString().split(":");
      _currentPlayTime = "${parts[0]}:${parts[1]}:${parts[1].split(":").first}";
      setState(() {});
    });
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
        color: Colors.red,
        alignment: Alignment.bottomLeft,
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          height: ScreenUtil().setHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _playing ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  _playing ? widget.player.pause() : widget.player.start();
                },
              ),
              Text(_currentPlayTime),
              Slider(
                value: 0,
                onChanged: (v){
                },
              ),
              Text("00:00", style: TextStyle(
                backgroundColor: Colors.purple
              ),),
              IconButton(
                icon: Icon(
                  Icons.fullscreen,
                  //_playing ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  // _playing ? widget.player.pause() : widget.player.start();
                },
              ),
            ],
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.removeListener(_playerValueChanged);
  }
}
