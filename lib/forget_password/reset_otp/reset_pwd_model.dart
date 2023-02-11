// To parse this JSON data, do
//
//     final resetPwdModel = resetPwdModelFromMap(jsonString);

import 'dart:convert';

ResetPwdModel resetPwdModelFromMap(String str) =>
    ResetPwdModel.fromMap(json.decode(str));

String resetPwdModelToMap(ResetPwdModel data) => json.encode(data.toMap());

class ResetPwdModel {
  ResetPwdModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ResetPwdModel.fromMap(Map<String, dynamic> json) => ResetPwdModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
