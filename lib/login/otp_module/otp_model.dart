// To parse this JSON data, do
//
//     final otpModel = otpModelFromMap(jsonString);

import 'dart:convert';

OtpModel otpModelFromMap(String str) => OtpModel.fromMap(json.decode(str));

String otpModelToMap(OtpModel data) => json.encode(data.toMap());

class OtpModel {
  OtpModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory OtpModel.fromMap(Map<String, dynamic> json) => OtpModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
