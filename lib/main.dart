import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/utility/router/application.dart';
import 'package:read_shadow/utility/router/routes.dart';

import 'module/entrance/entrance.dart';

void main() {
  // 配置路由
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  cz_print(router, StackTrace.current);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // // 全局配置子树下的SmartRefresher,下面列举几个特别重要的属性
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Entrance(),
    );
//      RefreshConfiguration(
//      headerBuilder: () => WaterDropHeader(),
//      // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
//      footerBuilder: () => ClassicFooter(),
//      // 配置默认底部指示器
//      headerTriggerDistance: 80.0,
//      // 头部触发刷新的越界距离
//      springDescription:
//          SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
//      // 自定义回弹动画,三个属性值意义请查询flutter api
//      maxOverScrollExtent: 100,
//      //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
//      maxUnderScrollExtent: 0,
//      // 底部最大可以拖动的范围
//      enableScrollWhenRefreshCompleted: true,
//      //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
//      enableLoadingWhenFailed: true,
//      //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
//      hideFooterWhenNotFull: false,
//      // Viewport不满一屏时,禁用上拉加载更多功能
//      enableBallisticLoad: false,
//      // 可以通过惯性滑动触发加载更多
//      child:
//    );
  }
}
