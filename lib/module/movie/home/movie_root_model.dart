// To parse this JSON data, do
//
//     final movieRootModel = movieRootModelFromMap(jsonString);

import 'dart:convert';

class MovieRootModel {
  MovieRootModel({
    this.status,
    this.page,
    this.data,
    this.list,
  });

  final int status;
  final Page page;
  final List<MovieDataModel> data;
  final List<MovieListModel> list;

  factory MovieRootModel.fromJson(String str) => MovieRootModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieRootModel.fromMap(Map<String, dynamic> json) => MovieRootModel(
    status: json["status"] == null ? null : json["status"],
    page: json["page"] == null ? null : Page.fromMap(json["page"]),
    data: json["data"] == null ? null : List<MovieDataModel>.from(json["data"].map((x) => MovieDataModel.fromMap(x))),
    list: json["list"] == null ? null : List<MovieListModel>.from(json["list"].map((x) => MovieListModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "page": page == null ? null : page.toMap(),
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class MovieDataModel {
  MovieDataModel({
    this.vodId,
    this.vodCid,
    this.vodName,
    this.vodTitle,
    this.vodType,
    this.vodKeywords,
    this.vodActor,
    this.vodDirector,
    this.vodContent,
    this.vodPic,
    this.vodArea,
    this.vodLanguage,
    this.vodYear,
    this.vodAddtime,
    this.vodFilmtime,
    this.vodServer,
    this.vodPlay,
    this.vodUrl,
    this.vodInputer,
    this.vodReurl,
    this.vodLength,
    this.vodWeekday,
    this.vodCopyright,
    this.vodState,
    this.vodVersion,
    this.vodTv,
    this.vodTotal,
    this.vodContinu,
    this.vodStatus,
    this.vodStars,
    this.vodHits,
    this.vodIsend,
    this.vodDoubanId,
    this.vodSeries,
    this.listName,
  });

  final String vodId;
  final String vodCid;
  final String vodName;
  final String vodTitle;
  final String vodType;
  final String vodKeywords;
  final String vodActor;
  final String vodDirector;
  final String vodContent;
  final String vodPic;
  final String vodArea;
  final String vodLanguage;
  final String vodYear;
  final DateTime vodAddtime;
  final int vodFilmtime;
  final String vodServer;
  final VodPlay vodPlay;
  final String vodUrl;
  final dynamic vodInputer;
  final String vodReurl;
  final int vodLength;
  final dynamic vodWeekday;
  final int vodCopyright;
  final String vodState;
  final String vodVersion;
  final String vodTv;
  final int vodTotal;
  final String vodContinu;
  final int vodStatus;
  final int vodStars;
  final dynamic vodHits;
  final int vodIsend;
  final int vodDoubanId;
  final String vodSeries;
  final String listName;

  factory MovieDataModel.fromJson(String str) => MovieDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieDataModel.fromMap(Map<String, dynamic> json) => MovieDataModel(
    vodId: json["vod_id"] == null ? null : json["vod_id"],
    vodCid: json["vod_cid"] == null ? null : json["vod_cid"],
    vodName: json["vod_name"] == null ? null : json["vod_name"],
    vodTitle: json["vod_title"] == null ? null : json["vod_title"],
    vodType: json["vod_type"] == null ? null : json["vod_type"],
    vodKeywords: json["vod_keywords"] == null ? null : json["vod_keywords"],
    vodActor: json["vod_actor"] == null ? null : json["vod_actor"],
    vodDirector: json["vod_director"] == null ? null : json["vod_director"],
    vodContent: json["vod_content"] == null ? null : json["vod_content"],
    vodPic: json["vod_pic"] == null ? null : json["vod_pic"],
    vodArea: json["vod_area"] == null ? null : json["vod_area"],
    vodLanguage: json["vod_language"] == null ? null : json["vod_language"],
    vodYear: json["vod_year"] == null ? null : json["vod_year"],
    vodAddtime: json["vod_addtime"] == null ? null : DateTime.parse(json["vod_addtime"]),
    vodFilmtime: json["vod_filmtime"] == null ? null : json["vod_filmtime"],
    vodServer: json["vod_server"] == null ? null : json["vod_server"],
    vodPlay: json["vod_play"] == null ? null : vodPlayValues.map[json["vod_play"]],
    vodUrl: json["vod_url"] == null ? null : json["vod_url"],
    vodInputer: json["vod_inputer"],
    vodReurl: json["vod_reurl"] == null ? null : json["vod_reurl"],
    vodLength: json["vod_length"] == null ? null : json["vod_length"],
    vodWeekday: json["vod_weekday"],
    vodCopyright: json["vod_copyright"] == null ? null : json["vod_copyright"],
    vodState: json["vod_state"] == null ? null : json["vod_state"],
    vodVersion: json["vod_version"] == null ? null : json["vod_version"],
    vodTv: json["vod_tv"] == null ? null : json["vod_tv"],
    vodTotal: json["vod_total"] == null ? null : json["vod_total"],
    vodContinu: json["vod_continu"] == null ? null : json["vod_continu"],
    vodStatus: json["vod_status"] == null ? null : json["vod_status"],
    vodStars: json["vod_stars"] == null ? null : json["vod_stars"],
    vodHits: json["vod_hits"],
    vodIsend: json["vod_isend"] == null ? null : json["vod_isend"],
    vodDoubanId: json["vod_douban_id"] == null ? null : json["vod_douban_id"],
    vodSeries: json["vod_series"] == null ? null : json["vod_series"],
    listName: json["list_name"] == null ? null : json["list_name"],
  );

  Map<String, dynamic> toMap() => {
    "vod_id": vodId == null ? null : vodId,
    "vod_cid": vodCid == null ? null : vodCid,
    "vod_name": vodName == null ? null : vodName,
    "vod_title": vodTitle == null ? null : vodTitle,
    "vod_type": vodType == null ? null : vodType,
    "vod_keywords": vodKeywords == null ? null : vodKeywords,
    "vod_actor": vodActor == null ? null : vodActor,
    "vod_director": vodDirector == null ? null : vodDirector,
    "vod_content": vodContent == null ? null : vodContent,
    "vod_pic": vodPic == null ? null : vodPic,
    "vod_area": vodArea == null ? null : vodArea,
    "vod_language": vodLanguage == null ? null : vodLanguage,
    "vod_year": vodYear == null ? null : vodYear,
    "vod_addtime": vodAddtime == null ? null : vodAddtime.toIso8601String(),
    "vod_filmtime": vodFilmtime == null ? null : vodFilmtime,
    "vod_server": vodServer == null ? null : vodServer,
    "vod_play": vodPlay == null ? null : vodPlayValues.reverse[vodPlay],
    "vod_url": vodUrl == null ? null : vodUrl,
    "vod_inputer": vodInputer,
    "vod_reurl": vodReurl == null ? null : vodReurl,
    "vod_length": vodLength == null ? null : vodLength,
    "vod_weekday": vodWeekday,
    "vod_copyright": vodCopyright == null ? null : vodCopyright,
    "vod_state": vodState == null ? null : vodState,
    "vod_version": vodVersion == null ? null : vodVersion,
    "vod_tv": vodTv == null ? null : vodTv,
    "vod_total": vodTotal == null ? null : vodTotal,
    "vod_continu": vodContinu == null ? null : vodContinu,
    "vod_status": vodStatus == null ? null : vodStatus,
    "vod_stars": vodStars == null ? null : vodStars,
    "vod_hits": vodHits,
    "vod_isend": vodIsend == null ? null : vodIsend,
    "vod_douban_id": vodDoubanId == null ? null : vodDoubanId,
    "vod_series": vodSeries == null ? null : vodSeries,
    "list_name": listName == null ? null : listName,
  };
}

enum VodPlay { KKM3_U8 }

final vodPlayValues = EnumValues({
  "kkm3u8": VodPlay.KKM3_U8
});

class MovieListModel {
  MovieListModel({
    this.listId,
    this.listName,
  });

  final int listId;
  final String listName;

  factory MovieListModel.fromJson(String str) => MovieListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieListModel.fromMap(Map<String, dynamic> json) => MovieListModel(
    listId: json["list_id"] == null ? null : json["list_id"],
    listName: json["list_name"] == null ? null : json["list_name"],
  );

  Map<String, dynamic> toMap() => {
    "list_id": listId == null ? null : listId,
    "list_name": listName == null ? null : listName,
  };
}

class Page {
  Page({
    this.pageindex,
    this.pagecount,
    this.pagesize,
    this.recordcount,
  });

  final String pageindex;
  final String pagecount;
  final String pagesize;
  final String recordcount;

  factory Page.fromJson(String str) => Page.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Page.fromMap(Map<String, dynamic> json) => Page(
    pageindex: json["pageindex"] == null ? null : json["pageindex"],
    pagecount: json["pagecount"] == null ? null : json["pagecount"],
    pagesize: json["pagesize"] == null ? null : json["pagesize"],
    recordcount: json["recordcount"] == null ? null : json["recordcount"],
  );

  Map<String, dynamic> toMap() => {
    "pageindex": pageindex == null ? null : pageindex,
    "pagecount": pagecount == null ? null : pagecount,
    "pagesize": pagesize == null ? null : pagesize,
    "recordcount": recordcount == null ? null : recordcount,
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
