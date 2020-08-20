import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/mine/mine_home_widget.dart';
import 'package:read_shadow/module/movie/home/movie_home_widget.dart';

class Entrance extends StatefulWidget {
  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  @override
  Widget build(BuildContext context) {
    screenUtilConfig(context);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(title: Text("电影"), icon: Icon(Icons.menu)),
          BottomNavigationBarItem(
              title: Text("我的"), icon: Icon(Icons.business)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return MovieHomeWidget();
          case 1:
            return MineHomeWidget();
        }
      },
    );
  }

   // ScreenUtil配置
  void screenUtilConfig(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
  }

}
