import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/video/home/piece_single/video_piece_single_widget.dart';
import 'package:read_shadow/module/video/home/recommend/video_recommend_widget.dart';
import 'package:read_shadow/module/video/home/widget/movie_home_list_widget.dart';
import 'package:read_shadow/router/route_path_register.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/router/cz_router.dart';

class MovieHomeWidget extends StatefulWidget {
  @override
  _MovieHomeWidgetState createState() => _MovieHomeWidgetState();
}

class _MovieHomeWidgetState extends State<MovieHomeWidget>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.business),
            GestureDetector(
              child: Container(
                height: 30,
                width: ScreenUtil().setWidth(500),
                decoration: BoxDecoration(
                  border: Border.all( width: 1), //边框
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, size: 20),
                    Text(
                      "请输入电影名称",
                      style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                    )
                  ],
                ),
              ),
              onTap: () {
                CZRouter.cz_push(context, RoutePathRegister.movieSearch);
              },
            ),
            Icon(Icons.business)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
//        bottom:
      ),
      body: Column(
        children: [
          Container(
            height: 44,
            child: TabBar(
              labelColor: Colors.red,
              labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              tabs: <Widget>[
                Tab(text: "推荐"),
                Tab(text: "小编强推"),
                Tab(text: "明星推荐"),
                Tab(text: "追剧向导"),
                Tab(text: "时光热榜"),
                //Tab(text: "记录片"),
              ],
              controller: tabController, // 记得要带上tabController
              onTap: (value) => {cz_print(value, StackTrace.current)},
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                VideoRecommendWidget(),
                VideoPieceSingleWidget(channelId: 1,),
                //MovieHomeListWidget(categoryId: "12"),
                MovieHomeListWidget(categoryId: "5"),
                MovieHomeListWidget(categoryId: "3"),
                MovieHomeListWidget(categoryId: "4"),
               // MovieHomeListWidget(categoryId: "18"),
              ],
            ),
          )
        ],
      )
    );
  }
}
