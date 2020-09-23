import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoPlayerSeriesWidget extends StatefulWidget {

  VideoPlayerSeriesWidget({Key key, this.seriesTitles, this.seriesUrls, this.tapSeriesBlock}) : super(key: key);

  /// 播放剧集标题数组
  List<String> seriesTitles;

  /// 播放剧集地址数组
  List<String> seriesUrls;

  final Function(int) tapSeriesBlock;

  @override
  VideoPlayerSeriesWidgetState createState() => VideoPlayerSeriesWidgetState();
}

class VideoPlayerSeriesWidgetState extends State<VideoPlayerSeriesWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  /// 外部更新 UI
  updateSeries(List<String> seriesTitles, List<String> seriesUrls) async {
      widget.seriesTitles = seriesTitles;
      widget.seriesUrls = seriesUrls;
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
   // cz_print(context.watch<VideoPlayerChangeNotifier>().seriesTitles, StackTrace.current);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: <Color>[
                  Colors.blue,
                  Colors.purple,
                  Colors.red,
                  Colors.pinkAccent,
                  Colors.orange
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Text(
              "剧集与更新",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5
          ),
          itemBuilder: (context, index) {

            return GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.primaries[index % Colors.primaries.length],
                child: Text(widget.seriesTitles[index], style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(22),
                ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                widget.tapSeriesBlock(index);
              },
            );
          },
          itemCount: widget.seriesTitles.length,
        )
      ],
    );



  }
}