import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/network/cz_network.dart';

class CategoryEntranceWidget extends StatefulWidget {
  @override
  _CategoryEntranceWidgetState createState() => _CategoryEntranceWidgetState();
}

class _CategoryEntranceWidgetState extends State<CategoryEntranceWidget> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  /// 视频类型
  List<String> _videoTypes = ["电影", "电视剧"];

  /// 当前视频类型索引
  int _currentVideoTypeIndex = 0;

  /// 地区类型
  List<String> _areaTypes = [
    "全部地区",
    "中国",
    "美国",
    "中国香港",
    "中国台湾",
    "韩国",
    "日本",
    "法国",
    "意大利",
    "西班牙",
    "德国",
    "俄罗斯",
    "澳大利亚",
    "印度",
    "泰国",
    "加拿大",
    "英国",
    "墨西哥",
    "波兰",
    "巴西",
    "阿根廷",
    "丹麦",
    "奥地利",
    "荷兰",
    "芬兰",
    "冰岛",
    "瑞典",
    "比利时",
    "葡萄牙",
    "瑞士",
    "伊朗"
  ];

  /// 当前地区类型索引
  int _currentAreaTypeIndex = 0;

  /// 剧情类型
  List<String> _plotTypes = [
    "全部类型",
    "剧情",
    "爱情",
    "喜剧",
    "科幻",
    "战争",
    "动作",
    "惊悚",
    "动画",
    "恐怖",
    "犯罪",
    "冒险",
    "家庭",
    "悬疑",
    "奇幻",
    "传记",
    "记录片",
    "音乐",
    "歌舞",
    "历史",
    "西部",
    "运动",
    "古装",
    "短片",
    "武侠",
    "戏曲",
    "黑色电影",
    "舞台艺术",
    "真人秀",
    "情色"
  ];

  /// 当前剧情类型索引
  int _currentPlotTypeIndex = 0;

  /// 年代类型
  List<String> _yearTypes = [
    "全部年代",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
    "2009",
    "2008",
    "2007",
    "2006",
    "2005",
    "2004",
    "2003",
    "2002",
    "2001",
    "2000",
    "1999",
    "1998",
    "1997",
    "1996",
    "1995",
    "1994",
    "1993",
    "1992",
    "90年代"
  ];

  /// 当前年代类型索引
  int _currentYearTypeIndex = 0;

  /// 其它类型
  List<String> _otherTypes = ["热度", "评分", "时间"];

  /// 当前其它类型索引
  int _currentOtherTypeIndex = 0;

  var _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getRecommendMovieData();
  }

  getRecommendMovieData() async {
    return await CZNetwork().get(
        baseUrl: "https://ticket-api-m.mtime.cn",
        path: "/search/movieFilter.api");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("筛选"),
        ),
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            var widget;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                widget = _loadingErrorWidget();
              } else {
                widget = _dataWidget(snapshot.data);
              }
            } else {
              widget = _loadingWidget();
            }
            return widget;
          },
        )
    );
  }

  _loadingWidget() {
    return Center(
        child: SpinKitFadingCube(
          color: Theme.of(context).accentColor,
        ));
  }

  _loadingErrorWidget() {
    return Center(
      child: Text('数据加载失败，请重试。'),
    );
  }

  _dataWidget(data) {
    return NestedScrollView(
        headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: ScreenUtil().setHeight(350),
              flexibleSpace: Column(
                children: [
                  VideoTypeFilterWidget(
                    currentTypeIndex: _currentVideoTypeIndex,
                    types: _videoTypes,
                    tapTypeBlock: (index) {
                      _currentVideoTypeIndex = index;
                      setState(() {});
                    },
                  ),
                  VideoTypeFilterWidget(
                    currentTypeIndex: _currentAreaTypeIndex,
                    types: _areaTypes,
                    tapTypeBlock: (index) {
                      _currentAreaTypeIndex = index;
                      setState(() {});
                    },
                  ),
                  VideoTypeFilterWidget(
                    currentTypeIndex: _currentPlotTypeIndex,
                    types: _plotTypes,
                    tapTypeBlock: (index) {
                      _currentPlotTypeIndex = index;
                      setState(() {});
                    },
                  ),
                  VideoTypeFilterWidget(
                    currentTypeIndex: _currentYearTypeIndex,
                    types: _yearTypes,
                    tapTypeBlock: (index) {
                      _currentYearTypeIndex = index;
                      setState(() {});
                    },
                  ),
                  //
                  VideoTypeFilterWidget(
                    currentTypeIndex: _currentOtherTypeIndex,
                    types: _otherTypes,
                    tapTypeBlock: (index) {
                      _currentOtherTypeIndex = index;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ];
        },
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              color: Colors.primaries[index % Colors.primaries.length],
            );
          },
          itemCount: 50,
        ));
  }
}

/// 类型筛选视图
class VideoTypeFilterWidget extends StatefulWidget {
  VideoTypeFilterWidget(
      {Key key, this.currentTypeIndex, this.types, this.tapTypeBlock})
      : super(key: key);

  final int currentTypeIndex;

  /// 类型数据
  final List<String> types;

  /// 点击类型的回调
  final Function(int) tapTypeBlock;

  @override
  _VideoTypeFilterWidgetState createState() => _VideoTypeFilterWidgetState();
}

class _VideoTypeFilterWidgetState extends State<VideoTypeFilterWidget> {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: widget.types.length,
      vsync: ScrollableState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        width: ScreenUtil.screenWidth,
        height: ScreenUtil().setHeight(70),
        child: TabBar(
          controller: _controller,
          isScrollable: true,
          labelColor: Theme.of(context).accentColor,
          labelStyle: TextStyle(fontSize: ScreenUtil().setSp(26)),
          unselectedLabelColor: Colors.black26,
          tabs: widget.types.map((text) {
            return Text(text);
          }).toList(),
          indicator: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setHeight(35))),
            border: Border.all(color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );

    //   Container(
    //   // alignment: Alignment.center,
    //   width: ScreenUtil.screenWidth,
    //  height: ScreenUtil().setHeight(70),
    //   child: ListView.builder(
    //     itemBuilder: (BuildContext context, int index) {
    //       String type = types[index];
    //       return GestureDetector(
    //         child: Container(
    //           alignment: Alignment.center,
    //           margin: EdgeInsets.only(left: 10, top: 10),
    //           width: ScreenUtil().setWidth(120),
    //           height: ScreenUtil().setHeight(70),
    //           //  color: Colors.yellow,
    //           child: Text(
    //             type,
    //             style: TextStyle(
    //                 color: currentTypeIndex == index ? Theme.of(context).accentColor : Colors.black26, fontSize: ScreenUtil().setSp(26)),
    //             maxLines: 1,
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(
    //                 Radius.circular(ScreenUtil().setHeight(35))),
    //             border: Border.all(color: currentTypeIndex == index ? Theme.of(context).accentColor : Colors.transparent),
    //           ),
    //         ),
    //         onTap: () {
    //           tapTypeBlock(index);
    //         },
    //       );
    //     },
    //     scrollDirection: Axis.horizontal,
    //     itemCount: types.length,
    //   ),
    // );
  }
}
