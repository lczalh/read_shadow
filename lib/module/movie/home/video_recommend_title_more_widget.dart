import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoRecommendTitleMoreWidget extends StatefulWidget {

  VideoRecommendTitleMoreWidget({Key key, this.title}) : super(key: key);

  /// 标题
  final String title;


  _VideoRecommendTitleMoreWidgetState createState() => _VideoRecommendTitleMoreWidgetState();
}

class _VideoRecommendTitleMoreWidgetState extends State<VideoRecommendTitleMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "更多",
              style: TextStyle(fontSize: ScreenUtil().setSp(26)),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: ScreenUtil().setWidth(40),
            ),
          ],
        )
      ],
    );
  }
}
