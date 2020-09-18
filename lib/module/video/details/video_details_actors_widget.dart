import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_shadow/module/video/details/video_details_model.dart';

class VideoDetailsActorsWidget extends StatelessWidget {
  VideoDetailsActorsWidget({Key key, this.actorModels}) : super(key: key);

  final List<VideoDetailsActorModel> actorModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: ScreenUtil().setHeight(50),
            child: Text(
              "演职人员",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              //textAlign: TextAlign.center,
            )
        ),
        Container(
          height: ScreenUtil().setHeight(240),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              VideoDetailsActorModel actorModel = actorModels[index];
              return Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                width: ScreenUtil().setWidth(150),
                child: Column(
                  children: [
                    ClipRRect(
                      child: CachedNetworkImage(
                        width: ScreenUtil().setWidth(150),
                        height: ScreenUtil().setWidth(150),
                        imageUrl: actorModel.img,
                        placeholder: (context, url) => Image.asset('images/icon_placeholder_figure.png'),
                        errorWidget: (context, url, error) => Image.asset('images/icon_placeholder_figure.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(150)),
                    ),
                    Text(
                      actorModel.name.isEmpty == true ? "未知" : actorModel.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      actorModel.nameEn.isEmpty == true
                          ? "未知"
                          : actorModel.nameEn,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: actorModels.length,
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}