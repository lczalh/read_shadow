import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/video/home/model/movie_root_model.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/route_path_register.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/network/cz_api.dart';

import 'movie_search_model.dart';

class MovieSearchWidget extends StatefulWidget {
  @override
  _MovieSearchWidgetState createState() => _MovieSearchWidgetState();
}

class _MovieSearchWidgetState extends State<MovieSearchWidget> {
  //  搜索列表数据
  List<MovieSearchListElementModel> searchModels = [];

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(600),
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all( width: 1), //边框
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(40)),
              ),
              child: Row(
                children: [
                  Padding(
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: ScreenUtil().setWidth(40),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 5),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        // filled: true,
                        hintText: '影片，任你搜',
                        hintMaxLines: 1,
                        contentPadding: EdgeInsets.only(bottom: 0),
                        isDense: true,
                        hintStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(26),
                            color: Colors.black),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                      onChanged: (value) async {
                        searchModels.clear();
                        if (value.isEmpty == false) {
                          CZNetwork().get(
                              baseUrl: "http://zy.yilans.net",
                              path: "/api.php/provide/vod",
                              params: {
                                "ac": "detail",
                                "wd": value
                              }).then((map) {
                            cz_print(map, StackTrace.current);
                            MovieSearchModel model =
                                MovieSearchModel.fromMap(map);
                            for (MovieSearchListElementModel searchModel
                                in model.list) {
                              searchModels.add(searchModel);
                            }
                            setState(() {
                              // ignore: unnecessary_statements
                              this.searchModels;
                            });
                          }).catchError(
                              (error) => {cz_print(error, StackTrace.current)});
                        } else {
                          setState(() {
                            // ignore: unnecessary_statements
                            this.searchModels;
                          });
                        }

                        cz_print(value, StackTrace.current);
                      },
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Text(
                '取消',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(28),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                CZRouter.pop(context);
              },
            )
          ],
        ),
        //backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final searchModel = searchModels[index];
          return GestureDetector(
            child: Row(
              children: <Widget>[
                /// 图片
                Padding(
                  padding:
                  EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      width: ScreenUtil().setWidth(250),
                      height: ScreenUtil().setHeight(350),
                      fit: BoxFit.cover,
                      imageUrl: searchModel.vodPic,
                      placeholder: (context, url) => Center(
                          child: SpinKitFadingCube(
                            color: Theme.of(context).accentColor,
                          )),
                      errorWidget: (context, url, error) =>
                          Image.asset('images/icon_placeholder_figure.png'),
                    ),
                  ),
                ),

                Container(
                  width: ScreenUtil.screenWidth - ScreenUtil().setWidth(250) - 30,
                  child: Column(
                    // verticalDirection: VerticalDirection.up,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 影片名称
                      Padding(
                        child: Text(
                          "${searchModel.vodName}(${searchModel.vodYear})",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(28),),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        padding: EdgeInsets.only(top: 10, right: 10),
                      ),
                      /// 更新至
                      Padding(
                        child: Text(
                          searchModel.vodRemarks,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(26)),
                        ),
                        padding: EdgeInsets.only(top: 5, right: 10),
                      ),
                      /// 类型，地区
                      Padding(
                        child: Text(
                          "${searchModel.vodClass}，${searchModel.vodArea}",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(26)),
                        ),
                        padding: EdgeInsets.only(top: 5, right: 10),
                      ),
                      /// 导演
                      Padding(
                        child: Text(
                          "导演：${searchModel.vodDirector}",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(26)),
                        ),
                        padding: EdgeInsets.only(top: 5, right: 10),
                      ),
                      /// 主演
                      Padding(
                        child: Text(
                          "主演：${searchModel.vodActor}",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(26)),
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
            onTap: () {
              if (searchModel.vodPlayUrl == null || searchModel.vodPlayUrl.isEmpty == true) {
                /// 提示播放地址不存在
                return;
              }
              if (searchModel.vodPlayFrom == null || searchModel.vodPlayFrom.isEmpty == true) {
                /// 提示播放源不存在
                return;
              }
              CZRouter.cz_push(context, RoutePathRegister.videoPlayer, params: {"videoName": searchModel.vodName, "videoUrl": searchModel.vodPlayUrl, "videoPlaySource": searchModel.vodPlayFrom});
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
            indent: 15,
            endIndent: 15,
            color: Colors.white70,
          );
        },
        itemCount: searchModels.length,
      ),
    );
  }
}
