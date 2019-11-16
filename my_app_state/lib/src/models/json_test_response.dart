// To parse this JSON data, do
//
//     final jsonTestResponse = jsonTestResponseFromJson(jsonString);

import 'dart:convert';

List<JsonTestResponse> jsonTestResponseFromJson(String str) => List<JsonTestResponse>.from(json.decode(str).map((x) => JsonTestResponse.fromJson(x)));

String jsonTestResponseToJson(List<JsonTestResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonTestResponse {
  int userId;
  int id;
  String title;
  String body;

  JsonTestResponse({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory JsonTestResponse.fromJson(Map<String, dynamic> json) => JsonTestResponse(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
