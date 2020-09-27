
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoPlayerOperateWidget extends StatefulWidget {

  VideoPlayerOperateWidget({Key key, this.seriesTitles, this.seriesUrls, this.currentSeriesIndex, this.interfaceBlock, this.refreshBlock, this.shareBlock, this.firstPartBlcok, this.nextPartBlock}) : super(key: key);

  /// 播放剧集标题数组
  final List<String> seriesTitles;

  /// 播放剧集地址数组
  final List<String> seriesUrls;

  /// 当前播放的剧集索引
  final int currentSeriesIndex;

  /// 接口的回调
  final Function() interfaceBlock;

  /// 刷新的回调
  final Function() refreshBlock;

  /// 分享的回调
  final Function() shareBlock;

  /// 点击上级的回调
  final Function() firstPartBlcok;

  /// 点击下级的回调
  final Function() nextPartBlock;

  @override
  _VideoPlayerOperateWidgetState createState() => _VideoPlayerOperateWidgetState();
}

class _VideoPlayerOperateWidgetState extends State<VideoPlayerOperateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: ScreenUtil().setHeight(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Container(
              width: (ScreenUtil.screenWidth - 60) / 5,
              height: ScreenUtil().setHeight(60),
              color: Theme.of(context).accentColor,
              child: Text(
                '接口',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
              alignment: Alignment.center,
            ),
            onTap: () {
              widget.interfaceBlock();
            },
          ),
          GestureDetector(
            child: Container(
              width: (ScreenUtil.screenWidth - 60) / 5,
              height: ScreenUtil().setHeight(60),
              color: Theme.of(context).accentColor,
              child: Text(
                '刷新',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
              alignment: Alignment.center,
            ),
            onTap: () {
              widget.refreshBlock();
            },
          ),
          GestureDetector(
            child: Container(
              width: (ScreenUtil.screenWidth - 60) / 5,
              height: ScreenUtil().setHeight(60),
              color: Theme.of(context).accentColor,
              child: Text(
                '分享',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
              alignment: Alignment.center,
            ),
            onTap: () {
              widget.shareBlock();
            },
          ),
          GestureDetector(
            child: Container(
              width: (ScreenUtil.screenWidth - 60) / 5,
              height: ScreenUtil().setHeight(60),
              color: widget.currentSeriesIndex == 0 ? Theme.of(context).accentColor.withOpacity(0.5) : Theme.of(context).accentColor,
              child: Text(
                '上集',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
              alignment: Alignment.center,
            ),
            onTap: () {
              if (widget.currentSeriesIndex == 0) {
                return;
              }
              widget.firstPartBlcok();
            },
          ),
          GestureDetector(
            child: Container(
              width: (ScreenUtil.screenWidth - 60) / 5,
              height: ScreenUtil().setHeight(60),
              color: widget.seriesTitles.length - 1 == widget.currentSeriesIndex ? Theme.of(context).accentColor.withOpacity(0.5) : Theme.of(context).accentColor,
              child: Text(
                '下集',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
              alignment: Alignment.center,
              //Text('111',style: TextStyle(color:  Colors.white),),
            ),
            onTap: () {
              if (widget.seriesTitles.length - 1 == widget.currentSeriesIndex) {
                return;
              }
              widget.nextPartBlock();
            },
          )
        ],
      ),
    );
  }
}