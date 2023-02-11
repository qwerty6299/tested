// To parse this JSON data, do
//
//     final forgetPwdModel = forgetPwdModelFromMap(jsonString);

import 'dart:convert';

ForgetPwdModel forgetPwdModelFromMap(String str) =>
    ForgetPwdModel.fromMap(json.decode(str));

String forgetPwdModelToMap(ForgetPwdModel data) => json.encode(data.toMap());

class ForgetPwdModel {
  ForgetPwdModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ForgetPwdModel.fromMap(Map<String, dynamic> json) => ForgetPwdModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ||
                json["status"] == false ||
                json["data"] == ""
            ? null
            : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
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
