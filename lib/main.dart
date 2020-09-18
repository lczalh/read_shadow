import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
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
 // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
 // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
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
  }
}
