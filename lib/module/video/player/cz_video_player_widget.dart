import 'dart:async';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:video_player/video_player.dart';

class CZVideoPlayerWidget extends StatefulWidget {

  CZVideoPlayerWidget({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _CZVideoPlayerWidgetState createState() => _CZVideoPlayerWidgetState();
}

class _CZVideoPlayerWidgetState extends State<CZVideoPlayerWidget> {

  /// 播放器控制器
  VideoPlayerController _videoPlayerController;

  // 记录播放控件ui是否显示(进度条，播放按钮，全屏按钮等等)
  Timer _timer; // 计时器，用于延迟隐藏控件ui
  bool _hidePlayControl = true; // 控制是否隐藏控件ui
  double _playControlOpacity = 0; // 通过透明度动画显示/隐藏控件ui

  /// 记录是否全屏
  bool get _isFullScreen => MediaQuery.of(context).orientation == Orientation.landscape;

  /// 当前播放时间
  Duration _currentPlayerTime = Duration(seconds: 0);

  /// 总播放时间
  Duration _totalPlayerTime = Duration(seconds: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cz_print("initState", StackTrace.current);
    /// 'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4'
    _videoPlayerController = VideoPlayerController.network(widget.url,);
    _videoPlayerController.addListener(listener);
    _videoPlayerController.initialize();
  }

  listener() {
    /// 获取当前播放时间
    if (_videoPlayerController.value.position != null) {
      _currentPlayerTime = _videoPlayerController.value.position;
    }
    /// 获取总时间
    if (_videoPlayerController.value.duration != null) {
      _totalPlayerTime = _videoPlayerController.value.duration;
    }
    setState(() {

    });
  }

  /// 视频时间格式转换
  String videoTimeFormatConversion(Duration time) {
    List<String> _currentPlayeTimes = "$time".split(".").first.split(":");
    return int.parse(_currentPlayeTimes.first) > 0 ? "${_currentPlayeTimes[0]}:${_currentPlayeTimes[1]}:${_currentPlayeTimes[2]}" : "${_currentPlayeTimes[1]}:${_currentPlayeTimes[2]}";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.removeListener(listener);
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: !_isFullScreen ? ScreenUtil.screenWidth : ScreenUtil.screenWidth,
      height: !_isFullScreen
          ? ScreenUtil().setHeight(400)
          : ScreenUtil.screenHeight,
      color: Colors.red,
      child: GestureDetector(
        child: Stack(
          children: [
            VideoPlayer(_videoPlayerController),
            CZVideoPlayerBottomWidget(),
          ],
        ),
        onTap: () {
          _tapHiddenDisplayController();
        },
      )
    );
  }

  resetVideoPlayerController() {
    //_videoPlayerController.pause();
    //_videoPlayerController.dispose();
    _videoPlayerController = VideoPlayerController.network(
      'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4',
      //closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _videoPlayerController.initialize();
  }

  /// 隐藏 / 显示控制UI
  void _tapHiddenDisplayController() {
    setState(() {
      if (_hidePlayControl) { // 如果隐藏则显示
        _hidePlayControl = false;
        _playControlOpacity = 1;
        _startPlayControlTimer(); // 开始计时器，计时后隐藏
      } else { // 如果显示就隐藏
        if (_timer!=null) _timer.cancel(); // 有计时器先移除计时器
        _playControlOpacity = 0;
        Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
          _hidePlayControl = true; // 延迟300ms(透明度动画结束)后，隐藏
        });
      }
    });
  }

  /// 视频全屏
  void _videoFullScreen() {
    setState(() {
      if (_isFullScreen) {
        /// 竖屏
        AutoOrientation.portraitUpMode();
        ///显示状态栏，与底部虚拟操作按钮
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      } else {
        /// 横屏
        AutoOrientation.landscapeRightMode();
        ///关闭状态栏，与底部虚拟操作按钮
        SystemChrome.setEnabledSystemUIOverlays([]);
      }
       _startPlayControlTimer(); // 操作完控件开始计时隐藏
    });
  }

