// To parse this JSON data, do
//
//     final insideSubCategorymodel = insideSubCategorymodelFromJson(jsonString);

import 'dart:convert';

InsideSubCategorymodel insideSubCategorymodelFromJson(String str) => InsideSubCategorymodel.fromJson(json.decode(str));

String insideSubCategorymodelToJson(InsideSubCategorymodel data) => json.encode(data.toJson());

class InsideSubCategorymodel {
  InsideSubCategorymodel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory InsideSubCategorymodel.fromJson(Map<String, dynamic> json) => InsideSubCategorymodel(
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
    required this.bookId,
    required this.bookName,
    required this.chapters,
  });

  String bookId;
  String bookName;
  List<Chapter> chapters;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bookId: json["bookId"],
    bookName: json["bookName"],
    chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookId": bookId,
    "bookName": bookName,
    "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
  };
}

class Chapter {
  Chapter({
    required this.chapterName,
    required this.time,
    required this.questions,
    required this.tests,
  });

  String chapterName;
  String time;
  String questions;
  List<Test> tests;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    chapterName: json["chapterName"],
    time: json["time"],
    questions: json["questions"],
    tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chapterName": chapterName,
    "time": time,
    "questions": questions,
    "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
  };
}

class Test {
  Test({
    required this.testId,
    required this.testName,
    required this.attempted,
    required this.enrolled,
    required this.link,
  });

  String testId;
  String testName;
  bool attempted;
  bool enrolled;
  String link;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    testId: json["testId"],
    testName: json["testName"],
    attempted: json["attempted"],
    enrolled: json["enrolled"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "testId": testId,
    "testName": testName,
    "attempted": attempted,
    "enrolled": enrolled,
    "link": link,
  };
}
