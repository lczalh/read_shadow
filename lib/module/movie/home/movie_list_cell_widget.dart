import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../utility/cz_kit/cz_common.dart';

/*
  影片列表 单元格组件

 */

class MovieListCellWidget extends StatefulWidget {
  const MovieListCellWidget(
      {Key key,
      @required this.movieName,
      @required this.movieImageUrl,
      @required this.movieDirector})
      : super(key: key);

  /// 电影名称
  final String movieName;

  /// 图片地址
  final String movieImageUrl;

  /// 导演
  final String movieDirector;

  @override
  _MovieListCellWidgetState createState() => _MovieListCellWidgetState();
}

class _MovieListCellWidgetState extends State<MovieListCellWidget> {
  @override
  Widget build(BuildContext context) {
    //cz_print(context.size, StackTrace.current);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: ConstrainedBox(
                    child: CachedNetworkImage(
                        // width: context.size.width,
                        fit: BoxFit.cover,
                        imageUrl: widget.movieImageUrl
                        // placeholder: (context, url) => Icons.add,
                        //errorWidget: (context, url, error) =>
                        // Image.asset("images/app.png"),
                        ),
                    constraints: new BoxConstraints.expand(),
                  )),
              Positioned(
                bottom: 5,
                right: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Container(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(30),
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    child: Center(
                      child: Text(
                        "评分:8.0",
                        style: TextStyle(color: Colors.white,
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                            fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ),
                ),
              )

            ],
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(40),
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              widget.movieName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: ScreenUtil().setSp(28)),
            ),
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(40),
          child: Text(
            widget.movieDirector,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Colors.deepOrangeAccent),
          ),
        ),
      ],
    );
  }
}
