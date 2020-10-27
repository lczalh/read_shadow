import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:read_shadow/module/category/entrance/category_entrance_model.dart';
import 'package:read_shadow/module/video/home/recommend/hot_online_dramas_cell_widget.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

class CategoryEntranceWidget extends StatefulWidget {
  @override
  _CategoryEntranceWidgetState createState() => _CategoryEntranceWidgetState();
}

class _CategoryEntranceWidgetState extends State<CategoryEntranceWidget>
    with AutomaticKeepAliveClientMixin {
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

  // 记录当前页数
  int _currentPageIndex = 0;

  /// 搜索列表数据
  List<CategoryEntranceMovieModelListModel> _movieModelList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getSearchMovieData() {
    var _currentAreaType =
        _currentAreaTypeIndex == 0 ? -1 : _areaTypes[_currentAreaTypeIndex];
    var _currentPlotType =
        _currentPlotTypeIndex == 0 ? -1 : _plotTypes[_currentPlotTypeIndex];
    var _currentOtherType = _currentOtherTypeIndex;
    var _currentVideoType = _currentVideoTypeIndex + 1;
    var _currentYearType = _currentYearTypeIndex == 0
        ? -1
        : "${_yearTypes[_currentYearTypeIndex]}-${_yearTypes[_currentYearTypeIndex]}";

    /// https://ticket-api-m.mtime.cn/search/movieFilter.api?areas=-1&genreTypes=-1&onlineFree=1&pageIndex=1&searchType=1&sortMethod=1&sortType=0&years=-1
    Map<String, dynamic> params = {
      /// 地区：-1 全部地区 其它：中国
      "areas": _currentAreaType,

      /// 剧情类型 -1所有类型 其它：恐怖
      "genreTypes": _currentPlotType,

      /// 付费类型 3所有
      "onlineFree": 3,
      "pageIndex": _currentPageIndex,

      /// 1电影 2电视剧
      "searchType": _currentVideoType,
      "sortMethod": 1,

      /// 0热度 1评分 2时间
      "sortType": _currentOtherType,

      /// -1 全部年代 其它 2019-2019
      "years": _currentYearType
    };
    print(params);
    CZNetwork()
        .get(
            baseUrl: "https://ticket-api-m.mtime.cn",
            path: "/search/movieFilter.api",
            params: params)
        .then((map) {
      CategoryEntranceModel categoryEntranceModel =
          CategoryEntranceModel.fromMap(map);
      if (_currentPageIndex == 1) {
        _movieModelList.clear();
      }
      if (categoryEntranceModel.data != null) {
        for (CategoryEntranceMovieModelListModel listModel
            in categoryEntranceModel.data.movieModelList) {
          _movieModelList.add(listModel);
        }
      } else {}

      setState(() {});
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("筛选"),
      ),
      body: extended.NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: ScreenUtil().setHeight(360),
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    VideoTypeFilterWidget(
                      currentTypeIndex: _currentVideoTypeIndex,
                      types: _videoTypes,
                      tapTypeBlock: (index) {
                        _currentVideoTypeIndex = index;
                        _currentPageIndex = 1;
                        getSearchMovieData();
                      },
                    ),
                    VideoTypeFilterWidget(
                      currentTypeIndex: _currentAreaTypeIndex,
                      types: _areaTypes,
                      tapTypeBlock: (index) {
                        _currentAreaTypeIndex = index;
                        _currentPageIndex = 1;
                        getSearchMovieData();
                      },
                    ),
                    VideoTypeFilterWidget(
                      currentTypeIndex: _currentPlotTypeIndex,
                      types: _plotTypes,
                      tapTypeBlock: (index) {
                        _currentPlotTypeIndex = index;
                        _currentPageIndex = 1;
                        getSearchMovieData();
                      },
                    ),
                    VideoTypeFilterWidget(
                      currentTypeIndex: _currentYearTypeIndex,
                      types: _yearTypes,
                      tapTypeBlock: (index) {
                        _currentYearTypeIndex = index;
                        _currentPageIndex = 1;
                        getSearchMovieData();
                      },
                    ),
                    VideoTypeFilterWidget(
                      currentTypeIndex: _currentOtherTypeIndex,
                      types: _otherTypes,
                      tapTypeBlock: (index) {
                        _currentOtherTypeIndex = index;
                        _currentPageIndex = 1;
                        getSearchMovieData();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key('EasyRefresh'),
          SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: () async {
                _currentPageIndex = 1;
                await getSearchMovieData();
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                _currentPageIndex += 1;
                await getSearchMovieData();
                _refreshController.loadComplete();
              },
              child: GridView.builder(
                padding: EdgeInsets.only(left: 10, right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: ScreenUtil().setWidth(1.1),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  var model = _movieModelList[index];
                  return GestureDetector(
                      onTap: () {
                        CZRouter.cz_push(
                            context, RoutePathRegister.videoDetails, params: {
                          "movieName": model.titleCn,
                          "movieId": model.movieId
                        });
                      },
                      child: HotOnlineDramasCellWidget(
                          movieName: model.titleCn,
                          movieImageUrl: model.img,
                          movieDirector: model.titleEn,
                          movieRating: "${model.ratingFinal}"));
                },
                itemCount: _movieModelList.length,
              )),
        ),
      ),
    );
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
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      width: ScreenUtil().screenWidth,
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
        onTap: (index) {
          widget.tapTypeBlock(index);
        },
      ),
    );
  }
}
