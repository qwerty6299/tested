// To parse this JSON data, do
//
//     final eligibilityModel = eligibilityModelFromMap(jsonString);

import 'dart:convert';

EligibilityModel eligibilityModelFromMap(String str) =>
    EligibilityModel.fromMap(json.decode(str));

String eligibilityModelToMap(EligibilityModel data) =>
    json.encode(data.toMap());

class EligibilityModel {
  EligibilityModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory EligibilityModel.fromMap(Map<String, dynamic> json) =>
      EligibilityModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
