// To parse this JSON data, do
//
//     final leaderboardmodel = leaderboardmodelFromJson(jsonString);

import 'dart:convert';

Leaderboardmodel? leaderboardmodelFromJson(String str) => Leaderboardmodel.fromJson(json.decode(str));

String leaderboardmodelToJson(Leaderboardmodel? data) => json.encode(data!.toJson());

class Leaderboardmodel {
  Leaderboardmodel({
    this.status,
    this.message,
    this.result,
  });

  bool? status;
  String? message;
  List<Result?>? result;

  factory Leaderboardmodel.fromJson(Map<String, dynamic> json) => Leaderboardmodel(
    status: json["status"],
    message: json["message"],
    result: json["result"] == null ? [] : List<Result?>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x!.toJson())),
  };
}

class Result {
  Result({
    this.image,
    this.points,
    this.name,
    this.id,
    this.rank,
  });

  String? image;
  String? points;
  String? name;
  String? id;
  String? rank;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    image: json["image"],
    points: json["points"],
    name: json["name"],
    id: json["id"],
    rank: json["rank"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "points": points,
    "name": name,
    "id": id,
    "rank": rank,
  };
}
