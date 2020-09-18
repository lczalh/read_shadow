import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TopicMovieRankingCellWidget extends StatelessWidget {
  TopicMovieRankingCellWidget({Key key, this.title, this.imageUrl, this.score})
      : super(key: key);

  /// 标题
  final String title;

  /// 图片地址
  final String imageUrl;

  /// 评分
  final String score;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: ConstrainedBox(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    Image.asset('images/icon_placeholder_figure.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('images/icon_placeholder_figure.png'),
              ),
              constraints: new BoxConstraints.expand(),
            )),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            //  width: ScreenUtil.screenWidth,
            //height: ScreenUtil().setHeight(600),
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          left: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Text(
                    score,
                    style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
