import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/video/player/cz_video_player_widget.dart';
import 'package:read_shadow/module/video/player/video_player_operate_widget.dart';
import 'package:read_shadow/module/video/player/video_player_series_widget.dart';
import 'package:read_shadow/module/video/player/video_player_source_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  @override
  _VideoPlayerWidget createState() => _VideoPlayerWidget();
}

class _VideoPlayerWidget extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("视频播放"),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) { /// 常用操作
                  return VideoPlayerOperateWidget();
                } else if (index == 1) { /// 播放源
                  return VideoPlayerSourceWidget();
                } else { /// 剧集
                  return VideoPlayerSeriesWidget();
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
        ));
  }
}
