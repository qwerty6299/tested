// To parse this JSON data, do
//
//     final registerModel = registerModelFromMap(jsonString);

import 'dart:convert';

RegisterModel registerModelFromMap(String str) =>
    RegisterModel.fromMap(json.decode(str));

String registerModelToMap(RegisterModel data) => json.encode(data.toMap());

class RegisterModel {
  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toMap(),
      };
}

class Data {
  Data({
    this.otp,
  });

  int? otp;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        otp: json["otp"] == null ? null : json["otp"],
      );

  Map<String, dynamic> toMap() => {
        "otp": otp == null ? null : otp,
      };
}
