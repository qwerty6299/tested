// To parse this JSON data, do
//
//     final questionmodel = questionmodelFromJson(jsonString);

import 'dart:convert';

Questionmodel? questionmodelFromJson(String str) => Questionmodel.fromJson(json.decode(str));

String questionmodelToJson(Questionmodel? data) => json.encode(data!.toJson());

class Questionmodel {
  Questionmodel({
    this.status,
    this.message,
    this.result,
  });

  bool? status;
  String? message;
  List<Result?>? result;

  factory Questionmodel.fromJson(Map<String, dynamic> json) => Questionmodel(
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
    this.testId,
    this.pattern,
    this.question,
    this.questionId,
    this.options,
    this.questions,
  });

  String? testId;
  String? pattern;
  String? question;
  String? questionId;
  List<Option?>? options;
  List<Question?>? questions;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    testId: json["testId"],
    pattern: json["pattern"],
    question: json["question"],
    questionId: json["questionId"],
    options: json["options"] == null ? [] : json["options"] == null ? [] : List<Option?>.from(json["options"]!.map((x) => Option.fromJson(x))),
    questions: json["questions"] == null ? [] : json["questions"] == null ? [] : List<Question?>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "testId": testId,
    "pattern": pattern,
    "question": question,
    "questionId": questionId,
    "options": options == null ? [] : options == null ? [] : List<dynamic>.from(options!.map((x) => x!.toJson())),
    "questions": questions == null ? [] : questions == null ? [] : List<dynamic>.from(questions!.map((x) => x!.toJson())),
  };
}

class Option {
  Option({
    this.option,
    this.answer,
    this.id,
  });

  String? option;
  bool? answer;
  String? id;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    option: json["option"],
    answer: json["answer"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "option": option,
    "answer": answer,
    "_id": id,
  };
}

class Question {
  Question({
    this.subQuestion,
    this.options,
    this.id,
  });

  String? subQuestion;
  List<Option?>? options;
  String? id;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    subQuestion: json["subQuestion"],
    options: json["options"] == null ? [] : List<Option?>.from(json["options"]!.map((x) => Option.fromJson(x))),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "subQuestion": subQuestion,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x!.toJson())),
    "_id": id,
  };
}
