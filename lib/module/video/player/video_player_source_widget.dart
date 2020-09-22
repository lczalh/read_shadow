import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoPlayerSourceWidget extends StatefulWidget {

  VideoPlayerSourceWidget({Key key, this.allVideoPlaySources, this.tapPlaySourceBlock}) : super(key: key);

  /// 所有视频播放源
  final List<String> allVideoPlaySources;

  /// 点击播放源回调
  final Function(int) tapPlaySourceBlock;

  @override
  _VideoPlayerSourceWidget createState() => _VideoPlayerSourceWidget();
}

class _VideoPlayerSourceWidget extends State<VideoPlayerSourceWidget> {

  int _currentPlaySourceIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: <Color>[
                  Colors.blue,
                  Colors.purple,
                  Colors.red,
                  Colors.pinkAccent,
                  Colors.orange
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Text(
              "播放源",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(60),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              String videoPlaySource = widget.allVideoPlaySources[index];
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  width: (ScreenUtil.screenWidth - 60) / 5,
                  color: _currentPlaySourceIndex == index ? Theme.of(context).accentColor : Theme.of(context).accentColor.withOpacity(0.5),
                  child: Text(
                    videoPlaySource,
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                  ),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  _currentPlaySourceIndex = index;
                  setState(() {});
                  widget.tapPlaySourceBlock(_currentPlaySourceIndex);
                },
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: widget.allVideoPlaySources.length,
          ),
        )
      ],
    );
  }
}
