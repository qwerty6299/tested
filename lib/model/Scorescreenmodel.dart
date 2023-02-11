// To parse this JSON data, do
//
//     final scorescreenmodel = scorescreenmodelFromJson(jsonString);

import 'dart:convert';

Scorescreenmodel? scorescreenmodelFromJson(String str) => Scorescreenmodel.fromJson(json.decode(str));

String scorescreenmodelToJson(Scorescreenmodel? data) => json.encode(data!.toJson());

class Scorescreenmodel {
  Scorescreenmodel({
    this.status,
    this.message,
    this.result,
  });

  bool? status;
  String? message;
  List<Result?>? result;

  factory Scorescreenmodel.fromJson(Map<String, dynamic> json) => Scorescreenmodel(
    status: json["status"],
    message: json["message"],
    result: json["result"] == null ? [] : List<Result?>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x!.toJson())),
  };
}

class Result {
  Result({
    this.answered,
    this.unanswered,
    this.correct,
    this.wrong,
    this.score,
    this.completion,
    this.totalQuestions,
  });

  int? answered;
  int? unanswered;
  int? correct;
  int? wrong;
  int? score;
  String? completion;
  int? totalQuestions;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    answered: json["answered"],
    unanswered: json["unanswered"],
    correct: json["correct"],
    wrong: json["wrong"],
    score: json["score"],
    completion: json["completion"],
    totalQuestions: json["totalQuestions"],
  );

  Map<String, dynamic> toJson() => {
    "answered": answered,
    "unanswered": unanswered,
    "correct": correct,
    "wrong": wrong,
    "score": score,
    "completion": completion,
    "totalQuestions": totalQuestions,
  };
}
