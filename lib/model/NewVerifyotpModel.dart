// To parse this JSON data, do
//
//     final newVerifyotpModel = newVerifyotpModelFromJson(jsonString);

import 'dart:convert';

NewVerifyotpModel newVerifyotpModelFromJson(String str) => NewVerifyotpModel.fromJson(json.decode(str));

String newVerifyotpModelToJson(NewVerifyotpModel data) => json.encode(data.toJson());

class NewVerifyotpModel {
  NewVerifyotpModel({
    required  this.message,
    required this.status,
    required this.id,
  });

  String message;
  bool status;
  String id;

  factory NewVerifyotpModel.fromJson(Map<String, dynamic> json) => NewVerifyotpModel(
    message: json["message"],
    status: json["status"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "id": id,
  };
}
