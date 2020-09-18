
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class VideoDetailsTypeWidget extends StatelessWidget {

  VideoDetailsTypeWidget({Key key, this.types}) : super(key: key);

  /// 影片类型
  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: ScreenUtil().setHeight(50),
            child: Text(
              "影片类型",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
        Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              String type = types[index];
              return Container(
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setHeight(60),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      alignment: Alignment.center,
                      // margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                    //  width: ScreenUtil().setWidth(80),
                    //  height: ScreenUtil().setHeight(50),
                      color: Theme.of(context).accentColor,
                      child: Text(type, style: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),
              );
            },
            itemCount: types.length,
            scrollDirection: Axis.horizontal,
            //  shrinkWrap: true,
          ),
          height: ScreenUtil().setHeight(60),
        ),
      ],
    );
  }
}