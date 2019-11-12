

// To parse this JSON data, do
//
//     final jsonTesResponse = jsonTesResponseFromJson(jsonString);

import 'dart:convert';

YoutubeResponse jsonTesResponseFromJson(String str) => YoutubeResponse.fromJson(json.decode(str));

String jsonTesResponseToJson(YoutubeResponse data) => json.encode(data.toJson());

class YoutubeResponse {
  List<Youtube> youtubes;
  bool error;
  String errorMsg;

  YoutubeResponse({
    this.youtubes,
    this.error,
    this.errorMsg,
  });

  factory YoutubeResponse.fromJson(Map<String, dynamic> json) => YoutubeResponse(
    youtubes: List<Youtube>.from(json["youtubes"].map((x) => Youtube.fromJson(x))),
    error: json["error"],
    errorMsg: json["error_msg"],
  );

  Map<String, dynamic> toJson() => {
    "youtubes": List<dynamic>.from(youtubes.map((x) => x.toJson())),
    "error": error,
    "error_msg": errorMsg,
  };
}

class Youtube {
  String id;
  String title;
  String subtitle;
  String avatarImage;
  String youtubeImage;

  Youtube({
    this.id,
    this.title,
    this.subtitle,
    this.avatarImage,
    this.youtubeImage,
  });

  factory Youtube.fromJson(Map<String, dynamic> json) => Youtube(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    avatarImage: json["avatar_image"],
    youtubeImage: json["youtube_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "avatar_image": avatarImage,
    "youtube_image": youtubeImage,
  };
}
