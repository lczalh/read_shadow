// To parse this JSON data, do
//
//     final videoPlayerModel = videoPlayerModelFromMap(jsonString);

import 'dart:convert';

class VideoPlayerModel {
  VideoPlayerModel({
    this.code,
    this.success,
    this.parser,
    this.type,
    this.player,
    this.url,
    this.metareferer,
  });

  final String code;
  final String success;
  final String parser;
  final String type;
  final String player;
  final String url;
  final String metareferer;

  factory VideoPlayerModel.fromJson(String str) => VideoPlayerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPlayerModel.fromMap(Map<String, dynamic> json) => VideoPlayerModel(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    parser: json["parser"] == null ? null : json["parser"],
    type: json["type"] == null ? null : json["type"],
    player: json["player"] == null ? null : json["player"],
    url: json["url"] == null ? null : json["url"],
    metareferer: json["metareferer"] == null ? null : json["metareferer"],
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "parser": parser == null ? null : parser,
    "type": type == null ? null : type,
    "player": player == null ? null : player,
    "url": url == null ? null : url,
    "metareferer": metareferer == null ? null : metareferer,
  };
}
