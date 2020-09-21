// To parse this JSON data, do
//
//     final videoPieceSingleDetailsModel = videoPieceSingleDetailsModelFromMap(jsonString);

import 'dart:convert';

class VideoPieceSingleDetailsModel {
  VideoPieceSingleDetailsModel({
    this.code,
    this.data,
    this.msg,
    this.showMsg,
  });

  final String code;
  final VideoPieceSingleDetailsDataModel data;
  final String msg;
  final String showMsg;

  factory VideoPieceSingleDetailsModel.fromJson(String str) => VideoPieceSingleDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : VideoPieceSingleDetailsDataModel.fromMap(json["data"]),
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

class VideoPieceSingleDetailsDataModel {
  VideoPieceSingleDetailsDataModel({
    this.detail,
    this.publicInfo,
  });

  final VideoPieceSingleDetailsDataDetailsModel detail;
  final PublicInfo publicInfo;

  factory VideoPieceSingleDetailsDataModel.fromJson(String str) => VideoPieceSingleDetailsDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsDataModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsDataModel(
    detail: json["detail"] == null ? null : VideoPieceSingleDetailsDataDetailsModel.fromMap(json["detail"]),
    publicInfo: json["publicInfo"] == null ? null : PublicInfo.fromMap(json["publicInfo"]),
  );

  Map<String, dynamic> toMap() => {
    "detail": detail == null ? null : detail.toMap(),
    "publicInfo": publicInfo == null ? null : publicInfo.toMap(),
  };
}

class VideoPieceSingleDetailsDataDetailsModel {
  VideoPieceSingleDetailsDataDetailsModel({
    this.articleId,
    this.author,
    this.content,
    this.images,
    this.isAllowComment,
    this.isDel,
    this.pageviews,
    this.publicId,
    this.publishTime,
    this.relatedArticleList,
    this.relatedArticles,
    this.relatedMovie,
    this.relatedMovies,
    this.relatedObjList,
    this.relatedPersons,
    this.summary,
    this.title,
    this.topList,
    this.tweetId,
    this.type,
    this.video,
  });

  final int articleId;
  final String author;
  final String content;
  final List<dynamic> images;
  final bool isAllowComment;
  final bool isDel;
  final String pageviews;
  final int publicId;
  final int publishTime;
  final List<dynamic> relatedArticleList;
  final List<dynamic> relatedArticles;
  final VideoPieceSingleDetailsPurpleRelatedMovieModel relatedMovie;
  final List<VideoPieceSingleDetailsRelatedMovieElementModel> relatedMovies;
  final List<VideoPieceSingleDetailsRelatedObjListModel> relatedObjList;
  final List<dynamic> relatedPersons;
  final String summary;
  final String title;
  final VideoPieceSingleDetailsTopListModel topList;
  final int tweetId;
  final int type;
  final Video video;

  factory VideoPieceSingleDetailsDataDetailsModel.fromJson(String str) => VideoPieceSingleDetailsDataDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsDataDetailsModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsDataDetailsModel(
    articleId: json["articleId"] == null ? null : json["articleId"],
    author: json["author"] == null ? null : json["author"],
    content: json["content"] == null ? null : json["content"],
    images: json["images"] == null ? null : List<dynamic>.from(json["images"].map((x) => x)),
    isAllowComment: json["isAllowComment"] == null ? null : json["isAllowComment"],
    isDel: json["isDel"] == null ? null : json["isDel"],
    pageviews: json["pageviews"] == null ? null : json["pageviews"],
    publicId: json["publicId"] == null ? null : json["publicId"],
    publishTime: json["publishTime"] == null ? null : json["publishTime"],
    relatedArticleList: json["relatedArticleList"] == null ? null : List<dynamic>.from(json["relatedArticleList"].map((x) => x)),
    relatedArticles: json["relatedArticles"] == null ? null : List<dynamic>.from(json["relatedArticles"].map((x) => x)),
    relatedMovie: json["relatedMovie"] == null ? null : VideoPieceSingleDetailsPurpleRelatedMovieModel.fromMap(json["relatedMovie"]),
    relatedMovies: json["relatedMovies"] == null ? null : List<VideoPieceSingleDetailsRelatedMovieElementModel>.from(json["relatedMovies"].map((x) => VideoPieceSingleDetailsRelatedMovieElementModel.fromMap(x))),
    relatedObjList: json["relatedObjList"] == null ? null : List<VideoPieceSingleDetailsRelatedObjListModel>.from(json["relatedObjList"].map((x) => VideoPieceSingleDetailsRelatedObjListModel.fromMap(x))),
    relatedPersons: json["relatedPersons"] == null ? null : List<dynamic>.from(json["relatedPersons"].map((x) => x)),
    summary: json["summary"] == null ? null : json["summary"],
    title: json["title"] == null ? null : json["title"],
    topList: json["topList"] == null ? null : VideoPieceSingleDetailsTopListModel.fromMap(json["topList"]),
    tweetId: json["tweetId"] == null ? null : json["tweetId"],
    type: json["type"] == null ? null : json["type"],
    video: json["video"] == null ? null : Video.fromMap(json["video"]),
  );

