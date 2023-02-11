// To parse this JSON data, do
//
//     final newLoginModel = newLoginModelFromJson(jsonString);

import 'dart:convert';

NewLoginModel newLoginModelFromJson(String str) => NewLoginModel.fromJson(json.decode(str));

String newLoginModelToJson(NewLoginModel data) => json.encode(data.toJson());

class NewLoginModel {
  NewLoginModel({
    required    this.status,
    required  this.message,
    required  this.data,
  });

  bool status;
  String message;
  Data data;

  factory NewLoginModel.fromJson(Map<String, dynamic> json) => NewLoginModel(
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
    required this.id,
    required this.token,
    required this.refreshToken,
    required  this.name,
    required  this.phone,
    required  this.email,
  });

  String id;
  String token;
  String refreshToken;
  String name;
  String phone;
  String email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    token: json["token"],
    refreshToken: json["refresh_token"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "refresh_token": refreshToken,
    "name": name,
    "phone": phone,
    "email": email,
  };
}
