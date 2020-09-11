// To parse this JSON data, do
//
//     final recommendModel = recommendModelFromMap(jsonString);

import 'dart:convert';

class MovieHomeRecommendRootModel {
  MovieHomeRecommendRootModel({
    this.code,
    this.data,
    this.msg,
    this.showMsg,
  });

  final String code;
  final MovieHomeRecommendDataModel data;
  final String msg;
  final String showMsg;

  factory MovieHomeRecommendRootModel.fromJson(String str) => MovieHomeRecommendRootModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendRootModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendRootModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : MovieHomeRecommendDataModel.fromMap(json["data"]),
    msg: json["msg"] == null ? null : json["msg"],
    showMsg: json["showMsg"] == null ? null : json["showMsg"],
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data.toMap(),
    "msg": msg == null ? null : msg,
    "showMsg": showMsg == null ? null : showMsg,
  };
}

class MovieHomeRecommendDataModel {
  MovieHomeRecommendDataModel({
    this.freeOnlinePlaying,
    this.hotOnlineDramas,
    this.hotOnlinePlaying,
    this.latestOnlinePlaying,
    this.newMovieTrailer,
    this.scheduledOnlinePlaying,
    this.topicMovieRanking,
  });

  /// 免费电影
  final MovieHomeRecommendFreeOnlinePlayingModel freeOnlinePlaying;
  /// 热门电视剧
  final MovieHomeRecommendFreeOnlinePlayingModel hotOnlineDramas;
  /// 全网热播电影
  final MovieHomeRecommendHotOnlinePlayingModel hotOnlinePlaying;
  /// 最新上线
  final MovieHomeRecommendFreeOnlinePlayingModel latestOnlinePlaying;
  /// 新片预告
  final MovieHomeRecommendNewMovieTrailerModel newMovieTrailer;
  /// 全网即将上线
  final MovieHomeRecommendScheduledOnlinePlayingModel scheduledOnlinePlaying;
  /// 主题电影排名
  final MovieHomeRecommendTopicMovieRankingModel topicMovieRanking;

  factory MovieHomeRecommendDataModel.fromJson(String str) => MovieHomeRecommendDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendDataModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendDataModel(
    freeOnlinePlaying: json["freeOnlinePlaying"] == null ? null : MovieHomeRecommendFreeOnlinePlayingModel.fromMap(json["freeOnlinePlaying"]),
    hotOnlineDramas: json["hotOnlineDramas"] == null ? null : MovieHomeRecommendFreeOnlinePlayingModel.fromMap(json["hotOnlineDramas"]),
    hotOnlinePlaying: json["hotOnlinePlaying"] == null ? null : MovieHomeRecommendHotOnlinePlayingModel.fromMap(json["hotOnlinePlaying"]),
    latestOnlinePlaying: json["latestOnlinePlaying"] == null ? null : MovieHomeRecommendFreeOnlinePlayingModel.fromMap(json["latestOnlinePlaying"]),
    newMovieTrailer: json["newMovieTrailer"] == null ? null : MovieHomeRecommendNewMovieTrailerModel.fromMap(json["newMovieTrailer"]),
    scheduledOnlinePlaying: json["scheduledOnlinePlaying"] == null ? null : MovieHomeRecommendScheduledOnlinePlayingModel.fromMap(json["scheduledOnlinePlaying"]),
    topicMovieRanking: json["topicMovieRanking"] == null ? null : MovieHomeRecommendTopicMovieRankingModel.fromMap(json["topicMovieRanking"]),
  );

  Map<String, dynamic> toMap() => {
    "freeOnlinePlaying": freeOnlinePlaying == null ? null : freeOnlinePlaying.toMap(),
    "hotOnlineDramas": hotOnlineDramas == null ? null : hotOnlineDramas.toMap(),
    "hotOnlinePlaying": hotOnlinePlaying == null ? null : hotOnlinePlaying.toMap(),
    "latestOnlinePlaying": latestOnlinePlaying == null ? null : latestOnlinePlaying.toMap(),
    "newMovieTrailer": newMovieTrailer == null ? null : newMovieTrailer.toMap(),
    "scheduledOnlinePlaying": scheduledOnlinePlaying == null ? null : scheduledOnlinePlaying.toMap(),
    "topicMovieRanking": topicMovieRanking == null ? null : topicMovieRanking.toMap(),
  };
}

