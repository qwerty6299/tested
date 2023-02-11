// To parse this JSON data, do
//
//     final newUpdateprofilemodel = newUpdateprofilemodelFromJson(jsonString);

import 'dart:convert';

NewUpdateprofilemodel? newUpdateprofilemodelFromJson(String str) => NewUpdateprofilemodel.fromJson(json.decode(str));

String newUpdateprofilemodelToJson(NewUpdateprofilemodel? data) => json.encode(data!.toJson());

class NewUpdateprofilemodel {
  NewUpdateprofilemodel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory NewUpdateprofilemodel.fromJson(Map<String, dynamic> json) => NewUpdateprofilemodel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