  Map<String, dynamic> toMap() => {
    "articleId": articleId == null ? null : articleId,
    "author": author == null ? null : author,
    "content": content == null ? null : content,
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    "isAllowComment": isAllowComment == null ? null : isAllowComment,
    "isDel": isDel == null ? null : isDel,
    "pageviews": pageviews == null ? null : pageviews,
    "publicId": publicId == null ? null : publicId,
    "publishTime": publishTime == null ? null : publishTime,
    "relatedArticleList": relatedArticleList == null ? null : List<dynamic>.from(relatedArticleList.map((x) => x)),
    "relatedArticles": relatedArticles == null ? null : List<dynamic>.from(relatedArticles.map((x) => x)),
    "relatedMovie": relatedMovie == null ? null : relatedMovie.toMap(),
    "relatedMovies": relatedMovies == null ? null : List<dynamic>.from(relatedMovies.map((x) => x.toMap())),
    "relatedObjList": relatedObjList == null ? null : List<dynamic>.from(relatedObjList.map((x) => x.toMap())),
    "relatedPersons": relatedPersons == null ? null : List<dynamic>.from(relatedPersons.map((x) => x)),
    "summary": summary == null ? null : summary,
    "title": title == null ? null : title,
    "topList": topList == null ? null : topList.toMap(),
    "tweetId": tweetId == null ? null : tweetId,
    "type": type == null ? null : type,
    "video": video == null ? null : video.toMap(),
  };
}

class VideoPieceSingleDetailsPurpleRelatedMovieModel {
  VideoPieceSingleDetailsPurpleRelatedMovieModel({
    this.buyTicketStatus,
    this.commentSpecial,
    this.img,
    this.isFilter,
    this.isPlay,
    this.isWantSee,
    this.movieId,
    this.movieType,
    this.name,
    this.nameEn,
    this.rating,
    this.releaseArea,
    this.releaseDate,
  });

  final int buyTicketStatus;
  final String commentSpecial;
  final String img;
  final bool isFilter;
  final String isPlay;
  final bool isWantSee;
  final int movieId;
  final String movieType;
  final String name;
  final String nameEn;
  final String rating;
  final Release releaseArea;
  final String releaseDate;