class MovieHomeRecommendFreeOnlinePlayingModel {
  MovieHomeRecommendFreeOnlinePlayingModel({
    this.moreAppLink,
    this.movieList,
  });

  final String moreAppLink;
  final List<MovieHomeRecommendMovieListModel> movieList;

  factory MovieHomeRecommendFreeOnlinePlayingModel.fromJson(String str) => MovieHomeRecommendFreeOnlinePlayingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendFreeOnlinePlayingModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendFreeOnlinePlayingModel(
    moreAppLink: json["moreAppLink"] == null ? null : json["moreAppLink"],
    movieList: json["movieList"] == null ? null : List<MovieHomeRecommendMovieListModel>.from(json["movieList"].map((x) => MovieHomeRecommendMovieListModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "moreAppLink": moreAppLink == null ? null : moreAppLink,
    "movieList": movieList == null ? null : List<dynamic>.from(movieList.map((x) => x.toMap())),
  };
}

class MovieHomeRecommendMovieListModel {
  MovieHomeRecommendMovieListModel({
    this.commentSpecial,
    this.img,
    this.isFilter,
    this.isPlay,
    this.movieId,
    this.name,
    this.onlineInfo,
    this.rating,
    this.episodeNum,
    this.movieType,
    this.paragraph,
  });

  final String commentSpecial;
  final String img;
  final bool isFilter;
  final String isPlay;
  final int movieId;
  final String name;
  final String onlineInfo;
  final String rating;
  final String episodeNum;
  final String movieType;
  final String paragraph;

  factory MovieHomeRecommendMovieListModel.fromJson(String str) => MovieHomeRecommendMovieListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendMovieListModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendMovieListModel(
    commentSpecial: json["commentSpecial"] == null ? null : json["commentSpecial"],
    img: json["img"] == null ? null : json["img"],
    isFilter: json["isFilter"] == null ? null : json["isFilter"],
    isPlay: json["isPlay"] == null ? null : json["isPlay"],
    movieId: json["movieId"] == null ? null : json["movieId"],
    name: json["name"] == null ? null : json["name"],
    onlineInfo: json["onlineInfo"] == null ? null : json["onlineInfo"],
    rating: json["rating"] == null ? null : json["rating"],
    episodeNum: json["episodeNum"] == null ? null : json["episodeNum"],
    movieType: json["movieType"] == null ? null : json["movieType"],
    paragraph: json["paragraph"] == null ? null : json["paragraph"],
  );

  Map<String, dynamic> toMap() => {
    "commentSpecial": commentSpecial == null ? null : commentSpecial,
    "img": img == null ? null : img,
    "isFilter": isFilter == null ? null : isFilter,
    "isPlay": isPlay == null ? null : isPlay,
    "movieId": movieId == null ? null : movieId,
    "name": name == null ? null : name,
    "onlineInfo": onlineInfo == null ? null : onlineInfo,
    "rating": rating == null ? null : rating,
    "episodeNum": episodeNum == null ? null : episodeNum,
    "movieType": movieType == null ? null : movieType,
    "paragraph": paragraph == null ? null : paragraph,
  };
}

class MovieHomeRecommendHotOnlinePlayingModel {
  MovieHomeRecommendHotOnlinePlayingModel({
    this.moreAppLink,
    this.movieBigImgList,
    this.movieList,
    this.videoTabAppLink,
  });

  final String moreAppLink;
  final List<MovieHomeRecommendMovieListModel> movieBigImgList;
  final List<MovieHomeRecommendMovieListModel> movieList;
  final String videoTabAppLink;

  factory MovieHomeRecommendHotOnlinePlayingModel.fromJson(String str) => MovieHomeRecommendHotOnlinePlayingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendHotOnlinePlayingModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendHotOnlinePlayingModel(
    moreAppLink: json["moreAppLink"] == null ? null : json["moreAppLink"],
    movieBigImgList: json["movieBigImgList"] == null ? null : List<MovieHomeRecommendMovieListModel>.from(json["movieBigImgList"].map((x) => MovieHomeRecommendMovieListModel.fromMap(x))),
    movieList: json["movieList"] == null ? null : List<MovieHomeRecommendMovieListModel>.from(json["movieList"].map((x) => MovieHomeRecommendMovieListModel.fromMap(x))),
    videoTabAppLink: json["videoTabAppLink"] == null ? null : json["videoTabAppLink"],
  );

  Map<String, dynamic> toMap() => {
    "moreAppLink": moreAppLink == null ? null : moreAppLink,
    "movieBigImgList": movieBigImgList == null ? null : List<dynamic>.from(movieBigImgList.map((x) => x.toMap())),
    "movieList": movieList == null ? null : List<dynamic>.from(movieList.map((x) => x.toMap())),
    "videoTabAppLink": videoTabAppLink == null ? null : videoTabAppLink,
  };
}

class MovieHomeRecommendNewMovieTrailerModel {
  MovieHomeRecommendNewMovieTrailerModel({
    this.trailers,
  });

  final List<MovieHomeRecommendTrailerModel> trailers;

  factory MovieHomeRecommendNewMovieTrailerModel.fromJson(String str) => MovieHomeRecommendNewMovieTrailerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendNewMovieTrailerModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendNewMovieTrailerModel(
    trailers: json["trailers"] == null ? null : List<MovieHomeRecommendTrailerModel>.from(json["trailers"].map((x) => MovieHomeRecommendTrailerModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "trailers": trailers == null ? null : List<dynamic>.from(trailers.map((x) => x.toMap())),
  };
}

class MovieHomeRecommendTrailerModel {
  MovieHomeRecommendTrailerModel({
    this.commentTotal,
    this.coverImg,
    this.hightUrl,
    this.id,
    this.movieId,
    this.movieName,
    this.playCount,
    this.rating,
    this.summary,
    this.type,
    this.url,
    this.videoLength,
    this.videoLengthShow,
    this.videoSource,
    this.videoTitle,
  });

  final String commentTotal;
  final String coverImg;
  final String hightUrl;
  final int id;
  final int movieId;
  final String movieName;
  final String playCount;
  final double rating;
  final String summary;
  final List<String> type;
  final String url;
  final int videoLength;
  final String videoLengthShow;
  final int videoSource;
  final String videoTitle;

  factory MovieHomeRecommendTrailerModel.fromJson(String str) => MovieHomeRecommendTrailerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendTrailerModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendTrailerModel(
    commentTotal: json["commentTotal"] == null ? null : json["commentTotal"],
    coverImg: json["coverImg"] == null ? null : json["coverImg"],
    hightUrl: json["hightUrl"] == null ? null : json["hightUrl"],
    id: json["id"] == null ? null : json["id"],
    movieId: json["movieId"] == null ? null : json["movieId"],
    movieName: json["movieName"] == null ? null : json["movieName"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    summary: json["summary"] == null ? null : json["summary"],
    type: json["type"] == null ? null : List<String>.from(json["type"].map((x) => x)),
    url: json["url"] == null ? null : json["url"],
    videoLength: json["videoLength"] == null ? null : json["videoLength"],
    videoLengthShow: json["videoLengthShow"] == null ? null : json["videoLengthShow"],
    videoSource: json["videoSource"] == null ? null : json["videoSource"],
    videoTitle: json["videoTitle"] == null ? null : json["videoTitle"],
  );

  Map<String, dynamic> toMap() => {
    "commentTotal": commentTotal == null ? null : commentTotal,
    "coverImg": coverImg == null ? null : coverImg,
    "hightUrl": hightUrl == null ? null : hightUrl,
    "id": id == null ? null : id,
    "movieId": movieId == null ? null : movieId,
    "movieName": movieName == null ? null : movieName,
    "playCount": playCount == null ? null : playCount,
    "rating": rating == null ? null : rating,
    "summary": summary == null ? null : summary,
    "type": type == null ? null : List<dynamic>.from(type.map((x) => x)),
    "url": url == null ? null : url,
    "videoLength": videoLength == null ? null : videoLength,
    "videoLengthShow": videoLengthShow == null ? null : videoLengthShow,
    "videoSource": videoSource == null ? null : videoSource,
    "videoTitle": videoTitle == null ? null : videoTitle,
  };
}

class MovieHomeRecommendScheduledOnlinePlayingModel {
  MovieHomeRecommendScheduledOnlinePlayingModel({
    this.movieList,
  });

  final List<MovieHomeRecommendMovieListModel> movieList;

  factory MovieHomeRecommendScheduledOnlinePlayingModel.fromJson(String str) => MovieHomeRecommendScheduledOnlinePlayingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendScheduledOnlinePlayingModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendScheduledOnlinePlayingModel(
    movieList: json["movieList"] == null ? null : List<MovieHomeRecommendMovieListModel>.from(json["movieList"].map((x) => MovieHomeRecommendMovieListModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "movieList": movieList == null ? null : List<dynamic>.from(movieList.map((x) => x.toMap())),
  };
}

class MovieHomeRecommendTopicMovieRankingModel {
  MovieHomeRecommendTopicMovieRankingModel({
    this.articleList,
  });

  final List<MovieHomeRecommendArticleListModel> articleList;

  factory MovieHomeRecommendTopicMovieRankingModel.fromJson(String str) => MovieHomeRecommendTopicMovieRankingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendTopicMovieRankingModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendTopicMovieRankingModel(
    articleList: json["articleList"] == null ? null : List<MovieHomeRecommendArticleListModel>.from(json["articleList"].map((x) => MovieHomeRecommendArticleListModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "articleList": articleList == null ? null : List<dynamic>.from(articleList.map((x) => x.toMap())),
  };
}

class MovieHomeRecommendArticleListModel {
  MovieHomeRecommendArticleListModel({
    this.articleId,
    this.dominantHue,
    this.hasMore,
    this.movieCount,
    this.relatedMovie,
    this.relatedMovies,
    this.title,
  });

  final int articleId;
  final String dominantHue;
  final int hasMore;
  final int movieCount;
  final MovieHomeRecommendMovieListModel relatedMovie;
  final List<MovieHomeRecommendMovieListModel> relatedMovies;
  final String title;

  factory MovieHomeRecommendArticleListModel.fromJson(String str) => MovieHomeRecommendArticleListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieHomeRecommendArticleListModel.fromMap(Map<String, dynamic> json) => MovieHomeRecommendArticleListModel(
    articleId: json["articleId"] == null ? null : json["articleId"],
    dominantHue: json["dominantHue"] == null ? null : json["dominantHue"],
    hasMore: json["hasMore"] == null ? null : json["hasMore"],
    movieCount: json["movieCount"] == null ? null : json["movieCount"],
    relatedMovie: json["relatedMovie"] == null ? null : MovieHomeRecommendMovieListModel.fromMap(json["relatedMovie"]),
    relatedMovies: json["relatedMovies"] == null ? null : List<MovieHomeRecommendMovieListModel>.from(json["relatedMovies"].map((x) => MovieHomeRecommendMovieListModel.fromMap(x))),
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "articleId": articleId == null ? null : articleId,
    "dominantHue": dominantHue == null ? null : dominantHue,
    "hasMore": hasMore == null ? null : hasMore,
    "movieCount": movieCount == null ? null : movieCount,
    "relatedMovie": relatedMovie == null ? null : relatedMovie.toMap(),
    "relatedMovies": relatedMovies == null ? null : List<dynamic>.from(relatedMovies.map((x) => x.toMap())),
    "title": title == null ? null : title,
  };
}
