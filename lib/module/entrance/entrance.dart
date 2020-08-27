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

  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;

  // 默认颜色
  Color _defaultColor = Colors.yellow;
  // 选中颜色
  Color _activeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    screenUtilConfig(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          MovieHomeWidget(),
          MineHomeWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_alarms,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.ac_unit,
              color: _activeColor,
            ),
            title: Text(
              "电影",
              style: TextStyle(
                color: _currentIndex == 0 ? _activeColor : _defaultColor
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessible_forward,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.account_balance,
              color: _activeColor,
            ),
            title: Text(
              "我的",
              style: TextStyle(
                  color: _currentIndex == 1 ? _activeColor : _defaultColor
              ),
            ),
          ),
        ],
      ),
    );
//    return CupertinoTabScaffold(
//      tabBar: CupertinoTabBar(
//        items: [
//          BottomNavigationBarItem(title: Text("电影"), icon: Icon(Icons.menu)),
//          BottomNavigationBarItem(
//              title: Text("我的"), icon: Icon(Icons.business)),
//        ],
//      ),
//      tabBuilder: (BuildContext context, int index) {
//        switch (index) {
//          case 0:
//            return MovieHomeWidget();
//          case 1:
//            return MineHomeWidget();
//        }
//      },
//    );
  }

   // ScreenUtil配置
  void screenUtilConfig(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
  }

}
