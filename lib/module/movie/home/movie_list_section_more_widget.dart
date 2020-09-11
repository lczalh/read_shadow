import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieListSectionMoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "免费电影",
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
