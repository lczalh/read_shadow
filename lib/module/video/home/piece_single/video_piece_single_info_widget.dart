
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VideoPieceSingleInfoWidget extends StatelessWidget {
  const VideoPieceSingleInfoWidget(
      {Key key,
        @required this.pieceSingleName,
        @required this.pieceSingleImageUrl,
        @required this.pieceSingleNum,})
      : super(key: key);

  /// 电影名称
  final String pieceSingleName;

  /// 图片地址
  final String pieceSingleImageUrl;

  /// 片单数
  final int pieceSingleNum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ConstrainedBox(
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: pieceSingleImageUrl,
                    placeholder: (context, url) =>
                        Image.asset('images/icon_placeholder_figure.png', fit: BoxFit.cover,),
                    cacheManager: DefaultCacheManager(),
                    placeholderFadeInDuration: Duration.zero,
                    errorWidget: (context, url, error) =>
                        Image.asset('images/icon_placeholder_figure.png', fit: BoxFit.cover,)),
                constraints: new BoxConstraints.expand(),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            pieceSingleName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: ScreenUtil().setSp(24), fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ),
        Text(
          "共$pieceSingleNum部",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black45,
              fontSize: ScreenUtil().setSp(22)),
        ),
      ],
    );
  }
}