import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MineHomeWidget extends StatefulWidget {
  @override
  MineHomeWidgetState createState() => MineHomeWidgetState();
}

class MineHomeWidgetState extends State<MineHomeWidget> with AutomaticKeepAliveClientMixin {

  // 总数
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  EasyRefreshController _controller;
  ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      emptyWidget: _count == 0
          ? Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(),
              flex: 2,
            ),
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: Image.asset('assets/image/nodata.png'),
            ),
            Text(
              "S.of(context).noData",
              style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
            ),
            Expanded(
              child: SizedBox(),
              flex: 3,
            ),
          ],
        ),
      )
          : null,
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 3),
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }, childCount: _count),
        ),
      ],
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _count = 20;
            });
          }
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _count += 20;
            });
          }
        });
      },
    );
  }
}