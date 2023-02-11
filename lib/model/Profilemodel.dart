// To parse this JSON data, do
//
//     final profilemodel = profilemodelFromJson(jsonString);

import 'dart:convert';

Profilemodel profilemodelFromJson(String str) => Profilemodel.fromJson(json.decode(str));

String profilemodelToJson(Profilemodel data) => json.encode(data.toJson());

class Profilemodel {
  Profilemodel({
    required  this.status,
    required  this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required  this.phone,
    required  this.email,
    required this.name,
    required this.image,
    required this.id,
  });

  String phone;
  String email;
  String name;
  String image;
  String id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phone: json["phone"],
    email: json["email"],
    name: json["name"],
    image: json["image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
    "name": name,
    "image": image,
    "id": id,
  };
}
