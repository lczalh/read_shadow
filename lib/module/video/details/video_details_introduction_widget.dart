import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoDetailsIntroductionWidget extends StatefulWidget {

  VideoDetailsIntroductionWidget({Key key, this.movieIntroduction}) : super(key: key);

  final String movieIntroduction;

  @override
  _VideoDetailsIntroductionWidgetState createState() => _VideoDetailsIntroductionWidgetState();
}

class _VideoDetailsIntroductionWidgetState extends State<VideoDetailsIntroductionWidget> {

  bool _isSpread = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          height: ScreenUtil().setHeight(50),
          child: Text(
            "简介",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: Text(
          widget.movieIntroduction,
          style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
          overflow: TextOverflow.ellipsis,
          maxLines: _isSpread == false ? 4 : 9999,
        ),
      ),
      Container(
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(40),
          child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSpread == false ? '显示全部' : '隐藏部分',
                  style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                ),
                Icon(
                  _isSpread == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  color: Colors.white,
                )
              ],
            ),
            onTap: (){
              _isSpread = !_isSpread;
              setState(() { });
            },
          )
      )
    ]);
  }
}
