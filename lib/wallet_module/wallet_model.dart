// To parse this JSON data, do
//
//     final walletPointsModel = walletPointsModelFromMap(jsonString);

import 'dart:convert';

WalletPointsModel walletPointsModelFromMap(String str) =>
    WalletPointsModel.fromMap(json.decode(str));

String walletPointsModelToMap(WalletPointsModel data) =>
    json.encode(data.toMap());

class WalletPointsModel {
  WalletPointsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory WalletPointsModel.fromMap(Map<String, dynamic> json) =>
      WalletPointsModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.id,
    this.points,
  });

  String? id;
  int? points;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        points: json["points"] == null ? null : json["points"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "points": points == null ? null : points,
      };
}
