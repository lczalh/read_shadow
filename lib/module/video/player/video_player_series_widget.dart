import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoPlayerSeriesWidget extends StatefulWidget {
  @override
  _VideoPlayerSeriesWidget createState() => _VideoPlayerSeriesWidget();
}

class _VideoPlayerSeriesWidget extends State<VideoPlayerSeriesWidget> {
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
              "剧集与更新",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
          ),
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              color: Colors.primaries[index % Colors.primaries.length],
            );
          },
          itemCount: 50,
        )
      ],
    );
  }
}