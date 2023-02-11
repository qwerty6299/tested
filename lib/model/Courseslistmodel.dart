// To parse this JSON data, do
//
//     final courseslistmodel = courseslistmodelFromJson(jsonString);

import 'dart:convert';

Courseslistmodel courseslistmodel(String str) => Courseslistmodel.fromJson(json.decode(str));

String courseslistmodelToJson(Courseslistmodel data) => json.encode(data.toJson());

class Courseslistmodel {
  Courseslistmodel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory Courseslistmodel.fromJson(Map<String, dynamic> json) => Courseslistmodel(
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
  });

  String name;
  String id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
