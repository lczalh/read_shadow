import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:read_shadow/module/video/details/video_details_model.dart';

class VideoDetailsStageWidget extends StatelessWidget {
  VideoDetailsStageWidget({Key key, this.listElementModels}) : super(key: key);

  final List<VideoDetailsListElementModel> listElementModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: ScreenUtil().setHeight(50),
            child: Text(
              "剧照",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              //textAlign: TextAlign.center,
            )),
        GridView.builder(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          physics: NeverScrollableScrollPhysics(),
          // 禁止滚动
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5
          ),
          itemBuilder: (context, index) {
            VideoDetailsListElementModel listElementModel =
                listElementModels[index];
            return CachedNetworkImage(
              imageUrl: listElementModel.imgUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Image.asset('assets/images/icon_placeholder_figure.png', fit: BoxFit.cover,),
              cacheManager: DefaultCacheManager(),
              placeholderFadeInDuration: Duration.zero,
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/icon_placeholder_figure.png', fit: BoxFit.cover,),
            );
          },
          itemCount: listElementModels.length,
        )
      ],
    );
  }
}
