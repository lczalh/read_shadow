// To parse this JSON data, do
//
//     final videoDetailsFilmCriticsModel = videoDetailsFilmCriticsModelFromMap(jsonString);

import 'dart:convert';

class VideoDetailsFilmCriticsModel {
  VideoDetailsFilmCriticsModel({
    this.code,
    this.data,
    this.msg,
    this.showMsg,
  });

  final String code;
  final VideoDetailsFilmCriticsDataModel data;
  final String msg;
  final String showMsg;

  factory VideoDetailsFilmCriticsModel.fromJson(String str) => VideoDetailsFilmCriticsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsFilmCriticsModel.fromMap(Map<String, dynamic> json) => VideoDetailsFilmCriticsModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : VideoDetailsFilmCriticsDataModel.fromMap(json["data"]),
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

class VideoDetailsFilmCriticsDataModel {
  VideoDetailsFilmCriticsDataModel({
    this.commentTotalCount,
    this.commentTotalCountShow,
    this.mini,
    this.plus,
  });

  final int commentTotalCount;
  final String commentTotalCountShow;
  final VideoDetailsFilmCriticsMiniModel mini;
  final VideoDetailsFilmCriticsPlusModel plus;

  factory VideoDetailsFilmCriticsDataModel.fromJson(String str) => VideoDetailsFilmCriticsDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsFilmCriticsDataModel.fromMap(Map<String, dynamic> json) => VideoDetailsFilmCriticsDataModel(
    commentTotalCount: json["commentTotalCount"] == null ? null : json["commentTotalCount"],
    commentTotalCountShow: json["commentTotalCountShow"] == null ? null : json["commentTotalCountShow"],
    mini: json["mini"] == null ? null : VideoDetailsFilmCriticsMiniModel.fromMap(json["mini"]),
    plus: json["plus"] == null ? null : VideoDetailsFilmCriticsPlusModel.fromMap(json["plus"]),
  );

  Map<String, dynamic> toMap() => {
    "commentTotalCount": commentTotalCount == null ? null : commentTotalCount,
    "commentTotalCountShow": commentTotalCountShow == null ? null : commentTotalCountShow,
    "mini": mini == null ? null : mini.toMap(),
    "plus": plus == null ? null : plus.toMap(),
  };
}

class VideoDetailsFilmCriticsMiniModel {
  VideoDetailsFilmCriticsMiniModel({
    this.list,
    this.total,
  });

  final List<VideoDetailsFilmCriticsMiniListModel> list;
  final int total;

  factory VideoDetailsFilmCriticsMiniModel.fromJson(String str) => VideoDetailsFilmCriticsMiniModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsFilmCriticsMiniModel.fromMap(Map<String, dynamic> json) => VideoDetailsFilmCriticsMiniModel(
    list: json["list"] == null ? null : List<VideoDetailsFilmCriticsMiniListModel>.from(json["list"].map((x) => VideoDetailsFilmCriticsMiniListModel.fromMap(x))),
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toMap() => {
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
    "total": total == null ? null : total,
  };
}

class VideoDetailsFilmCriticsMiniListModel {
  VideoDetailsFilmCriticsMiniListModel({
    this.commentDate,
    this.commentId,
    this.content,
    this.headImg,
    this.img,
    this.isHot,
    this.isPraise,
    this.locationName,
    this.nickname,
    this.praiseCount,
    this.rating,
    this.replyCount,
  });

  final int commentDate;
  final int commentId;
  final String content;
  final String headImg;
  final String img;
  final bool isHot;
  final bool isPraise;
  final String locationName;
  final String nickname;
  final int praiseCount;
  final double rating;
  final int replyCount;

