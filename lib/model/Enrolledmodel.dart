// To parse this JSON data, do
//
//     final enrolledmodel = enrolledmodelFromJson(jsonString);

import 'dart:convert';

Enrolledmodel enrolledmodelFromJson(String str) => Enrolledmodel.fromJson(json.decode(str));

String enrolledmodelToJson(Enrolledmodel data) => json.encode(data.toJson());

class Enrolledmodel {
  Enrolledmodel({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory Enrolledmodel.fromJson(Map<String, dynamic> json) => Enrolledmodel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
