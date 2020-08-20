import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void cz_print<T>(T message, StackTrace stackTrace) {
  if (kReleaseMode) return;
  var traceString = stackTrace.toString().split("\n")[0];
  var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
  var fileInfo = traceString.substring(indexOfFileName);
  var listOfInfos = fileInfo.split(":");
  var fileName = listOfInfos[0];
  var lineNumber = int.parse(listOfInfos[1]);
  print(
      "所在文件: ${fileName}, 所在行: ${lineNumber}, 数据类型: ${message.runtimeType} 打印信息: ${message}");
}

/// 获取屏幕宽度
double cz_screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// 获取屏幕高度
double cz_screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// 获取屏幕大小
Size cz_screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

/// 获取状态栏高度
double cz_statusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// 安全区域高度
double cz_safeAreaHeight(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}

/// 获取屏幕宽度比例
double cz_screenWidthScale(BuildContext context) {
  return cz_screenWidth(context) / 375.0;
}

/// 获取屏幕高度比例
double cz_screenHeightScale(BuildContext context) {
  return cz_screenHeight(context) / 667.0;
}

/// 动态适应宽度
double cz_dynamicFitWidth(double width, BuildContext context) {
  return width * cz_screenWidthScale(context);
}

/// 动态适应高度
double cz_dynamicFitHeight(double height, BuildContext context) {
  return height * cz_screenHeightScale(context);
}

