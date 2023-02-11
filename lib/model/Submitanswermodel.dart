// To parse this JSON data, do
//
//     final submitanswermodel = submitanswermodelFromJson(jsonString);

import 'dart:convert';

Submitanswermodel? submitanswermodelFromJson(String str) => Submitanswermodel.fromJson(json.decode(str));

String submitanswermodelToJson(Submitanswermodel? data) => json.encode(data!.toJson());

class Submitanswermodel {
  Submitanswermodel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory Submitanswermodel.fromJson(Map<String, dynamic> json) => Submitanswermodel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
