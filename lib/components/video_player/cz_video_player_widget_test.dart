import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

class CZSuperPlayerController {

  /// 注册一个通知, 传值 / 调用 / 获取  Flutter 主动向 iOS 调用
  static const MethodChannel _methodChannel = MethodChannel("cz_video_player/method_channel");

  /// 注册一个通知, 传值 / 调用 / 获取  iOS 主动向 Flutter 调用
  static const EventChannel _eventChannel = EventChannel('cz_video_player/event_channel');

  /// 初始化
  CZSuperPlayerController.initialize() {
    /// 监听 iOS 传递过来的值
    _eventChannel
        .receiveBroadcastStream()
        .listen(_eventChannelSucceed);
  }

  /// 返回按钮事件
  Function playBackBlock;

  /// 监听 iOS 传递过来的值
  void _eventChannelSucceed(dynamic data) {
    String type = data["type"];
    if (type == "superPlayerBackAction") { // 点击了返回按钮
      playBackBlock();
    } else if (type == "superPlayerDidEnd") { // 视频播放结束
      //widget.playDidEndBlock();
    }
  }

  /// 设置标题
  void setTitle(String title) {
    _methodChannel.invokeMethod("setTitle",
        {"title": title});
  }

  /// 播放
  void play(String url) {
    _methodChannel.invokeMethod("play",
        {"url": url});
  }

  /// 暂停播放
  void pause() {
    _methodChannel.invokeMethod("pause");
  }

}

class CZVideoPlayerWidgetTest extends StatefulWidget {

  CZVideoPlayerWidgetTest(
      {Key key})
      : super(key: key);

  @override
  _CZVideoPlayerWidgetTestState createState() => _CZVideoPlayerWidgetTestState();
}

class _CZVideoPlayerWidgetTestState extends State<CZVideoPlayerWidgetTest> {

  /// 获取当前屏幕是否横屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid == true ? AndroidView(viewType: 'CZVideoPlayerViewFactory') : Platform.isIOS == true ? UiKitView(viewType: "CZVideoPlayerViewFactory",) : Container();
  }



}
