// To parse this JSON data, do
//
//     final homepageModel = homepageModelFromMap(jsonString);

import 'dart:convert';

HomepageModel homepageModelFromMap(String str) =>
    HomepageModel.fromMap(json.decode(str));

String homepageModelToMap(HomepageModel data) => json.encode(data.toMap());

class HomepageModel {
  HomepageModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory HomepageModel.fromMap(Map<String, dynamic> json) => HomepageModel(
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
    this.courses,
    this.user,
  });

  List<Course>? courses;
  User? user;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        courses: json["courses"] == null
            ? null
            : List<Course>.from(json["courses"].map((x) => Course.fromMap(x))),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "courses": courses == null
            ? null
            : List<dynamic>.from(courses!.map((x) => x.toMap())),
        "user": user == null ? null : user!.toMap(),
      };
}

class Course {
  Course({
    this.id,
    this.cName,
    this.subjectCount,
    this.totalTests,
    this.subjects,
    this.isSelected,
  });

  int? id;
  String? cName;
  dynamic subjectCount;
  dynamic totalTests;
  List<Subject>? subjects;
  bool? isSelected;

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"] == null ? null : json["id"],
        cName: json["c_name"] == null ? null : json["c_name"],
        subjectCount:
            json["subject_count"] == null ? null : json["subject_count"],
        totalTests: json["total_tests"] == null ? null : json["total_tests"],
        subjects: json["subjects"] == null
            ? null
            : List<Subject>.from(
                json["subjects"].map((x) => Subject.fromMap(x))),
        isSelected: json["is_selected"] == null ? null : json["is_selected"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "c_name": cName == null ? null : cName,
        "subject_count": subjectCount == null ? null : subjectCount,
        "total_tests": totalTests == null ? null : totalTests,
        "subjects": subjects == null
            ? null
            : List<dynamic>.from(subjects!.map((x) => x.toMap())),
        "is_selected": isSelected == null ? null : isSelected,
      };
}

class Subject {
  Subject({
    this.sName,
    this.sTests,
    this.chapters,
    this.sId,
  });

  String? sName;
  int? sTests;
  List<Chapter>? chapters;
  String? sId;

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
        sName: json["s_name"] == null ? null : json["s_name"],
        sTests: json["s_tests"] == null ? null : json["s_tests"],
        chapters: json["chapters"] == null
            ? null
            : List<Chapter>.from(
                json["chapters"].map((x) => Chapter.fromMap(x))),
        sId: json["s_id"] == null ? null : json["s_id"],
      );

  Map<String, dynamic> toMap() => {
        "s_name": sName == null ? null : sName,
        "s_tests": sTests == null ? null : sTests,
        "chapters": chapters == null
            ? null
            : List<dynamic>.from(chapters!.map((x) => x.toMap())),
        "s_id": sId == null ? null : sId,
      };
}

class Chapter {
  Chapter({
    this.cId,
    this.chapName,
    this.chapTests,
  });
  String? cId;

  String? chapName;
  List<ChapTest>? chapTests;

  factory Chapter.fromMap(Map<String, dynamic> json) => Chapter(
        cId: json["c_id"] == null ? null : json["c_id"],
        chapName: json["chap_name"] == null ? null : json["chap_name"],
        chapTests: json["chap_tests"] == null
            ? null
            : List<ChapTest>.from(
                json["chap_tests"].map((x) => ChapTest.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "c_id": cId == null ? null : cId,
        "chap_name": chapName == null ? null : chapName,
        "chap_tests": chapTests == null
            ? null
            : List<dynamic>.from(chapTests!.map((x) => x.toMap())),
      };
}

class ChapTest {
  ChapTest({
    this.name,
    this.attempt,
    this.paper,
    this.url,
  });

  String? name;
  bool? attempt;
  List<Paper>? paper;
  String? url;

  factory ChapTest.fromMap(Map<String, dynamic> json) => ChapTest(
        name: json["name"] == null ? null : json["name"],
        attempt: json["attempt"] == null ? null : json["attempt"],
        paper: json["paper"] == null
            ? null
            : List<Paper>.from(json["paper"].map((x) => Paper.fromMap(x))),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "attempt": attempt == null ? null : attempt,
        "paper": paper == null
            ? null
            : List<dynamic>.from(paper!.map((x) => x.toMap())),
        "url": url == null ? null : url,
      };
}

class Paper {
  Paper({
    this.question,
    this.answer,
  });

  String? question;
  List<Answer>? answer;

  factory Paper.fromMap(Map<String, dynamic> json) => Paper(
        question: json["question"] == null ? null : json["question"],
        answer: json["answer"] == null
            ? null
            : List<Answer>.from(json["answer"].map((x) => Answer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "question": question == null ? null : question,
        "answer": answer == null
            ? null
            : List<dynamic>.from(answer!.map((x) => x.toMap())),
      };
}

class Answer {
  Answer({
    this.name,
    this.value,
  });

  String? name;
  bool? value;

  factory Answer.fromMap(Map<String, dynamic> json) => Answer(
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "value": value == null ? null : value,
      };
}

class User {
  User({
    // this.id,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.course,
    this.contact,
    this.points,
    this.solutions,
  });

  // dynamic? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? course;
  String? contact;
  int? points;
  List<Solution>? solutions;

  factory User.fromMap(Map<String, dynamic> json) => User(
        // id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        confirmPassword:
            json["confirm_password"] == null ? null : json["confirm_password"],
        course: json["course"] == null ? null : json["course"].toString(),
        contact: json["contact"] == null ? null : json["contact"],
        points: json["points"] == null ? null : json["points"],
        solutions: json["solutions"] == null
            ? null
            : List<Solution>.from(
                json["solutions"].map((x) => Solution.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        // "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "confirm_password": confirmPassword == null ? null : confirmPassword,
        "course": course == null ? null : course.toString(),
        "contact": contact == null ? null : contact,
        "points": points == null ? null : points,
        "solutions": solutions == null
            ? null
            : List<dynamic>.from(solutions!.map((x) => x.toMap())),
      };
}

class Test {
  Test({
    this.testAttempt,
    this.testNo,
  });

  bool? testAttempt;
  int? testNo;

  factory Test.fromMap(Map<String, dynamic> json) => Test(
        testAttempt: json["test_attempt"] == null ? null : json["test_attempt"],
        testNo: json["test"] == null ? null : json["test"],
      );

  Map<String, dynamic> toMap() => {
        "test_attempt": testAttempt == null ? null : testAttempt,
        "test_no": testNo == null ? null : testNo,
      };
}

class Solution {
  Solution({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Solution.fromMap(Map<String, dynamic> json) => Solution(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "url": url == null ? null : url,
      };
}
