// To parse this JSON data, do
//
//     final movieSearchModel = movieSearchModelFromMap(jsonString);

import 'dart:convert';

class MovieSearchModel {
  MovieSearchModel({
    this.code,
    this.msg,
    this.page,
    this.pagecount,
    this.limit,
    this.total,
    this.list,
  });

  final int code;
  final String msg;
  final int page;
  final int pagecount;
  final String limit;
  final int total;
  final List<MovieSearchListElementModel> list;

  factory MovieSearchModel.fromJson(String str) => MovieSearchModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieSearchModel.fromMap(Map<String, dynamic> json) => MovieSearchModel(
    code: json["code"] == null ? null : json["code"],
    msg: json["msg"] == null ? null : json["msg"],
    page: json["page"] == null ? null : json["page"],
    pagecount: json["pagecount"] == null ? null : json["pagecount"],
    limit: json["limit"] == null ? null : json["limit"],
    total: json["total"] == null ? null : json["total"],
    list: json["list"] == null ? null : List<MovieSearchListElementModel>.from(json["list"].map((x) => MovieSearchListElementModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "msg": msg == null ? null : msg,
    "page": page == null ? null : page,
    "pagecount": pagecount == null ? null : pagecount,
    "limit": limit == null ? null : limit,
    "total": total == null ? null : total,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class MovieSearchListElementModel {
  MovieSearchListElementModel({
    this.vodId,
    this.typeId,
    this.typeId1,
    this.groupId,
    this.vodName,
    this.vodSub,
    this.vodEn,
    this.vodStatus,
    this.vodLetter,
    this.vodColor,
    this.vodTag,
    this.vodClass,
    this.vodPic,
    this.vodPicThumb,
    this.vodPicSlide,
    this.vodActor,
    this.vodDirector,
    this.vodWriter,
    this.vodBehind,
    this.vodBlurb,
    this.vodRemarks,
    this.vodPubdate,
    this.vodTotal,
    this.vodSerial,
    this.vodTv,
    this.vodWeekday,
    this.vodArea,
    this.vodLang,
    this.vodYear,
    this.vodVersion,
    this.vodState,
    this.vodAuthor,
    this.vodJumpurl,
    this.vodTpl,
    this.vodTplPlay,
    this.vodTplDown,
    this.vodIsend,
    this.vodLock,
    this.vodLevel,
    this.vodCopyright,
    this.vodPoints,
    this.vodPointsPlay,
    this.vodPointsDown,
    this.vodHits,
    this.vodHitsDay,
    this.vodHitsWeek,
    this.vodHitsMonth,
    this.vodDuration,
    this.vodUp,
    this.vodDown,
    this.vodScore,
    this.vodScoreAll,
    this.vodScoreNum,
    this.vodTime,
    this.vodTimeAdd,
    this.vodTimeHits,
    this.vodTimeMake,
    this.vodTrysee,
    this.vodDoubanId,
    this.vodDoubanScore,
    this.vodReurl,
    this.vodRelVod,
    this.vodRelArt,
    this.vodPwd,
    this.vodPwdUrl,
    this.vodPwdPlay,
    this.vodPwdPlayUrl,
    this.vodPwdDown,
    this.vodPwdDownUrl,
    this.vodContent,
    this.vodPlayFrom,
    this.vodPlayServer,
    this.vodPlayNote,
    this.vodPlayUrl,
    this.vodDownFrom,
    this.vodDownServer,
    this.vodDownNote,
    this.vodDownUrl,
    this.vodPlot,
    this.vodPlotName,
    this.vodPlotDetail,
    this.typeName,
  });

  final int vodId;
  final int typeId;
  final int typeId1;
  final int groupId;
  final String vodName;
  final String vodSub;
  final String vodEn;
  final int vodStatus;
  final String vodLetter;
  final String vodColor;
  final String vodTag;
  final String vodClass;
  final String vodPic;
  final String vodPicThumb;
  final String vodPicSlide;
  final String vodActor;
  final String vodDirector;
  final String vodWriter;
  final String vodBehind;
  final String vodBlurb;
  final String vodRemarks;
  final String vodPubdate;
  final int vodTotal;
  final String vodSerial;
  final String vodTv;
  final String vodWeekday;
  final String vodArea;
  final String vodLang;
  final String vodYear;
  final String vodVersion;
  final String vodState;
  final String vodAuthor;
  final String vodJumpurl;
  final String vodTpl;
  final String vodTplPlay;
  final String vodTplDown;
  final int vodIsend;
  final int vodLock;
  final int vodLevel;
  final int vodCopyright;
  final int vodPoints;
  final int vodPointsPlay;
  final int vodPointsDown;
  final int vodHits;
  final int vodHitsDay;
  final int vodHitsWeek;
  final int vodHitsMonth;
  final String vodDuration;
  final int vodUp;
  final int vodDown;
  final String vodScore;
  final int vodScoreAll;
  final int vodScoreNum;
  final DateTime vodTime;
  final int vodTimeAdd;
  final int vodTimeHits;
  final int vodTimeMake;
  final int vodTrysee;
  final int vodDoubanId;
  final String vodDoubanScore;
  final String vodReurl;
  final String vodRelVod;
  final String vodRelArt;
  final String vodPwd;
  final String vodPwdUrl;
  final String vodPwdPlay;
  final String vodPwdPlayUrl;
  final String vodPwdDown;
  final String vodPwdDownUrl;
  final String vodContent;
  final String vodPlayFrom;
  final String vodPlayServer;
  final String vodPlayNote;
  final String vodPlayUrl;
  final String vodDownFrom;
  final String vodDownServer;
  final String vodDownNote;
  final String vodDownUrl;
  final int vodPlot;
  final String vodPlotName;
  final String vodPlotDetail;
  final String typeName;

  factory MovieSearchListElementModel.fromJson(String str) => MovieSearchListElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieSearchListElementModel.fromMap(Map<String, dynamic> json) => MovieSearchListElementModel(
    vodId: json["vod_id"] == null ? null : json["vod_id"],
    typeId: json["type_id"] == null ? null : json["type_id"],
    typeId1: json["type_id_1"] == null ? null : json["type_id_1"],
    groupId: json["group_id"] == null ? null : json["group_id"],
    vodName: json["vod_name"] == null ? null : json["vod_name"],
    vodSub: json["vod_sub"] == null ? null : json["vod_sub"],
    vodEn: json["vod_en"] == null ? null : json["vod_en"],
    vodStatus: json["vod_status"] == null ? null : json["vod_status"],
    vodLetter: json["vod_letter"] == null ? null : json["vod_letter"],
    vodColor: json["vod_color"] == null ? null : json["vod_color"],
    vodTag: json["vod_tag"] == null ? null : json["vod_tag"],
    vodClass: json["vod_class"] == null ? null : json["vod_class"],
    vodPic: json["vod_pic"] == null ? null : json["vod_pic"],
    vodPicThumb: json["vod_pic_thumb"] == null ? null : json["vod_pic_thumb"],
    vodPicSlide: json["vod_pic_slide"] == null ? null : json["vod_pic_slide"],
    vodActor: json["vod_actor"] == null ? null : json["vod_actor"],
    vodDirector: json["vod_director"] == null ? null : json["vod_director"],
    vodWriter: json["vod_writer"] == null ? null : json["vod_writer"],
    vodBehind: json["vod_behind"] == null ? null : json["vod_behind"],
    vodBlurb: json["vod_blurb"] == null ? null : json["vod_blurb"],
    vodRemarks: json["vod_remarks"] == null ? null : json["vod_remarks"],
    vodPubdate: json["vod_pubdate"] == null ? null : json["vod_pubdate"],
    vodTotal: json["vod_total"] == null ? null : json["vod_total"],
    vodSerial: json["vod_serial"] == null ? null : json["vod_serial"],
    vodTv: json["vod_tv"] == null ? null : json["vod_tv"],
    vodWeekday: json["vod_weekday"] == null ? null : json["vod_weekday"],
    vodArea: json["vod_area"] == null ? null : json["vod_area"],
    vodLang: json["vod_lang"] == null ? null : json["vod_lang"],
    vodYear: json["vod_year"] == null ? null : json["vod_year"],
    vodVersion: json["vod_version"] == null ? null : json["vod_version"],
    vodState: json["vod_state"] == null ? null : json["vod_state"],
    vodAuthor: json["vod_author"] == null ? null : json["vod_author"],
    vodJumpurl: json["vod_jumpurl"] == null ? null : json["vod_jumpurl"],
    vodTpl: json["vod_tpl"] == null ? null : json["vod_tpl"],
    vodTplPlay: json["vod_tpl_play"] == null ? null : json["vod_tpl_play"],
    vodTplDown: json["vod_tpl_down"] == null ? null : json["vod_tpl_down"],
    vodIsend: json["vod_isend"] == null ? null : json["vod_isend"],
    vodLock: json["vod_lock"] == null ? null : json["vod_lock"],
    vodLevel: json["vod_level"] == null ? null : json["vod_level"],
    vodCopyright: json["vod_copyright"] == null ? null : json["vod_copyright"],
    vodPoints: json["vod_points"] == null ? null : json["vod_points"],
    vodPointsPlay: json["vod_points_play"] == null ? null : json["vod_points_play"],
    vodPointsDown: json["vod_points_down"] == null ? null : json["vod_points_down"],
    vodHits: json["vod_hits"] == null ? null : json["vod_hits"],
    vodHitsDay: json["vod_hits_day"] == null ? null : json["vod_hits_day"],
    vodHitsWeek: json["vod_hits_week"] == null ? null : json["vod_hits_week"],
    vodHitsMonth: json["vod_hits_month"] == null ? null : json["vod_hits_month"],
    vodDuration: json["vod_duration"] == null ? null : json["vod_duration"],
    vodUp: json["vod_up"] == null ? null : json["vod_up"],
    vodDown: json["vod_down"] == null ? null : json["vod_down"],
    vodScore: json["vod_score"] == null ? null : json["vod_score"],
    vodScoreAll: json["vod_score_all"] == null ? null : json["vod_score_all"],
    vodScoreNum: json["vod_score_num"] == null ? null : json["vod_score_num"],
    vodTime: json["vod_time"] == null ? null : DateTime.parse(json["vod_time"]),
    vodTimeAdd: json["vod_time_add"] == null ? null : json["vod_time_add"],
    vodTimeHits: json["vod_time_hits"] == null ? null : json["vod_time_hits"],
    vodTimeMake: json["vod_time_make"] == null ? null : json["vod_time_make"],
    vodTrysee: json["vod_trysee"] == null ? null : json["vod_trysee"],
    vodDoubanId: json["vod_douban_id"] == null ? null : json["vod_douban_id"],
    vodDoubanScore: json["vod_douban_score"] == null ? null : json["vod_douban_score"],
    vodReurl: json["vod_reurl"] == null ? null : json["vod_reurl"],
    vodRelVod: json["vod_rel_vod"] == null ? null : json["vod_rel_vod"],
    vodRelArt: json["vod_rel_art"] == null ? null : json["vod_rel_art"],
    vodPwd: json["vod_pwd"] == null ? null : json["vod_pwd"],
    vodPwdUrl: json["vod_pwd_url"] == null ? null : json["vod_pwd_url"],
    vodPwdPlay: json["vod_pwd_play"] == null ? null : json["vod_pwd_play"],
    vodPwdPlayUrl: json["vod_pwd_play_url"] == null ? null : json["vod_pwd_play_url"],
    vodPwdDown: json["vod_pwd_down"] == null ? null : json["vod_pwd_down"],
    vodPwdDownUrl: json["vod_pwd_down_url"] == null ? null : json["vod_pwd_down_url"],
    vodContent: json["vod_content"] == null ? null : json["vod_content"],
    vodPlayFrom: json["vod_play_from"] == null ? null : json["vod_play_from"],
    vodPlayServer: json["vod_play_server"] == null ? null : json["vod_play_server"],
    vodPlayNote: json["vod_play_note"] == null ? null : json["vod_play_note"],
    vodPlayUrl: json["vod_play_url"] == null ? null : json["vod_play_url"],
    vodDownFrom: json["vod_down_from"] == null ? null : json["vod_down_from"],
    vodDownServer: json["vod_down_server"] == null ? null : json["vod_down_server"],
    vodDownNote: json["vod_down_note"] == null ? null : json["vod_down_note"],
    vodDownUrl: json["vod_down_url"] == null ? null : json["vod_down_url"],
    vodPlot: json["vod_plot"] == null ? null : json["vod_plot"],
    vodPlotName: json["vod_plot_name"] == null ? null : json["vod_plot_name"],
    vodPlotDetail: json["vod_plot_detail"] == null ? null : json["vod_plot_detail"],
    typeName: json["type_name"] == null ? null : json["type_name"],
  );

  Map<String, dynamic> toMap() => {
    "vod_id": vodId == null ? null : vodId,
    "type_id": typeId == null ? null : typeId,
    "type_id_1": typeId1 == null ? null : typeId1,
    "group_id": groupId == null ? null : groupId,
    "vod_name": vodName == null ? null : vodName,
    "vod_sub": vodSub == null ? null : vodSub,
    "vod_en": vodEn == null ? null : vodEn,
    "vod_status": vodStatus == null ? null : vodStatus,
    "vod_letter": vodLetter == null ? null : vodLetter,
    "vod_color": vodColor == null ? null : vodColor,
    "vod_tag": vodTag == null ? null : vodTag,
    "vod_class": vodClass == null ? null : vodClass,
    "vod_pic": vodPic == null ? null : vodPic,
    "vod_pic_thumb": vodPicThumb == null ? null : vodPicThumb,
    "vod_pic_slide": vodPicSlide == null ? null : vodPicSlide,
    "vod_actor": vodActor == null ? null : vodActor,
    "vod_director": vodDirector == null ? null : vodDirector,
    "vod_writer": vodWriter == null ? null : vodWriter,
    "vod_behind": vodBehind == null ? null : vodBehind,
    "vod_blurb": vodBlurb == null ? null : vodBlurb,
    "vod_remarks": vodRemarks == null ? null : vodRemarks,
    "vod_pubdate": vodPubdate == null ? null : vodPubdate,
    "vod_total": vodTotal == null ? null : vodTotal,
    "vod_serial": vodSerial == null ? null : vodSerial,
    "vod_tv": vodTv == null ? null : vodTv,
    "vod_weekday": vodWeekday == null ? null : vodWeekday,
    "vod_area": vodArea == null ? null : vodArea,
    "vod_lang": vodLang == null ? null : vodLang,
    "vod_year": vodYear == null ? null : vodYear,
    "vod_version": vodVersion == null ? null : vodVersion,
    "vod_state": vodState == null ? null : vodState,
    "vod_author": vodAuthor == null ? null : vodAuthor,
    "vod_jumpurl": vodJumpurl == null ? null : vodJumpurl,
    "vod_tpl": vodTpl == null ? null : vodTpl,
    "vod_tpl_play": vodTplPlay == null ? null : vodTplPlay,
    "vod_tpl_down": vodTplDown == null ? null : vodTplDown,
    "vod_isend": vodIsend == null ? null : vodIsend,
    "vod_lock": vodLock == null ? null : vodLock,
    "vod_level": vodLevel == null ? null : vodLevel,
    "vod_copyright": vodCopyright == null ? null : vodCopyright,
    "vod_points": vodPoints == null ? null : vodPoints,
    "vod_points_play": vodPointsPlay == null ? null : vodPointsPlay,
    "vod_points_down": vodPointsDown == null ? null : vodPointsDown,
    "vod_hits": vodHits == null ? null : vodHits,
    "vod_hits_day": vodHitsDay == null ? null : vodHitsDay,
    "vod_hits_week": vodHitsWeek == null ? null : vodHitsWeek,
    "vod_hits_month": vodHitsMonth == null ? null : vodHitsMonth,
    "vod_duration": vodDuration == null ? null : vodDuration,
    "vod_up": vodUp == null ? null : vodUp,
    "vod_down": vodDown == null ? null : vodDown,
    "vod_score": vodScore == null ? null : vodScore,
    "vod_score_all": vodScoreAll == null ? null : vodScoreAll,
    "vod_score_num": vodScoreNum == null ? null : vodScoreNum,
    "vod_time": vodTime == null ? null : vodTime.toIso8601String(),
    "vod_time_add": vodTimeAdd == null ? null : vodTimeAdd,
    "vod_time_hits": vodTimeHits == null ? null : vodTimeHits,
    "vod_time_make": vodTimeMake == null ? null : vodTimeMake,
    "vod_trysee": vodTrysee == null ? null : vodTrysee,
    "vod_douban_id": vodDoubanId == null ? null : vodDoubanId,
    "vod_douban_score": vodDoubanScore == null ? null : vodDoubanScore,
    "vod_reurl": vodReurl == null ? null : vodReurl,
    "vod_rel_vod": vodRelVod == null ? null : vodRelVod,
    "vod_rel_art": vodRelArt == null ? null : vodRelArt,
    "vod_pwd": vodPwd == null ? null : vodPwd,
    "vod_pwd_url": vodPwdUrl == null ? null : vodPwdUrl,
    "vod_pwd_play": vodPwdPlay == null ? null : vodPwdPlay,
    "vod_pwd_play_url": vodPwdPlayUrl == null ? null : vodPwdPlayUrl,
    "vod_pwd_down": vodPwdDown == null ? null : vodPwdDown,
    "vod_pwd_down_url": vodPwdDownUrl == null ? null : vodPwdDownUrl,
    "vod_content": vodContent == null ? null : vodContent,
    "vod_play_from": vodPlayFrom == null ? null : vodPlayFrom,
    "vod_play_server": vodPlayServer == null ? null : vodPlayServer,
    "vod_play_note": vodPlayNote == null ? null : vodPlayNote,
    "vod_play_url": vodPlayUrl == null ? null : vodPlayUrl,
    "vod_down_from": vodDownFrom == null ? null : vodDownFrom,
    "vod_down_server": vodDownServer == null ? null : vodDownServer,
    "vod_down_note": vodDownNote == null ? null : vodDownNote,
    "vod_down_url": vodDownUrl == null ? null : vodDownUrl,
    "vod_plot": vodPlot == null ? null : vodPlot,
    "vod_plot_name": vodPlotName == null ? null : vodPlotName,
    "vod_plot_detail": vodPlotDetail == null ? null : vodPlotDetail,
    "type_name": typeName == null ? null : typeName,
  };
}
