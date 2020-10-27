import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CZEmptyWidget extends StatefulWidget {

  CZEmptyWidget({Key key, this.imagePath, this.content, this.buttonTitle, this.tapBlock}) : super(key: key);

  /// 本地图片路径
  final String imagePath;

  /// 内容
  final String content;

  /// 按钮标题
  final String buttonTitle;

  /// 点击按钮回调
  final Function() tapBlock;

  @override
  _CZEmptyWidgetState createState() => _CZEmptyWidgetState();
}

class _CZEmptyWidgetState extends State<CZEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.imagePath ?? 'assets/images/icon_empty_placeholder.png',
            fit: BoxFit.cover,
            //width: ScreenUtil.screenWidth - 50,
            //height: ScreenUtil().setHeight(400),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            width: ScreenUtil().screenWidth - 50,
            child: Text(
              widget.content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black45, fontSize: ScreenUtil().setSp(28)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text(
                widget.buttonTitle,
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
              onPressed: () {
                widget.tapBlock();
              },
            ),
          )
        ],
      ),
    );
  }
}