  factory VideoPieceSingleDetailsPurpleRelatedMovieModel.fromJson(String str) => VideoPieceSingleDetailsPurpleRelatedMovieModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsPurpleRelatedMovieModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsPurpleRelatedMovieModel(
    buyTicketStatus: json["buyTicketStatus"] == null ? null : json["buyTicketStatus"],
    commentSpecial: json["commentSpecial"] == null ? null : json["commentSpecial"],
    img: json["img"] == null ? null : json["img"],
    isFilter: json["isFilter"] == null ? null : json["isFilter"],
    isPlay: json["isPlay"] == null ? null : json["isPlay"],
    isWantSee: json["isWantSee"] == null ? null : json["isWantSee"],
    movieId: json["movieId"] == null ? null : json["movieId"],
    movieType: json["movieType"] == null ? null : json["movieType"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
    rating: json["rating"] == null ? null : json["rating"],
    releaseArea: json["releaseArea"] == null ? null : releaseValues.map[json["releaseArea"]],
    releaseDate: json["releaseDate"] == null ? null : json["releaseDate"],
  );

  Map<String, dynamic> toMap() => {
    "buyTicketStatus": buyTicketStatus == null ? null : buyTicketStatus,
    "commentSpecial": commentSpecial == null ? null : commentSpecial,
    "img": img == null ? null : img,
    "isFilter": isFilter == null ? null : isFilter,
    "isPlay": isPlay == null ? null : isPlay,
    "isWantSee": isWantSee == null ? null : isWantSee,
    "movieId": movieId == null ? null : movieId,
    "movieType": movieType == null ? null : movieType,
    "name": name == null ? null : name,
    "nameEn": nameEn == null ? null : nameEn,
    "rating": rating == null ? null : rating,
    "releaseArea": releaseArea == null ? null : releaseValues.reverse[releaseArea],
    "releaseDate": releaseDate == null ? null : releaseDate,
  };
}

enum Release { EMPTY, RELEASE }

final releaseValues = EnumValues({
  "美国": Release.EMPTY,
  "中国": Release.RELEASE
});

class VideoPieceSingleDetailsRelatedMovieElementModel {
  VideoPieceSingleDetailsRelatedMovieElementModel({
    this.img,
    this.movieId,
    this.name,
    this.nameEn,
  });

  final String img;
  final int movieId;
  final String name;
  final String nameEn;

  factory VideoPieceSingleDetailsRelatedMovieElementModel.fromJson(String str) => VideoPieceSingleDetailsRelatedMovieElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsRelatedMovieElementModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsRelatedMovieElementModel(
    img: json["img"] == null ? null : json["img"],
    movieId: json["movieId"] == null ? null : json["movieId"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
  );

  Map<String, dynamic> toMap() => {
    "img": img == null ? null : img,
    "movieId": movieId == null ? null : movieId,
    "name": name == null ? null : name,
    "nameEn": nameEn == null ? null : nameEn,
  };
}

class VideoPieceSingleDetailsRelatedObjListModel {
  VideoPieceSingleDetailsRelatedObjListModel({
    this.relatedObjId,
    this.relatedObjType,
  });

  final int relatedObjId;
  final int relatedObjType;

  factory VideoPieceSingleDetailsRelatedObjListModel.fromJson(String str) => VideoPieceSingleDetailsRelatedObjListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsRelatedObjListModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsRelatedObjListModel(
    relatedObjId: json["relatedObjId"] == null ? null : json["relatedObjId"],
    relatedObjType: json["relatedObjType"] == null ? null : json["relatedObjType"],
  );

  Map<String, dynamic> toMap() => {
    "relatedObjId": relatedObjId == null ? null : relatedObjId,
    "relatedObjType": relatedObjType == null ? null : relatedObjType,
  };
}

class VideoPieceSingleDetailsTopListModel {
  VideoPieceSingleDetailsTopListModel({
    this.movies,
    this.persons,
    this.totalCount,
    this.type,
  });

  final List<VideoPieceSingleDetailsMovieModel> movies;
  final List<dynamic> persons;
  final int totalCount;
  final int type;

  factory VideoPieceSingleDetailsTopListModel.fromJson(String str) => VideoPieceSingleDetailsTopListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsTopListModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsTopListModel(
    movies: json["movies"] == null ? null : List<VideoPieceSingleDetailsMovieModel>.from(json["movies"].map((x) => VideoPieceSingleDetailsMovieModel.fromMap(x))),
    persons: json["persons"] == null ? null : List<dynamic>.from(json["persons"].map((x) => x)),
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() => {
    "movies": movies == null ? null : List<dynamic>.from(movies.map((x) => x.toMap())),
    "persons": persons == null ? null : List<dynamic>.from(persons.map((x) => x)),
    "totalCount": totalCount == null ? null : totalCount,
    "type": type == null ? null : type,
  };
}

class VideoPieceSingleDetailsMovieModel {
  VideoPieceSingleDetailsMovieModel({
    this.actor,
    this.currentUserWantSee,
    this.decade,
    this.director,
    this.img,
    this.isPlay,
    this.movieId,
    this.movieType,
    this.name,
    this.nameEn,
    this.rankNum,
    this.rating,
    this.releaseDate,
    this.releaseLocation,
    this.remark,
  });

