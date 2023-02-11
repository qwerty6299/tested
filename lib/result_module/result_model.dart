// // To parse this JSON data, do
// //
// //     final testResultModel = testResultModelFromMap(jsonString);

// import 'dart:convert';

// TestResultModel testResultModelFromMap(String str) =>
//     TestResultModel.fromMap(json.decode(str));

// String testResultModelToMap(TestResultModel data) => json.encode(data.toMap());

// class TestResultModel {
//   TestResultModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   bool? status;
//   String? message;
//   Data? data;

//   factory TestResultModel.fromMap(Map<String, dynamic> json) => TestResultModel(
//         status: json["status"] == null ? null : json["status"],
//         message: json["message"] == null ? null : json["message"],
//         data: json["data"] == null ? null : Data.fromMap(json["data"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "status": status == null ? null : status,
//         "message": message == null ? null : message,
//         "data": data == null ? null : data!.toMap(),
//       };
// }

// class Data {
//   Data({this.score, this.walletPoints, this.url});

//   int? score;
//   int? walletPoints;
//   String? url;

//   factory Data.fromMap(Map<String, dynamic> json) => Data(
//         score: json["score"] == null ? null : json["score"],
//         walletPoints:
//             json["wallet_points"] == null ? null : json["wallet_points"],
//         url: json["url"] == null ? null : json["url"].toString(),
//       );

//   Map<String, dynamic> toMap() => {
//         "score": score == null ? null : score,
//         "wallet_points": walletPoints == null ? null : walletPoints,
//         "url": url == null ? null : url,
//       };
// }

// To parse this JSON data, do
//
//     final testResultModel = testResultModelFromMap(jsonString);

import 'dart:convert';

TestResultModel testResultModelFromMap(String str) =>
    TestResultModel.fromMap(json.decode(str));

String testResultModelToMap(TestResultModel data) => json.encode(data.toMap());

class TestResultModel {
  TestResultModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory TestResultModel.fromMap(Map<String, dynamic> json) => TestResultModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.score,
    this.walletPoints,
    this.url,
  });

  int? score;
  int? walletPoints;
  Url? url;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        score: json["score"] == null ? null : json["score"],
        walletPoints:
            json["wallet_points"] == null ? null : json["wallet_points"],
        url: json["url"] == null ? null : Url.fromMap(json["url"]),
      );

  Map<String, dynamic> toMap() => {
        "score": score == null ? null : score,
        "wallet_points": walletPoints == null ? null : walletPoints,
        "url": url == null ? null : url!.toMap(),
      };
}

class Url {
  Url({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Url.fromMap(Map<String, dynamic> json) => Url(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "url": url == null ? null : url,
      };
}
