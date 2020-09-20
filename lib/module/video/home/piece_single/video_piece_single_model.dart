// To parse this JSON data, do
//
//     final videoPieceSingleModel = videoPieceSingleModelFromMap(jsonString);

import 'dart:convert';

class VideoPieceSingleModel {
  VideoPieceSingleModel({
    this.code,
    this.data,
    this.msg,
    this.showMsg,
  });

  final String code;
  final VideoPieceSingleDataModel data;
  final String msg;
  final String showMsg;

  factory VideoPieceSingleModel.fromJson(String str) => VideoPieceSingleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : VideoPieceSingleDataModel.fromMap(json["data"]),
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

class VideoPieceSingleDataModel {
  VideoPieceSingleDataModel({
    this.hasMore,
    this.list,
  });

  final bool hasMore;
  final List<VideoPieceSingleListElementModel> list;

  factory VideoPieceSingleDataModel.fromJson(String str) => VideoPieceSingleDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleDataModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleDataModel(
    hasMore: json["hasMore"] == null ? null : json["hasMore"],
    list: json["list"] == null ? null : List<VideoPieceSingleListElementModel>.from(json["list"].map((x) => VideoPieceSingleListElementModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "hasMore": hasMore == null ? null : hasMore,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class VideoPieceSingleListElementModel {
  VideoPieceSingleListElementModel({
    this.articleId,
    this.hasCollected,
    this.movieCount,
    this.movieImg,
    this.personImg,
    this.title,
  });

  final int articleId;
  final bool hasCollected;
  final int movieCount;
  final String movieImg;
  final String personImg;
  final String title;

  factory VideoPieceSingleListElementModel.fromJson(String str) => VideoPieceSingleListElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPieceSingleListElementModel.fromMap(Map<String, dynamic> json) => VideoPieceSingleListElementModel(
    articleId: json["articleId"] == null ? null : json["articleId"],
    hasCollected: json["hasCollected"] == null ? null : json["hasCollected"],
    movieCount: json["movieCount"] == null ? null : json["movieCount"],
    movieImg: json["movieImg"] == null ? null : json["movieImg"],
    personImg: json["personImg"] == null ? null : json["personImg"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "articleId": articleId == null ? null : articleId,
    "hasCollected": hasCollected == null ? null : hasCollected,
    "movieCount": movieCount == null ? null : movieCount,
    "movieImg": movieImg == null ? null : movieImg,
    "personImg": personImg == null ? null : personImg,
    "title": title == null ? null : title,
  };
}
