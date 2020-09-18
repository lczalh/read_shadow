// To parse this JSON data, do
//
//     final videoDetails = videoDetailsFromMap(jsonString);

import 'dart:convert';

class VideoDetailsModel {
  VideoDetailsModel({
    this.code,
    this.data,
    this.msg,
    this.showMsg,
  });

  final String code;
  final VideoDetailsDataModel data;
  final String msg;
  final String showMsg;

  factory VideoDetailsModel.fromJson(String str) => VideoDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsModel.fromMap(Map<String, dynamic> json) => VideoDetailsModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : VideoDetailsDataModel.fromMap(json["data"]),
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

class VideoDetailsDataModel {
  VideoDetailsDataModel({
    this.advertisement,
    this.basic,
    this.boxOffice,
    this.live,
    this.playState,
    this.playlist,
    this.related,
  });

  final VideoDetailsAdvertisementModel advertisement;
  final VideoDetailsBasicModel basic;
  final VideoDetailsBoxOfficeModel boxOffice;
  final VideoDetailsLiveModel live;
  final String playState;
  final List<VideoDetailsPlaylistModel> playlist;
  final VideoDetailsRelatedModel related;

  factory VideoDetailsDataModel.fromJson(String str) => VideoDetailsDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsDataModel.fromMap(Map<String, dynamic> json) => VideoDetailsDataModel(
    advertisement: json["advertisement"] == null ? null : VideoDetailsAdvertisementModel.fromMap(json["advertisement"]),
    basic: json["basic"] == null ? null : VideoDetailsBasicModel.fromMap(json["basic"]),
    boxOffice: json["boxOffice"] == null ? null : VideoDetailsBoxOfficeModel.fromMap(json["boxOffice"]),
    live: json["live"] == null ? null : VideoDetailsLiveModel.fromMap(json["live"]),
    playState: json["playState"] == null ? null : json["playState"],
    playlist: json["playlist"] == null ? null : List<VideoDetailsPlaylistModel>.from(json["playlist"].map((x) => VideoDetailsPlaylistModel.fromMap(x))),
    related: json["related"] == null ? null : VideoDetailsRelatedModel.fromMap(json["related"]),
  );

  Map<String, dynamic> toMap() => {
    "advertisement": advertisement == null ? null : advertisement.toMap(),
    "basic": basic == null ? null : basic.toMap(),
    "boxOffice": boxOffice == null ? null : boxOffice.toMap(),
    "live": live == null ? null : live.toMap(),
    "playState": playState == null ? null : playState,
    "playlist": playlist == null ? null : List<dynamic>.from(playlist.map((x) => x.toMap())),
    "related": related == null ? null : related.toMap(),
  };
}

class VideoDetailsAdvertisementModel {
  VideoDetailsAdvertisementModel({
    this.advList,
    this.count,
    this.error,
    this.success,
  });

  final List<dynamic> advList;
  final int count;
  final String error;
  final bool success;

