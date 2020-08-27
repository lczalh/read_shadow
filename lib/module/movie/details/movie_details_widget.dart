//import 'package:fijkplayer/core/lib.dart';
//import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_shadow/module/movie/home/movie_root_model.dart';
//import 'package:video_player/video_player.dart';

class MovieDetailsWidget extends StatefulWidget {

  const MovieDetailsWidget({
    Key key,
    this.model,
  }) : super(key: key);

  final MovieDataModel model;

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();

}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {

//  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
//    player.setDataSource("https://you.tube-kuyun.com/20200824/22530_c09353e2/index.m3u8", autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
//          child: FijkView(
//            player: player,
//          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
//    player.release();
  }


//      Scaffold(
//      appBar: AppBar(
//        title: Text(widget.model.vodName),
//      ),
//      body: Column(
//        children: [
//          _controller.value.initialized
//              ? AspectRatio(
//            aspectRatio: _controller.value.aspectRatio,
//            child: VideoPlayer(_controller),
//          )
//              : Container(),
//          floatingActionButton: FloatingActionButton(
//            onPressed: () {
//              setState(() {
//                _controller.value.isPlaying
//                    ? _controller.pause()
//                    : _controller.play();
//              });
//            },
//            child: Icon(
//              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//            ),
//          ),
//          Container(
//            height: ScreenUtil().setWidth(150),
//            color: Colors.blue,
//          ),
//        ],
//      ),
//    );
//  }
}