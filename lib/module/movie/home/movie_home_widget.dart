import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/movie/home/movie_home_list_widget.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/utility/cz_kit/cz_router.dart';
import 'package:read_shadow/utility/router/routes.dart';

class MovieHomeWidget extends StatefulWidget {
  @override
  _MovieHomeWidgetState createState() => _MovieHomeWidgetState();
}

class _MovieHomeWidgetState extends State<MovieHomeWidget>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController tabController;

  List<Text> tabBarItems = [Text("11111"), Text("11111"), Text("11111")];

  List<Text> tabBarViews = [Text("11111"), Text("11111"), Text("11111")];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 6,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[
            Icon(Icons.business),
            GestureDetector(
              child: Container(
                height: 30,
                width: ScreenUtil().setWidth(500),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54, width: 1), //边框
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, size: 20, color: Colors.white54,),
                    Text(
                      "请输入电影名称",
                      style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.white54),
                    )
                  ],
                ),
              ),
              onTap: () {
                CZRouter.cz_push(context, Routes.movieSearch);
              },
            ),
            Icon(Icons.business)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        bottom: TabBar(
          labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          tabs: <Widget>[
            Tab(text: "推荐"),
            Tab(text: "电视剧"),
            Tab(text: "电影"),
            Tab(text: "综艺"),
            Tab(text: "动漫"),
            Tab(text: "记录片"),
          ],
          controller: tabController, // 记得要带上tabController
          onTap: (value) => {cz_print(value, StackTrace.current)},
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          MovieHomeListWidget(),
          Center(child: Text("这是推荐的内容")),
          Center(child: Text("这是关注的内容")),
          Center(child: Text("这是收藏的内容")),
          Center(child: Text("这是新增的内容")),
          Center(child: Text("这是点赞的内容"))
        ],
      ),
    );
  }
}
