
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
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
                fontSize: ScreenUtil().setSp(26),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              //textAlign: TextAlign.center,
            )
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(), // 禁止滚动
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            VideoDetailsListElementModel listElementModel = listElementModels[index];
            return CachedNetworkImage(
              imageUrl: listElementModel.imgUrl,
              fit: BoxFit.fill,
            );
          },
          itemCount: listElementModels.length,
        )
      ],
    );
  }
}