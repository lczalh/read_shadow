import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/route_path_register.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/router/cz_router.dart';

import 'movie_search_model.dart';

class MovieSearchWidget extends StatefulWidget {
  MovieSearchWidget({Key key, this.searchName}) : super(key: key);

  /// 搜索名称
  final String searchName;

  @override
  _MovieSearchWidgetState createState() => _MovieSearchWidgetState();
}

class _MovieSearchWidgetState extends State<MovieSearchWidget> {
  ///  搜索列表数据
  List<MovieSearchListElementModel> searchModels = [];

  TextEditingController _textEditingController;

  /// 记录旧的搜索值
  String _oldSearchValue;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textEditingController = new TextEditingController(text: widget.searchName);
    _textEditingController.addListener(() async {
      TextRange composingRange = _textEditingController.value.composing;
      /// 过滤拼音联想
      if (composingRange.isCollapsed == false) return;
      /// 过滤搜索内容相同
      if (_oldSearchValue == _textEditingController.text) return;
      if (_textEditingController.text.isEmpty == true) { /// 搜索值为空
        _oldSearchValue = null;
        searchModels.clear();
        setState(() {});
      } else {
        _oldSearchValue = _textEditingController.text;
        await CZNetwork().get(
            baseUrl: "http://zy.yilans.net",
            path: "/api.php/provide/vod",
            params: {
              "ac": "detail",
              "wd": _oldSearchValue
            }).then((map) {
          MovieSearchModel model = MovieSearchModel.fromMap(map);
          searchModels.clear();
          for (MovieSearchListElementModel searchModel in model.list) {
            searchModels.add(searchModel);
          }
          /// 避免网络比较慢时 快速清理搜索值时列表还会显示数据
          if (_oldSearchValue == null) {
            searchModels.clear();
          }
          setState(() {});
        }).catchError((error)  {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Platform.isIOS == true
                    ? Icons.arrow_back_ios
                    : Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                CZRouter.pop(context);
              },
            ),
            Container(
              height: ScreenUtil().setHeight(60),
              width: ScreenUtil().setWidth(630),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(30)),
              ),
              child: Row(
                children: [
                  Padding(
                    child: Icon(
                      Icons.search,
                      color: Colors.black26,
                      size: ScreenUtil().setWidth(40),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 5),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: '影片，任你搜',
                        hintMaxLines: 1,
                        contentPadding: EdgeInsets.only(bottom: 0),
                        isDense: true,
                        hintStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(26),
                            color: Colors.black26),
                        border: InputBorder.none,
                      ),
                      // focusNode: _focusNode,
                      autofocus: true,
                      style: TextStyle(fontSize: ScreenUtil().setSp(26)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        //backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final searchModel = searchModels[index];
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  /// 图片
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setHeight(290),
                        fit: BoxFit.cover,
                        imageUrl: searchModel.vodPic,
                        // placeholder: (context, url) => Image.asset(
                        //   'assets/images/icon_placeholder_figure.png',
                        //   fit: BoxFit.cover,
                        // ),
                        cacheManager: DefaultCacheManager(),
                        placeholderFadeInDuration: Duration.zero,
                        // errorWidget: (context, url, error) => Image.asset(
                        //   'assets/images/icon_placeholder_figure.png',
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenUtil().screenWidth -
                        ScreenUtil().setWidth(200) -
                        30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 影片名称
                        Padding(
                          child: Text(
                            "${searchModel.vodName}(${searchModel.vodYear})",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(28),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          padding: EdgeInsets.only(right: 10),
                        ),

                        /// 更新至
                        Padding(
                          child: Text(
                            searchModel.vodRemarks,
                            style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                            maxLines: 1,
                          ),
                          padding: EdgeInsets.only(top: 5, right: 10),
                        ),

                        /// 类型，地区
                        Padding(
                          child: Text(
                            "${searchModel.vodClass}，${searchModel.vodArea}",
                            style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                            maxLines: 1,
                          ),
                          padding: EdgeInsets.only(top: 5, right: 10),
                        ),

                        /// 导演
                        Padding(
                          child: Text(
                            "导演：${searchModel.vodDirector}",
                            style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                            maxLines: 1,
                          ),
                          padding: EdgeInsets.only(top: 5, right: 10),
                        ),

                        /// 主演
                        Padding(
                          child: Text(
                            "主演：${searchModel.vodActor}",
                            style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                            maxLines: 2,
                          ),
                          padding: EdgeInsets.only(top: 5, right: 10),
                        ),
                      ],
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            onTap: () {
              if (searchModel.vodPlayUrl == null ||
                  searchModel.vodPlayUrl.isEmpty == true) {
                /// 提示播放地址不存在
                return;
              }
              if (searchModel.vodPlayFrom == null ||
                  searchModel.vodPlayFrom.isEmpty == true) {
                /// 提示播放源不存在
                return;
              }
              CZRouter.cz_push(context, RoutePathRegister.videoPlayer, params: {
                "videoImage": searchModel.vodPic,
                "videoName": searchModel.vodName,
                "videoUrl": searchModel.vodPlayUrl,
                "videoPlaySource": searchModel.vodPlayFrom
              });
            },
          );
        },
        itemExtent: ScreenUtil().setHeight(300),
        itemCount: searchModels.length,
      ),
    );
  }
}
