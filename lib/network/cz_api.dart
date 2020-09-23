import 'dart:collection';
import 'package:read_shadow/module/video/home/recommend/video_recommend_model.dart';

import 'cz_network.dart';

class CZApi {
  // 配置请求公共参数
  static SplayTreeMap<String, dynamic> _configCommonParame() {
    var parames = new SplayTreeMap<String, dynamic>();
    return parames;
  }

  // 请求重试时间间隔
  static int _delay = 3;

  // 请求最大重试次数
  static int _max = 3;


}

class CZApiPath {

  // 书籍分类路径
  static String get videoResourcesPath =>
      '/inc/s_feifeikkm3u8';
}
