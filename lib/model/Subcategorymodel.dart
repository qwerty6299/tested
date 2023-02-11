// To parse this JSON data, do
//
//     final subCategorymodel = subCategorymodelFromJson(jsonString);

import 'dart:convert';

SubCategorymodel subCategorymodelFromJson(String str) => SubCategorymodel.fromJson(json.decode(str));

String subCategorymodelToJson(SubCategorymodel data) => json.encode(data.toJson());

class SubCategorymodel {
  SubCategorymodel({
    required this.status,
    required  this.message,
    required  this.data,
  });

  bool status;
  String message;
  Data data;

  factory SubCategorymodel.fromJson(Map<String, dynamic> json) => SubCategorymodel(
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
    required   this.course,
    required  this.courserId,
    required  this.books,
  });

  String course;
  String courserId;
  List<Book> books;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    course: json["course"],
    courserId: json["courserId"],
    books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "course": course,
    "courserId": courserId,
    "books": List<dynamic>.from(books.map((x) => x.toJson())),
  };
}

class Book {
  Book({
    required   this.bookName,
    required this.bookImage,
    required this.bookId,
    required this.tests,
    required  this.attempted,
  });

  String bookName;
  String bookImage;
  String bookId;
  int tests;
  int attempted;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    bookName: json["book_name"],
    bookImage: json["book_image"],
    bookId: json["book_id"],
    tests: json["tests"],
    attempted: json["attempted"],
  );

  Map<String, dynamic> toJson() => {
    "book_name": bookName,
    "book_image": bookImage,
    "book_id": bookId,
    "tests": tests,
    "attempted": attempted,
  };
}
