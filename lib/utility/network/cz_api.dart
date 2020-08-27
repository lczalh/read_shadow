import 'dart:collection';

import 'package:read_shadow/module/movie/home/movie_root_model.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

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

  /*
    获取视频数据 wd: 搜索内容, p: 页码, cid: 类别
  */
  static Future<MovieRootModel> getVideoData(
      {String wd, int p, String cid}) async {
    var parames = _configCommonParame();
    parames['wd'] = wd;
    parames['p'] = p;
    parames['cid'] = cid;
    var map = await CZNetwork()
        .get(CZApiPath.videoResourcesPath, parames, _delay, _max);
    return MovieRootModel.fromMap(map);
  }
}

class CZApiPath {

  // 书籍分类路径
  static String get videoResourcesPath =>
      '/inc/s_feifeikkm3u8';
}
