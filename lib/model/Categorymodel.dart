// To parse this JSON data, do
//
//     final categorymodel = categorymodelFromJson(jsonString);

import 'dart:convert';

Categorymodel categorymodelFromJson(String str) => Categorymodel.fromJson(json.decode(str));

String categorymodelToJson(Categorymodel data) => json.encode(data.toJson());

class Categorymodel {
  Categorymodel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory Categorymodel.fromJson(Map<String, dynamic> json) => Categorymodel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.name,
    required this.id,
    required this.subject,
    required this.test,
    required this.blink,
  });

  String name;
  String id;
  int subject;
  int test;
  bool blink;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    id: json["id"],
    subject: json["subject"],
    test: json["test"],
    blink: json["blink"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "subject": subject,
    "test": test,
    "blink": blink,
  };
}
