import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoPlayerSourceWidget extends StatefulWidget {
  @override
  _VideoPlayerSourceWidget createState() => _VideoPlayerSourceWidget();
}

class _VideoPlayerSourceWidget extends State<VideoPlayerSourceWidget> {
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
              return Container(
                margin: EdgeInsets.only(left: 10),
                width: (ScreenUtil.screenWidth - 60) / 5,
                color: Theme.of(context).accentColor,
                child: Text(
                  '腾讯视频',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                ),
                alignment: Alignment.center,
                //Text('111',style: TextStyle(color:  Colors.white),),
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: 5,
          ),
        )
      ],
    );
  }
}
