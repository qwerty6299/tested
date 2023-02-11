// To parse this JSON data, do
//
//     final endquestionmodel = endquestionmodelFromJson(jsonString);

import 'dart:convert';

Endquestionmodel? endquestionmodelFromJson(String str) => Endquestionmodel.fromJson(json.decode(str));

String endquestionmodelToJson(Endquestionmodel? data) => json.encode(data!.toJson());

class Endquestionmodel {
  Endquestionmodel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory Endquestionmodel.fromJson(Map<String, dynamic> json) => Endquestionmodel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
