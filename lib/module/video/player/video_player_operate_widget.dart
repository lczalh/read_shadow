
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoPlayerOperateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: ScreenUtil().setHeight(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: (ScreenUtil.screenWidth - 60) / 5,
            height: ScreenUtil().setHeight(60),
            color: Theme.of(context).accentColor,
            child: Text(
              '接口',
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
            ),
            alignment: Alignment.center,
            //Text('111',style: TextStyle(color:  Colors.white),),
          ),
          Container(
            width: (ScreenUtil.screenWidth - 60) / 5,
            height: ScreenUtil().setHeight(60),
            color: Theme.of(context).accentColor,
            child: Text(
              '刷新',
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
            ),
            alignment: Alignment.center,
            //Text('111',style: TextStyle(color:  Colors.white),),
          ),
          Container(
            width: (ScreenUtil.screenWidth - 60) / 5,
            height: ScreenUtil().setHeight(60),
            color: Theme.of(context).accentColor,
            child: Text(
              '分享',
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
            ),
            alignment: Alignment.center,
            //Text('111',style: TextStyle(color:  Colors.white),),
          ),
          Container(
            width: (ScreenUtil.screenWidth - 60) / 5,
            height: ScreenUtil().setHeight(60),
            color: Theme.of(context).accentColor,
            child: Text(
              '上集',
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
            ),
            alignment: Alignment.center,
            //Text('111',style: TextStyle(color:  Colors.white),),
          ),
          Container(
            width: (ScreenUtil.screenWidth - 60) / 5,
            height: ScreenUtil().setHeight(60),
            color: Theme.of(context).accentColor,
            child: Text(
              '下集',
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
            ),
            alignment: Alignment.center,
            //Text('111',style: TextStyle(color:  Colors.white),),
          ),
        ],
      ),
    );
  }
}