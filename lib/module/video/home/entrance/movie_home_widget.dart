import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:read_shadow/macro/read_shadow_macro.dart';
import 'package:read_shadow/module/video/home/entrance/read_shadow_update_model.dart';
import 'package:read_shadow/module/video/home/piece_single/video_piece_single_widget.dart';
import 'package:read_shadow/module/video/home/recommend/video_recommend_widget.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/route_path_register.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/router/cz_router.dart';

class MovieHomeWidget extends StatefulWidget {
  @override
  _MovieHomeWidgetState createState() => _MovieHomeWidgetState();
}

class _MovieHomeWidgetState extends State<MovieHomeWidget>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin, WidgetsBindingObserver {
  TabController tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// 应用从后台进入
    if (state == AppLifecycleState.resumed) {
      // InterstitialAd _interstitial = InterstitialAd(
      //   adUnitId: getInsertAdsId(),
      //   listener: (MobileAdEvent event) {
      //     print("InterstitialAd event is $event");
      //   },
      // );
      // _interstitial
      //   ..load()
      //   ..show(
      //     anchorType: AnchorType.bottom,
      //     anchorOffset: 0.0,
      //     horizontalCenterOffset: 0.0,
      //   );
    }
  }

  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   _getAPPUpdateState();
    //   /// 检查APP更新
    //   AppUpgrade.appUpgrade(
    //     context,
    //     _getAPPUpdateState(),
    //     iosAppId: '',
    //     progressBarColor: Colors.red
    //   );
    // }
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  void dispose() {
    super.dispose();
    tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // Future<AppUpgradeInfo> _getAPPUpdateState() async {
  //   var appUpdateJson =  await CZNetwork().get(baseUrl: "https://movie.letaoshijie.com", path: "/appUpdate.json");
  //   if (appUpdateJson != null) {
  //     ReadShadowUpdateModel readShadowUpdateModel = ReadShadowUpdateModel.fromMap(appUpdateJson);
  //     /// 新版本号
  //     String newVersion = readShadowUpdateModel.version;
  //     /// 获取设备信息
  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     /// 当前版本号
  //     String currentVersion = packageInfo.version;
  //
  //     if (newVersion != currentVersion) {
  //       return AppUpgradeInfo(
  //         title: '${readShadowUpdateModel.title}v${readShadowUpdateModel.version}',
  //         contents: readShadowUpdateModel.contents,
  //         force: readShadowUpdateModel.force,
  //         apkDownloadUrl: readShadowUpdateModel.url
  //       );
  //     }
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: <Widget>[
            Icon(Icons.calendar_today, size: ScreenUtil().setWidth(60),),
            GestureDetector(
              child: Container(
                height: ScreenUtil().setHeight(60),
                width: ScreenUtil().setWidth(600),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: Icon(Icons.search, size: ScreenUtil().setWidth(40), color: Colors.black26),
                      padding: EdgeInsets.only(left: 10, right: 5),
                    ),
                    Text(
                      "影片，任你搜",
                      style: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colors.black26, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              onTap: () {
                CZRouter.cz_push(context, RoutePathRegister.movieSearch);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
//        bottom:
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).accentColor,
            height: ScreenUtil().setHeight(60),
            child: TabBar(
                //isScrollable: true,
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(28),
                fontWeight: FontWeight.bold
              ),
              unselectedLabelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(26),
              ),
              labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              tabs: <Widget>[
                Tab(text: "热门推荐"),
                Tab(text: "小编强推"),
                Tab(text: "明星推荐"),
                Tab(text: "追剧向导"),
                Tab(text: "时光热榜"),
              ],
              controller: tabController, // 记得要带上tabController
              onTap: (value) => {cz_print(value, StackTrace.current)},
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                VideoRecommendWidget(),
                VideoPieceSingleWidget(channelId: 1,),
                VideoPieceSingleWidget(channelId: 2,),
                VideoPieceSingleWidget(channelId: 3,),
                VideoPieceSingleWidget(channelId: 4,),
              ],
            ),
          )
        ],
      )
    );
  }
}