  factory VideoDetailsFilmCriticsMiniListModel.fromJson(String str) => VideoDetailsFilmCriticsMiniListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsFilmCriticsMiniListModel.fromMap(Map<String, dynamic> json) => VideoDetailsFilmCriticsMiniListModel(
    commentDate: json["commentDate"] == null ? null : json["commentDate"],
    commentId: json["commentId"] == null ? null : json["commentId"],
    content: json["content"] == null ? null : json["content"],
    headImg: json["headImg"] == null ? null : json["headImg"],
    img: json["img"] == null ? null : json["img"],
    isHot: json["isHot"] == null ? null : json["isHot"],
    isPraise: json["isPraise"] == null ? null : json["isPraise"],
    locationName: json["locationName"] == null ? null : json["locationName"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    praiseCount: json["praiseCount"] == null ? null : json["praiseCount"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    replyCount: json["replyCount"] == null ? null : json["replyCount"],
  );

  Map<String, dynamic> toMap() => {
    "commentDate": commentDate == null ? null : commentDate,
    "commentId": commentId == null ? null : commentId,
    "content": content == null ? null : content,
    "headImg": headImg == null ? null : headImg,
    "img": img == null ? null : img,
    "isHot": isHot == null ? null : isHot,
    "isPraise": isPraise == null ? null : isPraise,
    "locationName": locationName == null ? null : locationName,
    "nickname": nickname == null ? null : nickname,
    "praiseCount": praiseCount == null ? null : praiseCount,
    "rating": rating == null ? null : rating,
    "replyCount": replyCount == null ? null : replyCount,
  };
}

class VideoDetailsFilmCriticsPlusModel {
  VideoDetailsFilmCriticsPlusModel({
    this.clientPublish,
    this.list,
    this.total,
  });

  final bool clientPublish;
  final List<VideoDetailsFilmCriticsPlusListModel> list;
  final int total;

  factory VideoDetailsFilmCriticsPlusModel.fromJson(String str) => VideoDetailsFilmCriticsPlusModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsFilmCriticsPlusModel.fromMap(Map<String, dynamic> json) => VideoDetailsFilmCriticsPlusModel(
    clientPublish: json["clientPublish"] == null ? null : json["clientPublish"],
    list: json["list"] == null ? null : List<VideoDetailsFilmCriticsPlusListModel>.from(json["list"].map((x) => VideoDetailsFilmCriticsPlusListModel.fromMap(x))),
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toMap() => {
    "clientPublish": clientPublish == null ? null : clientPublish,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
    "total": total == null ? null : total,
  };
}

class VideoDetailsFilmCriticsPlusListModel {
  VideoDetailsFilmCriticsPlusListModel({
    this.commentDate,
    this.commentId,
    this.content,
    this.headImg,
    this.isWantSee,
    this.locationName,
    this.nickname,
    this.rating,
    this.replyCount,
    this.title,
    this.userId,
  });

  final int commentDate;
  final int commentId;
  final String content;
  final String headImg;
  final bool isWantSee;
  final String locationName;
  final String nickname;
  final double rating;
  final int replyCount;
  final String title;
  final int userId;

  factory VideoDetailsFilmCriticsPlusListModel.fromJson(String str) => VideoDetailsFilmCriticsPlusListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsFilmCriticsPlusListModel.fromMap(Map<String, dynamic> json) => VideoDetailsFilmCriticsPlusListModel(
    commentDate: json["commentDate"] == null ? null : json["commentDate"],
    commentId: json["commentId"] == null ? null : json["commentId"],
    content: json["content"] == null ? null : json["content"],
    headImg: json["headImg"] == null ? null : json["headImg"],
    isWantSee: json["isWantSee"] == null ? null : json["isWantSee"],
    locationName: json["locationName"] == null ? null : json["locationName"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    replyCount: json["replyCount"] == null ? null : json["replyCount"],
    title: json["title"] == null ? null : json["title"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toMap() => {
    "commentDate": commentDate == null ? null : commentDate,
    "commentId": commentId == null ? null : commentId,
    "content": content == null ? null : content,
    "headImg": headImg == null ? null : headImg,
    "isWantSee": isWantSee == null ? null : isWantSee,
    "locationName": locationName == null ? null : locationName,
    "nickname": nickname == null ? null : nickname,
    "rating": rating == null ? null : rating,
    "replyCount": replyCount == null ? null : replyCount,
    "title": title == null ? null : title,
    "userId": userId == null ? null : userId,
  };
}
