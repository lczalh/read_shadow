// To parse this JSON data, do
//
//     final videoRecommendSwiperModel = videoRecommendSwiperModelFromMap(jsonString);

import 'dart:convert';

class VideoRecommendSwiperModel {
  VideoRecommendSwiperModel({
    this.code,
    this.data,
    this.msg,
    this.showMsg,
  });

  final String code;
  final VideoRecommendSwiperDataModel data;
  final String msg;
  final String showMsg;

  factory VideoRecommendSwiperModel.fromJson(String str) => VideoRecommendSwiperModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoRecommendSwiperModel.fromMap(Map<String, dynamic> json) => VideoRecommendSwiperModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : VideoRecommendSwiperDataModel.fromMap(json["data"]),
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

class VideoRecommendSwiperDataModel {
  VideoRecommendSwiperDataModel({
    this.list,
  });

  final List<VideoRecommendSwiperListElementModel> list;

  factory VideoRecommendSwiperDataModel.fromJson(String str) => VideoRecommendSwiperDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoRecommendSwiperDataModel.fromMap(Map<String, dynamic> json) => VideoRecommendSwiperDataModel(
    list: json["list"] == null ? null : List<VideoRecommendSwiperListElementModel>.from(json["list"].map((x) => VideoRecommendSwiperListElementModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class VideoRecommendSwiperListElementModel {
  VideoRecommendSwiperListElementModel({
    this.articleId,
    this.img,
    this.title,
  });

  final int articleId;
  final String img;
  final String title;

  factory VideoRecommendSwiperListElementModel.fromJson(String str) => VideoRecommendSwiperListElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoRecommendSwiperListElementModel.fromMap(Map<String, dynamic> json) => VideoRecommendSwiperListElementModel(
    articleId: json["articleId"] == null ? null : json["articleId"],
    img: json["img"] == null ? null : json["img"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "articleId": articleId == null ? null : articleId,
    "img": img == null ? null : img,
    "title": title == null ? null : title,
  };
}
