// To parse this JSON data, do
//
//     final coinHistorymodel = coinHistorymodelFromJson(jsonString);

import 'dart:convert';

CoinHistorymodel? coinHistorymodelFromJson(String str) => CoinHistorymodel.fromJson(json.decode(str));

String coinHistorymodelToJson(CoinHistorymodel? data) => json.encode(data!.toJson());

class CoinHistorymodel {
  CoinHistorymodel({
    this.status,
    this.message,
    this.result,
  });

  bool? status;
  String? message;
  Result? result;

  factory CoinHistorymodel.fromJson(Map<String, dynamic> json) => CoinHistorymodel(
    status: json["status"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result!.toJson(),
  };
}

class Result {
  Result({
    this.balance,
    this.history,
  });

  int? balance;
  List<History?>? history;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    balance: json["balance"],
    history: json["history"] == null ? [] : List<History?>.from(json["history"]!.map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x!.toJson())),
  };
}

class History {
  History({
    this.logo,
    this.title,
    this.subtitle,
    this.debit,
    this.amount,
  });

  String? logo;
  String? title;
  String? subtitle;
  bool? debit;
  int? amount;

  factory History.fromJson(Map<String, dynamic> json) => History(
    logo: json["logo"],
    title: json["title"],
    subtitle: json["subtitle"],
    debit: json["debit"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "logo": logo,
    "title": title,
    "subtitle": subtitle,
    "debit": debit,
    "amount": amount,
  };
}
