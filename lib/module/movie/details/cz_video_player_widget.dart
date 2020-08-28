import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CZVideoPlayerWidget extends StatefulWidget {

  const CZVideoPlayerWidget({
    Key key,
    @required this.width,
    @required this.height,
    @required this.url,
    this.imageUrl,
  }) : super(key: key);

  // 宽度
  final double width;

  // 高度
  final double height;

  // 播放地址
  final String url;

  // 封面图地址
  final String imageUrl;

  @override
  _CZVideoPlayerWidgetState createState() => _CZVideoPlayerWidgetState();
}

class _CZVideoPlayerWidgetState extends State<CZVideoPlayerWidget> {

  // 播放器控制器
  VideoPlayerController _controller;

  double _sliderValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化控制器
    _controller = VideoPlayerController.network(
        'https://tudou.diediao-kuyun.com/20200106/9868_5cfe5214/index.m3u8')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          print(111111);
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.initialized
        ? Container(
            height: ScreenUtil().setHeight(400),
            width: ScreenUtil.screenWidth,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                VideoPlayer(_controller),
                Container(
                  width: ScreenUtil.screenWidth,
                  height: 40,
                  child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        size: 35,
                        color: Colors.white,
                      ),
                      Text("10:10", style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.white
                      ),),
                      Expanded(
                        child:  SliderTheme( //自定义风格
                          data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.red, //进度条滑块左边颜色
                              inactiveTrackColor: Colors.blue, //进度条滑块右边颜色
                              //trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                              thumbColor: Colors.white, //滑块颜色
                           //  overlayColor: Colors.green, //滑块拖拽时外圈的颜色
                              overlayShape: RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
                                overlayRadius: 10, //滑块外圈大小
                              ),
                              thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                                disabledThumbRadius: 5, //禁用是滑块大小
                                enabledThumbRadius: 5, //滑块大小
                              ),
                              trackHeight: 2 //进度条宽度

                          ),
                          child: Slider(
                            value: _sliderValue,
                            onChanged: (v) {
                              setState(() => _sliderValue = v);
                            },
                         //   label: "气泡:$_sliderValue",//气泡的值
                         ///  divisions: 10, //进度条上显示多少个刻度点
                            max: 100,
                            min: 0,
                          ),
                        )
                      ),
                      Text("16:10", style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.white
                      ),),
                      Icon(
                        Icons.fullscreen,
                        size: 35,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : CachedNetworkImage(
            fit: BoxFit.cover,
            height: ScreenUtil().setHeight(400),
            width: ScreenUtil.screenWidth,
            imageUrl: widget.imageUrl
            // placeholder: (context, url) => Icons.add,
            //errorWidget: (context, url, error) =>
            // Image.asset("images/app.png"),
            );
  }
}
