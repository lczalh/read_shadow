// To parse this JSON data, do
//
//     final readShadowUpdateModel = readShadowUpdateModelFromMap(jsonString);

import 'dart:convert';

class ReadShadowUpdateModel {
  ReadShadowUpdateModel({
    this.title,
    this.version,
    this.contents,
    this.url,
    this.force,
  });

  final String title;
  final String version;
  final List<String> contents;
  final String url;
  final bool force;

  factory ReadShadowUpdateModel.fromJson(String str) => ReadShadowUpdateModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReadShadowUpdateModel.fromMap(Map<String, dynamic> json) => ReadShadowUpdateModel(
    title: json["title"] == null ? null : json["title"],
    version: json["version"] == null ? null : json["version"],
    contents: json["contents"] == null ? null : List<String>.from(json["contents"].map((x) => x)),
    url: json["url"] == null ? null : json["url"],
    force: json["force"] == null ? null : json["force"],
  );

  Map<String, dynamic> toMap() => {
    "title": title == null ? null : title,
    "version": version == null ? null : version,
    "contents": contents == null ? null : List<dynamic>.from(contents.map((x) => x)),
    "url": url == null ? null : url,
    "force": force == null ? null : force,
  };
}
