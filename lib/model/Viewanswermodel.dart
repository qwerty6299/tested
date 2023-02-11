// To parse this JSON data, do
//
//     final viewanswermodel = viewanswermodelFromJson(jsonString);

import 'dart:convert';

Viewanswermodel? viewanswermodelFromJson(String str) => Viewanswermodel.fromJson(json.decode(str));

String viewanswermodelToJson(Viewanswermodel? data) => json.encode(data!.toJson());

class Viewanswermodel {
  Viewanswermodel({
    this.status,
    this.message,
    this.result,
  });

  bool? status;
  String? message;
  List<Result?>? result;

  factory Viewanswermodel.fromJson(Map<String, dynamic> json) => Viewanswermodel(
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
    this.type,
    this.question,
    this.options,
    this.questions,
  });

  String? type;
  String? question;
  List<Option?>? options;
  List<Question?>? questions;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    type: json["type"],
    question: json["question"],
    options: json["options"] == null ? [] : json["options"] == null ? [] : List<Option?>.from(json["options"]!.map((x) => Option.fromJson(x))),
    questions: json["questions"] == null ? [] : json["questions"] == null ? [] : List<Question?>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "question": question,
    "options": options == null ? [] : options == null ? [] : List<dynamic>.from(options!.map((x) => x!.toJson())),
    "questions": questions == null ? [] : questions == null ? [] : List<dynamic>.from(questions!.map((x) => x!.toJson())),
  };
}

class Option {
  Option({
    this.id,
    this.op,
    this.value,
    this.choose,
  });

  Id? id;
  String? op;
  bool? value;
  bool? choose;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: idValues.map[json["_id"]],
    op: json["op"],
    value: json["value"],
    choose: json["choose"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse![id],
    "op": op,
    "value": value,
    "choose": choose,
  };
}

enum Id { DMDKL }

final idValues = EnumValues({
  "dmdkl": Id.DMDKL
});

class Question {
  Question({
    this.subQuestion,
    this.options,
  });

  String? subQuestion;
  List<Option?>? options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    subQuestion: json["sub_question"],
    options: json["options"] == null ? [] : List<Option?>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sub_question": subQuestion,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x!.toJson())),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
