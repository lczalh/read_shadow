import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/module/video/home/model/movie_root_model.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/network/cz_api.dart';

class MovieSearchWidget extends StatefulWidget {
  @override
  _MovieSearchWidgetState createState() => _MovieSearchWidgetState();
}

class _MovieSearchWidgetState extends State<MovieSearchWidget> {
  //  搜索列表数据
  List<MovieDataModel> searchModels = [];

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () {
                CZRouter.pop(context);
              },
            ),
            Expanded(
              child: TextField(
                style: TextStyle(
                    color: Colors.white54, fontSize: ScreenUtil().setSp(26)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15, right: 15),
                  hintText: '请输入电影名称',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  searchModels.clear();
                  if (value.isEmpty == false) {
                    CZApi.getVideoData(wd: value).then((model) => {
                      for (MovieDataModel searchModel in model.data) {
                        searchModels.add(searchModel)
                      },
                      setState(() {
                        this.searchModels;
                      })
                    }).catchError((error) => {
                      cz_print(error, StackTrace.current)
                    });
                  } else {
                    setState(() {
                      this.searchModels;
                    });
                  }

                  cz_print(value, StackTrace.current);
                },
              ),
            ),
            Icon(Icons.subdirectory_arrow_left)
          ],
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final searchModel = searchModels[index];
          return Container(
            color: Colors.black,
            height: 40,
            width: ScreenUtil.screenWidth,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                  //  width: 200,
                    margin: EdgeInsets.only(left: 15),
                    child:
                    Text(
                      searchModel.vodName,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24), color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(
                    searchModel.vodContinu,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(24), color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
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
