import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                placeholder: (context, url) => Center(
                    child: SpinKitFadingCube(
                  color: Theme.of(context).accentColor,
                )),
                errorWidget: (context, url, error) =>
                    Image.asset('images/icon_placeholder_figure.png'),
              ),
              constraints: new BoxConstraints.expand(),
            )),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
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
              Row(
                children: [
                  RatingBar(
                    initialRating: double.parse(score == null || score.isEmpty == true ? "0.0" : score) / 2.0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      //size: ScreenUtil().setWidth(10),
                    ),
                    itemSize: ScreenUtil().setWidth(25),
                  ),
                  Padding(
                    child: Text(
                      "${score.isEmpty == true ? "0" : score}",
                      style: TextStyle(
                          color: Colors.white,
                          //  backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.only(left: 5),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