  final String actor;
  final bool currentUserWantSee;
  final int decade;
  final String director;
  final String img;
  final String isPlay;
  final int movieId;
  final String movieType;
  final String name;
  final String nameEn;
  final int rankNum;
  final String rating;
  final String releaseDate;
  final Release releaseLocation;
  final String remark;

  factory VideoPieceSingleDetailsMovieModel.fromJson(String str) => VideoPieceSingleDetailsMovieModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDetailsMovieModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDetailsMovieModel(
    actor: json["actor"] == null ? null : json["actor"],
    currentUserWantSee: json["currentUserWantSee"] == null ? null : json["currentUserWantSee"],
    decade: json["decade"] == null ? null : json["decade"],
    director: json["director"] == null ? null : json["director"],
    img: json["img"] == null ? null : json["img"],
    isPlay: json["isPlay"] == null ? null : json["isPlay"],
    movieId: json["movieId"] == null ? null : json["movieId"],
    movieType: json["movieType"] == null ? null : json["movieType"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
    rankNum: json["rankNum"] == null ? null : json["rankNum"],
    rating: json["rating"] == null ? null : json["rating"],
    releaseDate: json["releaseDate"] == null ? null : json["releaseDate"],
    releaseLocation: json["releaseLocation"] == null ? null : releaseValues.map[json["releaseLocation"]],
    remark: json["remark"] == null ? null : json["remark"],
  );

  Map<String, dynamic> toMap() => {
    "actor": actor == null ? null : actor,
    "currentUserWantSee": currentUserWantSee == null ? null : currentUserWantSee,
    "decade": decade == null ? null : decade,
    "director": director == null ? null : director,
    "img": img == null ? null : img,
    "isPlay": isPlay == null ? null : isPlay,
    "movieId": movieId == null ? null : movieId,
    "movieType": movieType == null ? null : movieType,
    "name": name == null ? null : name,
    "nameEn": nameEn == null ? null : nameEn,
    "rankNum": rankNum == null ? null : rankNum,
    "rating": rating == null ? null : rating,
    "releaseDate": releaseDate == null ? null : releaseDate,
    "releaseLocation": releaseLocation == null ? null : releaseValues.reverse[releaseLocation],
    "remark": remark == null ? null : remark,
  };
}

class Video {
  Video();

  factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Video.fromMap(Map<String, dynamic> json) => Video(
  );

  Map<String, dynamic> toMap() => {
  };
}

class PublicInfo {
  PublicInfo({
    this.articleCountDesc,
    this.avatar,
    this.desc,
    this.followCountDesc,
    this.name,
    this.publicId,
  });

  final String articleCountDesc;
  final String avatar;
  final String desc;
  final String followCountDesc;
  final String name;
  final int publicId;

  factory PublicInfo.fromJson(String str) => PublicInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PublicInfo.fromMap(Map<String, dynamic> json) => PublicInfo(
    articleCountDesc: json["articleCountDesc"] == null ? null : json["articleCountDesc"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    desc: json["desc"] == null ? null : json["desc"],
    followCountDesc: json["followCountDesc"] == null ? null : json["followCountDesc"],
    name: json["name"] == null ? null : json["name"],
    publicId: json["publicId"] == null ? null : json["publicId"],
  );

  Map<String, dynamic> toMap() => {
    "articleCountDesc": articleCountDesc == null ? null : articleCountDesc,
    "avatar": avatar == null ? null : avatar,
    "desc": desc == null ? null : desc,
    "followCountDesc": followCountDesc == null ? null : followCountDesc,
    "name": name == null ? null : name,
    "publicId": publicId == null ? null : publicId,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
