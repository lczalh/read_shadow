import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

class CZVideoPlayerWidget extends StatefulWidget {
  CZVideoPlayerWidget(
      {Key key,
      @required this.movieTitle,
      @required this.movieUrl,
      this.coverImageUrl,
      this.playBackBlock,
        this.playDidEndBlock,
      })
      : super(key: key);

  /// 电影名称
  final String movieTitle;

  /// 电影地址
  final String movieUrl;

  /// 封面图地址
  final String coverImageUrl;

  /// 返回按钮事件
  final Function playBackBlock;

  /// 播放结束事件
  final Function playDidEndBlock;

  @override
  _CZVideoPlayerWidgetState createState() => _CZVideoPlayerWidgetState();
}

class _CZVideoPlayerWidgetState extends State<CZVideoPlayerWidget> {
  // 注册一个通知, 传值 / 调用 / 获取  Flutter 主动向 iOS 调用
  static const MethodChannel _methodChannel =
      MethodChannel("cz_video_player/method_channel");

  // 注册一个通知, 传值 / 调用 / 获取  iOS 主动向 Flutter 调用
  static const eventChannel = EventChannel('cz_video_player/event_channel');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 监听 iOS 传递过来的值
    eventChannel
        .receiveBroadcastStream()
        .listen(_eventChannelSucceed);

  }

  @override
  Widget build(BuildContext context) {
    // 传递视频相关信息
    _methodChannel.invokeMethod("movieInfoIdentifier",
        {"movieTitle": widget.movieTitle, "movieUrl": widget.movieUrl});

    if (Platform.isAndroid) {
      ///加载安卓原生视图
      return Text('这个平台老子不支持');
    } else if (Platform.isIOS) {
      return UiKitView(
        creationParams: <String, String>{
          "movieTitle": widget.movieTitle,
          "movieUrl": widget.movieUrl,
        },
        creationParamsCodec: const StandardMessageCodec(),
        viewType: "CZVideoPlayerViewFactory",
      );
    } else {
      return Text('这个平台老子不支持');
    }

  }

  // 播放视图上的返回按事件
  void _eventChannelSucceed(dynamic data) {
    String type = data["type"];
    if (type == "superPlayerBackAction") { // 点击了返回按钮
      widget.playBackBlock();
    } else if (type == "superPlayerDidEnd") { // 视频播放结束
      widget.playDidEndBlock();
    }

  }

}
