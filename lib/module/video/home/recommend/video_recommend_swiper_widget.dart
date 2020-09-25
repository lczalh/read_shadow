import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:read_shadow/module/video/home/recommend/video_recommend_swiper_model.dart';
import 'package:read_shadow/network/cz_network.dart';
import 'package:read_shadow/router/cz_router.dart';
import 'package:read_shadow/router/route_path_register.dart';

class VideoRecommendSwiperWidget extends StatefulWidget {
  @override
  _VideoRecommendSwiperWidget createState() => _VideoRecommendSwiperWidget();
}

class _VideoRecommendSwiperWidget extends State<VideoRecommendSwiperWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getVideoTrailerInfoModel();
  }

  getVideoTrailerInfoModel() async {
    return await CZNetwork().get(
        baseUrl: "https://content-api-m.mtime.cn",
        path: "/movieList/topSlides.api");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        var widget;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            widget = _loadingErrorWidget();
          } else {
            widget = _dataWidget(snapshot.data);
          }
        } else {
          widget = _loadingWidget();
        }
        return widget;
      },
    );
  }

  _loadingWidget() {
    return Center();
  }

  _loadingErrorWidget() {
    return Center();
  }

  _dataWidget(data) {
    VideoRecommendSwiperModel swiperModel =
        VideoRecommendSwiperModel.fromMap(data);
    if (swiperModel.data != null && swiperModel.data.list.length > 0) {
      return Container(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil().setHeight(350),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            VideoRecommendSwiperListElementModel listElementModel =
            swiperModel.data.list[index];
            return GestureDetector(
              onTap: () {
                CZRouter.cz_push(context, RoutePathRegister.pieceSingleDetails,
                    params: {"articleId": listElementModel.articleId});
              },
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: listElementModel.img,
                placeholder: (context, url) => Image.asset('images/icon_placeholder_figure.png'),
                cacheManager: DefaultCacheManager(),
                errorWidget: (context, url, error) =>
                    Image.asset('images/icon_placeholder_figure.png'),
              ),
            );
          },
          // itemHeight: ScreenUtil().setHeight(200),
          // itemWidth: ScreenUtil().setWidth(50),
          itemCount: swiperModel.data.list.length,
          autoplay: true,
          // viewportFraction: 0.8,
          //scale: 0.8,
          //layout: SwiperLayout.TINDER,
        ),
      );
    } else {
      return Center();
    }

  }
}