  void _startPlayControlTimer() {
    if (_timer != null) _timer.cancel();
    _timer = Timer(Duration(seconds: 3), () {
      /// 延迟3s后隐藏
      setState(() {
        _playControlOpacity = 0;
        Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
          _hidePlayControl = true;
        });
      });
    });
  }

  // ignore: non_constant_identifier_names
  Widget CZVideoPlayerBottomWidget() {
    return Positioned(
      // 需要定位
      left: 0,
      bottom: 0,
      child: Offstage(
        // 控制是否隐藏
        offstage: _hidePlayControl,
        child: AnimatedOpacity(
          // 加入透明度动画
          opacity: _playControlOpacity,
          duration: Duration(milliseconds: 300),
          child: Container(
              // 底部控件的容器
              width: ScreenUtil.screenWidth,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // 来点黑色到透明的渐变优雅一下
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, .7),
                    Color.fromRGBO(0, 0, 0, .01)
                  ],
                ),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// 播放时间 / 总时间
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // 播放时间
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          // durationToTime是通过Duration转成hh:mm:ss的格式，自己实现。
                          videoTimeFormatConversion(_currentPlayerTime),
                          //durationToTime(_position)+'/'+durationToTime(_controller.value.duration),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        // 播放时间
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          // durationToTime是通过Duration转成hh:mm:ss的格式，自己实现。
                          videoTimeFormatConversion(_totalPlayerTime),
                          //durationToTime(_position)+'/'+durationToTime(_controller.value.duration),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child:  VideoProgressIndicator(
                      // 嘻嘻，这是video_player编写好的进度条，直接用就是了~~
                      _videoPlayerController,
                      allowScrubbing: true, // 允许手势操作进度条
                      padding: EdgeInsets.all(0),
                      colors: VideoProgressColors(
                        // 配置进度条颜色，也是video_player现成的，直接用
                        playedColor: Theme.of(context).primaryColor,
                        // 已播放的颜色
                        bufferedColor: Color.fromRGBO(255, 255, 255, .5),
                        // 缓存中的颜色
                        backgroundColor:
                        Color.fromRGBO(255, 255, 255, .2), // 为缓存的颜色
                      )),
                  ),
                  Row(
                    // 加载完成时才渲染,flex布局
                    children: <Widget>[
                      Container(
                        // 播放时间
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: GestureDetector(
                          child: Icon(
                            // 根据控制器动态变化播放图标还是暂停
                            _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() { // 同样的，点击动态播放或者暂停
                              _videoPlayerController.value.isPlaying
                                  ? _videoPlayerController.pause()
                                  : _videoPlayerController.play();
                              _startPlayControlTimer(); // 操作控件后，重置延迟隐藏控件的timer
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: Container(),
                        // 相当于前端的flex: 1
                        // child:
                        // VideoProgressIndicator(
                        //   // 嘻嘻，这是video_player编写好的进度条，直接用就是了~~
                        //   _videoPlayerController,
                        //   allowScrubbing: true, // 允许手势操作进度条
                        //   padding: EdgeInsets.all(0),
                        //   colors: VideoProgressColors(
                        //     // 配置进度条颜色，也是video_player现成的，直接用
                        //     playedColor: Theme.of(context).primaryColor,
                        //     // 已播放的颜色
                        //     bufferedColor: Color.fromRGBO(255, 255, 255, .5),
                        //     // 缓存中的颜色
                        //     backgroundColor:
                        //     Color.fromRGBO(255, 255, 255, .2), // 为缓存的颜色
                        //   ),
                        // ),
                      ),
                      // Container(
                      //   // 播放时间
                      //   margin: EdgeInsets.only(left: 10),
                      //   child: Text(
                      //     // durationToTime是通过Duration转成hh:mm:ss的格式，自己实现。
                      //     "倍速",
                      //     //durationToTime(_position)+'/'+durationToTime(_controller.value.duration),
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        child: GestureDetector(
                          child: Icon(
                            // 根据当前屏幕方向切换图标
                            _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                            color: Colors.white,
                          ),
                          onTap: () {
                            // 点击切换是否全屏
                            _videoFullScreen();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
