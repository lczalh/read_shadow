import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoPlayerOperateWidget extends StatefulWidget {
  VideoPlayerOperateWidget(
      {Key key,
      this.seriesTitles,
      this.seriesUrls,
      this.currentInterfaceIndex,
      this.currentSeriesIndex,
      this.interfaceBlock,
      this.refreshBlock,
      this.shareBlock,
      this.firstPartBlcok,
      this.nextPartBlock})
      : super(key: key);

  /// 播放剧集标题数组
  final List<String> seriesTitles;

  /// 播放剧集地址数组
  final List<String> seriesUrls;

  /// 当前播放的剧集索引
  final int currentSeriesIndex;

  /// 接口的回调
  final Function(int) interfaceBlock;

  /// 刷新的回调
  final Function() refreshBlock;

  /// 分享的回调
  final Function() shareBlock;

  /// 点击上级的回调
  final Function() firstPartBlcok;

  /// 点击下级的回调
  final Function() nextPartBlock;

  /// 当前接口索引
  int currentInterfaceIndex;

  @override
  _VideoPlayerOperateWidgetState createState() =>
      _VideoPlayerOperateWidgetState();
}

class _VideoPlayerOperateWidgetState extends State<VideoPlayerOperateWidget> {
  /// 接口BottomSheet是否展开
  bool _isBottomSheetState = false;

  /// 接口名称
  List<String> _interfaceNames = ["接口一", "接口二", "接口三"];

  // /// 当前接口索引
  // int _currentInterfaceIndex = 0;

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
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
              alignment: Alignment.center,
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15)
                        )
                    ),
                    height: ScreenUtil().setHeight(500),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(5),
                          ),
                          height: ScreenUtil().setHeight(10),
                          width: ScreenUtil().setWidth(150),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5
                              //childAspectRatio: 5
                            ),
                            itemBuilder: (context, index) {
                              var interfaceName = _interfaceNames[index];
                              return GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  color: widget.currentInterfaceIndex == index ? Theme.of(context).accentColor : Theme.of(context).accentColor.withOpacity(0.5), //Colors.primaries[index % Colors.primaries.length]
                                  child: Text(interfaceName, style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(22),
                                  ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () {
                                  widget.currentInterfaceIndex = index;
                                  Navigator.pop(context);
                                  widget.interfaceBlock(widget.currentInterfaceIndex);
                                },
                              );
                            },
                            padding: EdgeInsets.only(left: 10, right: 10),
                            itemCount: _interfaceNames.length,
                          )
                        )
                      ],
                    )
                  );
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              );
            },
          ),
          GestureDetector(
            child: Container(
              width: (ScreenUtil.screenWidth - 60) / 5,
              height: ScreenUtil().setHeight(60),
              color: Theme.of(context).accentColor,
              child: Text(
                '刷新',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(26)),
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
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(26)),
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
              color: widget.currentSeriesIndex == 0
                  ? Theme.of(context).accentColor.withOpacity(0.5)
                  : Theme.of(context).accentColor,
              child: Text(
                '上集',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(26)),
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
              color: widget.seriesTitles.length - 1 == widget.currentSeriesIndex
                  ? Theme.of(context).accentColor.withOpacity(0.5)
                  : Theme.of(context).accentColor,
              child: Text(
                '下集',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(26)),
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

  Widget _buildBottomSheet() => BottomSheet(
        enableDrag: false,
        backgroundColor: Colors.transparent,
        onClosing: () {
          print('onClosing');
        },
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15)
                )
            ),
            padding: EdgeInsets.only(top: 20),
            height: ScreenUtil().setHeight(400),
           // color: Colors.red,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text('Item$index');
              },
              itemExtent: 50,
            ),
          );
        },
      );
}
