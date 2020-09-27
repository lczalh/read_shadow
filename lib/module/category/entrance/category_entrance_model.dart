// To parse this JSON data, do
//
//     final categoryEntranceWidget = categoryEntranceWidgetFromMap(jsonString);

import 'dart:convert';

class CategoryEntranceModel {
  CategoryEntranceModel({
    this.code,
    this.data,
    this.msg,
    this.showMsg,
  });

  final String code;
  final CategoryEntranceDataModel data;
  final String msg;
  final String showMsg;

  factory CategoryEntranceModel.fromJson(String str) => CategoryEntranceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryEntranceModel.fromMap(Map<String, dynamic> json) => CategoryEntranceModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : CategoryEntranceDataModel.fromMap(json["data"]),
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

class CategoryEntranceDataModel {
  CategoryEntranceDataModel({
    this.movieModelList,
    this.pageNum,
    this.totalCount,
  });

  final List<CategoryEntranceMovieModelListModel> movieModelList;
  final int pageNum;
  final int totalCount;

  factory CategoryEntranceDataModel.fromJson(String str) => CategoryEntranceDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryEntranceDataModel.fromMap(Map<String, dynamic> json) => CategoryEntranceDataModel(
    movieModelList: json["movieModelList"] == null ? null : List<CategoryEntranceMovieModelListModel>.from(json["movieModelList"].map((x) => CategoryEntranceMovieModelListModel.fromMap(x))),
    pageNum: json["pageNum"] == null ? null : json["pageNum"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
  );

  Map<String, dynamic> toMap() => {
    "movieModelList": movieModelList == null ? null : List<dynamic>.from(movieModelList.map((x) => x.toMap())),
    "pageNum": pageNum == null ? null : pageNum,
    "totalCount": totalCount == null ? null : totalCount,
  };
}

class CategoryEntranceMovieModelListModel {
  CategoryEntranceMovieModelListModel({
    this.canPlay,
    this.img,
    this.length,
    this.movieId,
    this.rYear,
    this.ratingFinal,
    this.titleCn,
    this.titleEn,
    this.type,
  });

  final int canPlay;
  final String img;
  final int length;
  final int movieId;
  final int rYear;
  final double ratingFinal;
  final String titleCn;
  final String titleEn;
  final String type;

  factory CategoryEntranceMovieModelListModel.fromJson(String str) => CategoryEntranceMovieModelListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryEntranceMovieModelListModel.fromMap(Map<String, dynamic> json) => CategoryEntranceMovieModelListModel(
    canPlay: json["canPlay"] == null ? null : json["canPlay"],
    img: json["img"] == null ? null : json["img"],
    length: json["length"] == null ? null : json["length"],
    movieId: json["movieId"] == null ? null : json["movieId"],
    rYear: json["rYear"] == null ? null : json["rYear"],
    ratingFinal: json["ratingFinal"] == null ? null : json["ratingFinal"].toDouble(),
    titleCn: json["titleCn"] == null ? null : json["titleCn"],
    titleEn: json["titleEn"] == null ? null : json["titleEn"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() => {
    "canPlay": canPlay == null ? null : canPlay,
    "img": img == null ? null : img,
    "length": length == null ? null : length,
    "movieId": movieId == null ? null : movieId,
    "rYear": rYear == null ? null : rYear,
    "ratingFinal": ratingFinal == null ? null : ratingFinal,
    "titleCn": titleCn == null ? null : titleCn,
    "titleEn": titleEn == null ? null : titleEn,
    "type": type == null ? null : type,
  };
}
