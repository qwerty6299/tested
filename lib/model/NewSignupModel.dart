// To parse this JSON data, do
//
//     final newSignupModel = newSignupModelFromJson(jsonString);

import 'dart:convert';

NewSignupModel newSignupModelFromJson(String str) => NewSignupModel.fromJson(json.decode(str));

String newSignupModelToJson(NewSignupModel data) => json.encode(data.toJson());

class NewSignupModel {
  NewSignupModel({
    required  this.message,
    required   this.status,
    required   this.id,
    required this.otp,
  });

  String message;
  bool status;
  String id;
  int otp;

  factory NewSignupModel.fromJson(Map<String, dynamic> json) => NewSignupModel(
    message: json["message"],
    status: json["status"],
    id: json["id"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "id": id,
    "otp": otp,
  };
}
