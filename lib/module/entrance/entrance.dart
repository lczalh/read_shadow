import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/category/entrance/category_entrance_widget.dart';
import 'package:read_shadow/module/video/home/entrance/movie_home_widget.dart';

class Entrance extends StatefulWidget {
  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {

  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    screenUtilConfig(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MovieHomeWidget(),
          CategoryEntranceWidget(),
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
              Icons.home,
              color: Colors.black26,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              "首页",
              style: TextStyle(
                color: _currentIndex == 0 ? Theme.of(context).accentColor : Colors.black26
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
              color: Colors.black26,
            ),
            activeIcon: Icon(
              Icons.category,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              "筛选",
              style: TextStyle(
                  color: _currentIndex == 1 ? Theme.of(context).accentColor : Colors.black26
              ),
            ),
          ),
        ],
      ),
    );
  }

   // ScreenUtil配置
  void screenUtilConfig(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
    //ScreenUtil.init(context)
    //ScreenUtil.init(context, width: 750, height: 1334);
  }

}
