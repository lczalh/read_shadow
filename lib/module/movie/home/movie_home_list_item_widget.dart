import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:read_shadow/utility/cz_kit/cz_common.dart';

class MovieHomeListItemWidget extends StatefulWidget {

  const MovieHomeListItemWidget({
    Key key,
    this.movieName,
    this.movieImageUrl,
    this.lastUpdateSeries,
  }) : super(key: key);

  // 电影名称
  final String movieName;

  // 图片地址
  final String movieImageUrl;

  // 最新最新剧集
  final String lastUpdateSeries;

  @override
  _MovieHomeListItemWidgetState createState() =>
      _MovieHomeListItemWidgetState();
}

class _MovieHomeListItemWidgetState extends State<MovieHomeListItemWidget> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cz_print(widget.movieName, StackTrace.current);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CachedNetworkImage(
                fit: BoxFit.cover,
                height: ScreenUtil().setWidth(310),
                width: (ScreenUtil.screenWidth - 10) / 3,
                imageUrl: widget.movieImageUrl
              // placeholder: (context, url) => Icons.add,
              //errorWidget: (context, url, error) =>
              // Image.asset("images/app.png"),
            ),
            Text(
              widget.lastUpdateSeries,
              style: TextStyle(
                  color: Colors.white70,
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                  fontSize: ScreenUtil().setSp(18)),
            )
          ],
        ),
        Expanded(
            child: Center(
                child: Text(
                  widget.movieName,
                  overflow: TextOverflow.ellipsis,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
                )))
      ],
    );
  }
}