  factory VideoDetailsAdvertisementModel.fromJson(String str) => VideoDetailsAdvertisementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsAdvertisementModel.fromMap(Map<String, dynamic> json) => VideoDetailsAdvertisementModel(
    advList: json["advList"] == null ? null : List<dynamic>.from(json["advList"].map((x) => x)),
    count: json["count"] == null ? null : json["count"],
    error: json["error"] == null ? null : json["error"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toMap() => {
    "advList": advList == null ? null : List<dynamic>.from(advList.map((x) => x)),
    "count": count == null ? null : count,
    "error": error == null ? null : error,
    "success": success == null ? null : success,
  };
}

class VideoDetailsBasicModel {
  VideoDetailsBasicModel({
    this.actors,
    this.attitude,
    this.award,
    this.bigImage,
    this.broadcastDes,
    this.commentSpecial,
    this.community,
    this.director,
    this.eggDesc,
    this.episodeCnt,
    this.festivals,
    this.hasSeenCount,
    this.hasSeenCountShow,
    this.hotRanking,
    this.img,
    this.is3D,
    this.isDmax,
    this.isEggHunt,
    this.isFavorite,
    this.isFilter,
    this.isImax,
    this.isImax3D,
    this.isTicket,
    this.message,
    this.mins,
    this.movieId,
    this.movieStatus,
    this.name,
    this.nameEn,
    this.overallRating,
    this.personCount,
    this.quizGame,
    this.ratingCount,
    this.ratingCountShow,
    this.releaseArea,
    this.releaseDate,
    this.sensitiveStatus,
    this.showCinemaCount,
    this.showDay,
    this.showtimeCount,
    this.stageImg,
    this.story,
    this.style,
    this.summary,
    this.totalNominateAward,
    this.totalWinAward,
    this.type,
    this.url,
    this.userComment,
    this.userCommentId,
    this.userImg,
    this.userName,
    this.userRating,
    this.video,
    this.wantToSeeCount,
    this.wantToSeeCountShow,
    this.wantToSeeNumberShow,
    this.year,
  });

  final List<VideoDetailsActorModel> actors;
  final int attitude;
  final VideoDetailsAwardModel award;
  final String bigImage;
  final String broadcastDes;
  final String commentSpecial;
  final VideoDetailsBoxOfficeModel community;
  final VideoDetailsDirectorModel director;
  final String eggDesc;
  final String episodeCnt;
  final List<dynamic> festivals;
  final int hasSeenCount;
  final String hasSeenCountShow;
  final int hotRanking;
  final String img;
  final bool is3D;
  final bool isDmax;
  final bool isEggHunt;
  final int isFavorite;
  final bool isFilter;
  final bool isImax;
  final bool isImax3D;
  final bool isTicket;
  final String message;
  final String mins;
  final int movieId;
  final int movieStatus;
  final String name;
  final String nameEn;
  final double overallRating;
  final int personCount;
  final VideoDetailsBoxOfficeModel quizGame;
  final int ratingCount;
  final String ratingCountShow;
  final String releaseArea;
  final String releaseDate;
  final bool sensitiveStatus;
  final int showCinemaCount;
  final int showDay;
  final int showtimeCount;
  final VideoDetailsStageImgModel stageImg;
  final String story;
  final VideoDetailsStyleModel style;
  final String summary;
  final int totalNominateAward;
  final int totalWinAward;
  final List<String> type;
  final String url;
  final String userComment;
  final int userCommentId;
  final String userImg;
  final String userName;
  final int userRating;
  final VideoDetailsVideoModel video;
  final int wantToSeeCount;
  final String wantToSeeCountShow;
  final String wantToSeeNumberShow;
  final String year;

  factory VideoDetailsBasicModel.fromJson(String str) => VideoDetailsBasicModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsBasicModel.fromMap(Map<String, dynamic> json) => VideoDetailsBasicModel(
    actors: json["actors"] == null ? null : List<VideoDetailsActorModel>.from(json["actors"].map((x) => VideoDetailsActorModel.fromMap(x))),
    attitude: json["attitude"] == null ? null : json["attitude"],
    award: json["award"] == null ? null : VideoDetailsAwardModel.fromMap(json["award"]),
    bigImage: json["bigImage"] == null ? null : json["bigImage"],
    broadcastDes: json["broadcastDes"] == null ? null : json["broadcastDes"],
    commentSpecial: json["commentSpecial"] == null ? null : json["commentSpecial"],
    community: json["community"] == null ? null : VideoDetailsBoxOfficeModel.fromMap(json["community"]),
    director: json["director"] == null ? null : VideoDetailsDirectorModel.fromMap(json["director"]),
    eggDesc: json["eggDesc"] == null ? null : json["eggDesc"],
    episodeCnt: json["episodeCnt"] == null ? null : json["episodeCnt"],
    festivals: json["festivals"] == null ? null : List<dynamic>.from(json["festivals"].map((x) => x)),
    hasSeenCount: json["hasSeenCount"] == null ? null : json["hasSeenCount"],
    hasSeenCountShow: json["hasSeenCountShow"] == null ? null : json["hasSeenCountShow"],
    hotRanking: json["hotRanking"] == null ? null : json["hotRanking"],
    img: json["img"] == null ? null : json["img"],
    is3D: json["is3D"] == null ? null : json["is3D"],
    isDmax: json["isDMAX"] == null ? null : json["isDMAX"],
    isEggHunt: json["isEggHunt"] == null ? null : json["isEggHunt"],
    isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],
    isFilter: json["isFilter"] == null ? null : json["isFilter"],
    isImax: json["isIMAX"] == null ? null : json["isIMAX"],
    isImax3D: json["isIMAX3D"] == null ? null : json["isIMAX3D"],
    isTicket: json["isTicket"] == null ? null : json["isTicket"],
    message: json["message"] == null ? null : json["message"],
    mins: json["mins"] == null ? null : json["mins"],
    movieId: json["movieId"] == null ? null : json["movieId"],
    movieStatus: json["movieStatus"] == null ? null : json["movieStatus"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
    overallRating: json["overallRating"] == null ? null : json["overallRating"].toDouble(),
    personCount: json["personCount"] == null ? null : json["personCount"],
    quizGame: json["quizGame"] == null ? null : VideoDetailsBoxOfficeModel.fromMap(json["quizGame"]),
    ratingCount: json["ratingCount"] == null ? null : json["ratingCount"],
    ratingCountShow: json["ratingCountShow"] == null ? null : json["ratingCountShow"],
    releaseArea: json["releaseArea"] == null ? null : json["releaseArea"],
    releaseDate: json["releaseDate"] == null ? null : json["releaseDate"],
    sensitiveStatus: json["sensitiveStatus"] == null ? null : json["sensitiveStatus"],
    showCinemaCount: json["showCinemaCount"] == null ? null : json["showCinemaCount"],
    showDay: json["showDay"] == null ? null : json["showDay"],
    showtimeCount: json["showtimeCount"] == null ? null : json["showtimeCount"],
    stageImg: json["stageImg"] == null ? null : VideoDetailsStageImgModel.fromMap(json["stageImg"]),
    story: json["story"] == null ? null : json["story"],
    style: json["style"] == null ? null : VideoDetailsStyleModel.fromMap(json["style"]),
    summary: json["summary"] == null ? null : json["summary"],
    totalNominateAward: json["totalNominateAward"] == null ? null : json["totalNominateAward"],
    totalWinAward: json["totalWinAward"] == null ? null : json["totalWinAward"],
    type: json["type"] == null ? null : List<String>.from(json["type"].map((x) => x)),
    url: json["url"] == null ? null : json["url"],
    userComment: json["userComment"] == null ? null : json["userComment"],
    userCommentId: json["userCommentId"] == null ? null : json["userCommentId"],
    userImg: json["userImg"] == null ? null : json["userImg"],
    userName: json["userName"] == null ? null : json["userName"],
    userRating: json["userRating"] == null ? null : json["userRating"],
    video: json["video"] == null ? null : VideoDetailsVideoModel.fromMap(json["video"]),
    wantToSeeCount: json["wantToSeeCount"] == null ? null : json["wantToSeeCount"],
    wantToSeeCountShow: json["wantToSeeCountShow"] == null ? null : json["wantToSeeCountShow"],
    wantToSeeNumberShow: json["wantToSeeNumberShow"] == null ? null : json["wantToSeeNumberShow"],
    year: json["year"] == null ? null : json["year"],
  );

  Map<String, dynamic> toMap() => {
    "actors": actors == null ? null : List<dynamic>.from(actors.map((x) => x.toMap())),
    "attitude": attitude == null ? null : attitude,
    "award": award == null ? null : award.toMap(),
    "bigImage": bigImage == null ? null : bigImage,
    "broadcastDes": broadcastDes == null ? null : broadcastDes,
    "commentSpecial": commentSpecial == null ? null : commentSpecial,
    "community": community == null ? null : community.toMap(),
    "director": director == null ? null : director.toMap(),
    "eggDesc": eggDesc == null ? null : eggDesc,
    "episodeCnt": episodeCnt == null ? null : episodeCnt,
    "festivals": festivals == null ? null : List<dynamic>.from(festivals.map((x) => x)),
    "hasSeenCount": hasSeenCount == null ? null : hasSeenCount,
    "hasSeenCountShow": hasSeenCountShow == null ? null : hasSeenCountShow,
    "hotRanking": hotRanking == null ? null : hotRanking,
    "img": img == null ? null : img,
    "is3D": is3D == null ? null : is3D,
    "isDMAX": isDmax == null ? null : isDmax,
    "isEggHunt": isEggHunt == null ? null : isEggHunt,
    "isFavorite": isFavorite == null ? null : isFavorite,
    "isFilter": isFilter == null ? null : isFilter,
    "isIMAX": isImax == null ? null : isImax,
    "isIMAX3D": isImax3D == null ? null : isImax3D,
    "isTicket": isTicket == null ? null : isTicket,
    "message": message == null ? null : message,
    "mins": mins == null ? null : mins,
    "movieId": movieId == null ? null : movieId,
    "movieStatus": movieStatus == null ? null : movieStatus,
    "name": name == null ? null : name,
    "nameEn": nameEn == null ? null : nameEn,
    "overallRating": overallRating == null ? null : overallRating,
    "personCount": personCount == null ? null : personCount,
    "quizGame": quizGame == null ? null : quizGame.toMap(),
    "ratingCount": ratingCount == null ? null : ratingCount,
    "ratingCountShow": ratingCountShow == null ? null : ratingCountShow,
    "releaseArea": releaseArea == null ? null : releaseArea,
    "releaseDate": releaseDate == null ? null : releaseDate,
    "sensitiveStatus": sensitiveStatus == null ? null : sensitiveStatus,
    "showCinemaCount": showCinemaCount == null ? null : showCinemaCount,
    "showDay": showDay == null ? null : showDay,
    "showtimeCount": showtimeCount == null ? null : showtimeCount,
    "stageImg": stageImg == null ? null : stageImg.toMap(),
    "story": story == null ? null : story,
    "style": style == null ? null : style.toMap(),
    "summary": summary == null ? null : summary,
    "totalNominateAward": totalNominateAward == null ? null : totalNominateAward,
    "totalWinAward": totalWinAward == null ? null : totalWinAward,
    "type": type == null ? null : List<dynamic>.from(type.map((x) => x)),
    "url": url == null ? null : url,
    "userComment": userComment == null ? null : userComment,
    "userCommentId": userCommentId == null ? null : userCommentId,
    "userImg": userImg == null ? null : userImg,
    "userName": userName == null ? null : userName,
    "userRating": userRating == null ? null : userRating,
    "video": video == null ? null : video.toMap(),
    "wantToSeeCount": wantToSeeCount == null ? null : wantToSeeCount,
    "wantToSeeCountShow": wantToSeeCountShow == null ? null : wantToSeeCountShow,
    "wantToSeeNumberShow": wantToSeeNumberShow == null ? null : wantToSeeNumberShow,
    "year": year == null ? null : year,
  };
}

class VideoDetailsActorModel {
  VideoDetailsActorModel({
    this.actorId,
    this.img,
    this.name,
    this.nameEn,
    this.roleImg,
    this.roleName,
  });

  final int actorId;
  final String img;
  final String name;
  final String nameEn;
  final String roleImg;
  final String roleName;

  factory VideoDetailsActorModel.fromJson(String str) => VideoDetailsActorModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsActorModel.fromMap(Map<String, dynamic> json) => VideoDetailsActorModel(
    actorId: json["actorId"] == null ? null : json["actorId"],
    img: json["img"] == null ? null : json["img"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
    roleImg: json["roleImg"] == null ? null : json["roleImg"],
    roleName: json["roleName"] == null ? null : json["roleName"],
  );

  Map<String, dynamic> toMap() => {
    "actorId": actorId == null ? null : actorId,
    "img": img == null ? null : img,
    "name": name == null ? null : name,
    "nameEn": nameEn == null ? null : nameEn,
    "roleImg": roleImg == null ? null : roleImg,
    "roleName": roleName == null ? null : roleName,
  };
}

class VideoDetailsAwardModel {
  VideoDetailsAwardModel({
    this.awardList,
    this.totalNominateAward,
    this.totalWinAward,
  });

  final List<dynamic> awardList;
  final int totalNominateAward;
  final int totalWinAward;

  factory VideoDetailsAwardModel.fromJson(String str) => VideoDetailsAwardModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsAwardModel.fromMap(Map<String, dynamic> json) => VideoDetailsAwardModel(
    awardList: json["awardList"] == null ? null : List<dynamic>.from(json["awardList"].map((x) => x)),
    totalNominateAward: json["totalNominateAward"] == null ? null : json["totalNominateAward"],
    totalWinAward: json["totalWinAward"] == null ? null : json["totalWinAward"],
  );

  Map<String, dynamic> toMap() => {
    "awardList": awardList == null ? null : List<dynamic>.from(awardList.map((x) => x)),
    "totalNominateAward": totalNominateAward == null ? null : totalNominateAward,
    "totalWinAward": totalWinAward == null ? null : totalWinAward,
  };
}

class VideoDetailsBoxOfficeModel {
  VideoDetailsBoxOfficeModel();

  factory VideoDetailsBoxOfficeModel.fromJson(String str) => VideoDetailsBoxOfficeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsBoxOfficeModel.fromMap(Map<String, dynamic> json) => VideoDetailsBoxOfficeModel(
  );

  Map<String, dynamic> toMap() => {
  };
}

class VideoDetailsDirectorModel {
  VideoDetailsDirectorModel({
    this.directorId,
    this.img,
    this.name,
    this.nameEn,
  });

  final int directorId;
  final String img;
  final String name;
  final String nameEn;

  factory VideoDetailsDirectorModel.fromJson(String str) => VideoDetailsDirectorModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsDirectorModel.fromMap(Map<String, dynamic> json) => VideoDetailsDirectorModel(
    directorId: json["directorId"] == null ? null : json["directorId"],
    img: json["img"] == null ? null : json["img"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
  );

  Map<String, dynamic> toMap() => {
    "directorId": directorId == null ? null : directorId,
    "img": img == null ? null : img,
    "name": name == null ? null : name,
    "nameEn": nameEn == null ? null : nameEn,
  };
}

class VideoDetailsStageImgModel {
  VideoDetailsStageImgModel({
    this.count,
    this.list,
  });

  final int count;
  final List<VideoDetailsListElementModel> list;

  factory VideoDetailsStageImgModel.fromJson(String str) => VideoDetailsStageImgModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsStageImgModel.fromMap(Map<String, dynamic> json) => VideoDetailsStageImgModel(
    count: json["count"] == null ? null : json["count"],
    list: json["list"] == null ? null : List<VideoDetailsListElementModel>.from(json["list"].map((x) => VideoDetailsListElementModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count == null ? null : count,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class VideoDetailsListElementModel {
  VideoDetailsListElementModel({
    this.imgId,
    this.imgUrl,
  });

  final int imgId;
  final String imgUrl;

  factory VideoDetailsListElementModel.fromJson(String str) => VideoDetailsListElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsListElementModel.fromMap(Map<String, dynamic> json) => VideoDetailsListElementModel(
    imgId: json["imgId"] == null ? null : json["imgId"],
    imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
  );

  Map<String, dynamic> toMap() => {
    "imgId": imgId == null ? null : imgId,
    "imgUrl": imgUrl == null ? null : imgUrl,
  };
}

class VideoDetailsStyleModel {
  VideoDetailsStyleModel({
    this.isLeadPage,
    this.leadImg,
    this.leadUrl,
  });

  final int isLeadPage;
  final String leadImg;
  final String leadUrl;

  factory VideoDetailsStyleModel.fromJson(String str) => VideoDetailsStyleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsStyleModel.fromMap(Map<String, dynamic> json) => VideoDetailsStyleModel(
    isLeadPage: json["isLeadPage"] == null ? null : json["isLeadPage"],
    leadImg: json["leadImg"] == null ? null : json["leadImg"],
    leadUrl: json["leadUrl"] == null ? null : json["leadUrl"],
  );

  Map<String, dynamic> toMap() => {
    "isLeadPage": isLeadPage == null ? null : isLeadPage,
    "leadImg": leadImg == null ? null : leadImg,
    "leadUrl": leadUrl == null ? null : leadUrl,
  };
}

class VideoDetailsVideoModel {
  VideoDetailsVideoModel({
    this.count,
    this.hightUrl,
    this.img,
    this.title,
    this.url,
    this.videoId,
    this.videoSourceType,
  });

  final int count;
  final String hightUrl;
  final String img;
  final String title;
  final String url;
  final int videoId;
  final int videoSourceType;

  factory VideoDetailsVideoModel.fromJson(String str) => VideoDetailsVideoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsVideoModel.fromMap(Map<String, dynamic> json) => VideoDetailsVideoModel(
    count: json["count"] == null ? null : json["count"],
    hightUrl: json["hightUrl"] == null ? null : json["hightUrl"],
    img: json["img"] == null ? null : json["img"],
    title: json["title"] == null ? null : json["title"],
    url: json["url"] == null ? null : json["url"],
    videoId: json["videoId"] == null ? null : json["videoId"],
    videoSourceType: json["videoSourceType"] == null ? null : json["videoSourceType"],
  );

  Map<String, dynamic> toMap() => {
    "count": count == null ? null : count,
    "hightUrl": hightUrl == null ? null : hightUrl,
    "img": img == null ? null : img,
    "title": title == null ? null : title,
    "url": url == null ? null : url,
    "videoId": videoId == null ? null : videoId,
    "videoSourceType": videoSourceType == null ? null : videoSourceType,
  };
}

class VideoDetailsLiveModel {
  VideoDetailsLiveModel({
    this.count,
    this.img,
    this.isSubscribe,
    this.liveId,
    this.playNumTag,
    this.playTag,
    this.status,
    this.title,
  });

  final int count;
  final String img;
  final bool isSubscribe;
  final int liveId;
  final String playNumTag;
  final String playTag;
  final int status;
  final String title;

  factory VideoDetailsLiveModel.fromJson(String str) => VideoDetailsLiveModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsLiveModel.fromMap(Map<String, dynamic> json) => VideoDetailsLiveModel(
    count: json["count"] == null ? null : json["count"],
    img: json["img"] == null ? null : json["img"],
    isSubscribe: json["isSubscribe"] == null ? null : json["isSubscribe"],
    liveId: json["liveId"] == null ? null : json["liveId"],
    playNumTag: json["playNumTag"] == null ? null : json["playNumTag"],
    playTag: json["playTag"] == null ? null : json["playTag"],
    status: json["status"] == null ? null : json["status"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "count": count == null ? null : count,
    "img": img == null ? null : img,
    "isSubscribe": isSubscribe == null ? null : isSubscribe,
    "liveId": liveId == null ? null : liveId,
    "playNumTag": playNumTag == null ? null : playNumTag,
    "playTag": playTag == null ? null : playTag,
    "status": status == null ? null : status,
    "title": title == null ? null : title,
  };
}

class VideoDetailsPlaylistModel {
  VideoDetailsPlaylistModel({
    this.isOpenByBrowser,
    this.payRule,
    this.picUrl,
    this.playSourceName,
    this.playUrl,
    this.playUrlH5,
    this.playUrlPc,
    this.sourceId,
  });

  final bool isOpenByBrowser;
  final String payRule;
  final String picUrl;
  final String playSourceName;
  final String playUrl;
  final String playUrlH5;
  final String playUrlPc;
  final String sourceId;

  factory VideoDetailsPlaylistModel.fromJson(String str) => VideoDetailsPlaylistModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsPlaylistModel.fromMap(Map<String, dynamic> json) => VideoDetailsPlaylistModel(
    isOpenByBrowser: json["isOpenByBrowser"] == null ? null : json["isOpenByBrowser"],
    payRule: json["payRule"] == null ? null : json["payRule"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    playSourceName: json["playSourceName"] == null ? null : json["playSourceName"],
    playUrl: json["playUrl"] == null ? null : json["playUrl"],
    playUrlH5: json["playUrlH5"] == null ? null : json["playUrlH5"],
    playUrlPc: json["playUrlPC"] == null ? null : json["playUrlPC"],
    sourceId: json["sourceId"] == null ? null : json["sourceId"],
  );

  Map<String, dynamic> toMap() => {
    "isOpenByBrowser": isOpenByBrowser == null ? null : isOpenByBrowser,
    "payRule": payRule == null ? null : payRule,
    "picUrl": picUrl == null ? null : picUrl,
    "playSourceName": playSourceName == null ? null : playSourceName,
    "playUrl": playUrl == null ? null : playUrl,
    "playUrlH5": playUrlH5 == null ? null : playUrlH5,
    "playUrlPC": playUrlPc == null ? null : playUrlPc,
    "sourceId": sourceId == null ? null : sourceId,
  };
}

class VideoDetailsRelatedModel {
  VideoDetailsRelatedModel({
    this.goodsCount,
    this.goodsList,
    this.relateId,
    this.relatedUrl,
    this.type,
  });

  final int goodsCount;
  final List<dynamic> goodsList;
  final int relateId;
  final String relatedUrl;
  final int type;

  factory VideoDetailsRelatedModel.fromJson(String str) => VideoDetailsRelatedModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoDetailsRelatedModel.fromMap(Map<String, dynamic> json) => VideoDetailsRelatedModel(
    goodsCount: json["goodsCount"] == null ? null : json["goodsCount"],
    goodsList: json["goodsList"] == null ? null : List<dynamic>.from(json["goodsList"].map((x) => x)),
    relateId: json["relateId"] == null ? null : json["relateId"],
    relatedUrl: json["relatedUrl"] == null ? null : json["relatedUrl"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() => {
    "goodsCount": goodsCount == null ? null : goodsCount,
    "goodsList": goodsList == null ? null : List<dynamic>.from(goodsList.map((x) => x)),
    "relateId": relateId == null ? null : relateId,
    "relatedUrl": relatedUrl == null ? null : relatedUrl,
    "type": type == null ? null : type,
  };
}
