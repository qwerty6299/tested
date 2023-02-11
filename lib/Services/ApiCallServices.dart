import 'dart:convert';
import 'dart:io';

import 'package:TESTED/model/Questionmodel.dart';
import 'package:http/http.dart' as http;
import '../model/Categorymodel.dart';
import '../model/CoinHistorymodel.dart';
import '../model/Enrolledmodel.dart';
import '../model/InsideSubCategorymodel.dart';
import '../model/NewUpdateprofilemodel.dart';
import '../model/Profilemodel.dart';
import '../model/Scorescreenmodel.dart';
import '../model/Subcategorymodel.dart';
import '../model/Submitanswermodel.dart';
import '../model/leaderboardmodel.dart';


Future<Categorymodel?> getapicate({required String header})async{
  Categorymodel? result;

  try {
    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/all_courses"),headers: {
          HttpHeaders.authorizationHeader:"Bearer $header"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = Categorymodel.fromJson(items);
      print(" sub catstatus is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}

Future<SubCategorymodel?> getsubcat(String id,{required String header})async{
  SubCategorymodel? result;

  try {
    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/all_books/$id"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = SubCategorymodel.fromJson(items);
      print(" sub catstatus is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}

Future<InsideSubCategorymodel?> getserviceinsidesubcat(String id,{required String header})async{
  InsideSubCategorymodel? result;

  try {
    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/all_chapters/$id"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = InsideSubCategorymodel.fromJson(items);
      print(" sub catstatus is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}

Future<Questionmodel?> getmyquestion()async{
  Questionmodel? qq;

  try {
    final response = await http.get(Uri.parse("http://3.227.35.5:3002/api/v2/getSingleQuestions?chapterId=45&testId=41"));

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      qq = Questionmodel.fromJson(items);
      print(" question is ${response.body}");
    }
    else {
      print(" 0000 ${response.body}");
    }
  }catch(e){
    print("1234r5t6y7u8${e.toString()}");
  }
  return qq;

}

Future<Profilemodel?> apiprofilemodel({required String header})async{
  Profilemodel? result;

  try {
    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/my_profile"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = Profilemodel.fromJson(items);
      print(" sub catstatus is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}

Future<NewUpdateprofilemodel?> updatingprofile({required String header,required String name,required String phone
,required String email,required String password,required String dob})async{
  NewUpdateprofilemodel? result;

  try {
    final response = await http.put(
        Uri.parse("http://3.227.35.5:3002/api/v2/upd_profile"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    },body: {
      "name":"$name",
      "phone":"$phone",
      "email":"$email",
      "password":"$password",
      "dob":"$dob"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result =  NewUpdateprofilemodel.fromJson(items);
      print(" sub catstatus is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}

Future<Scorescreenmodel?> apiscorescreenmodel({required String header,required String query})async{
  Scorescreenmodel? result;

  try {

    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/get_score?testId=$query"), headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    },);

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = Scorescreenmodel.fromJson(items);
      print(" score scren is is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}


Future<CoinHistorymodel?> apicoinhistorymodel({required String header})async{
  CoinHistorymodel? result;

  try {
    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/history"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = CoinHistorymodel.fromJson(items);
      print(" sub catstatus is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}


Future<Leaderboardmodel?> apileaderboard({required String header})async{
  Leaderboardmodel? result;

  try {
    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/leaderboard"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = Leaderboardmodel.fromJson(items);
      print(" sub catstatus is ${response.body}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}


Future<Enrolledmodel?> enrolledapi({required String header,required String testtype , required String testid})async{
  Enrolledmodel? result;

  try {
    final response = await http.get(
        Uri.parse("http://3.227.35.5:3002/api/v2/enroll?testType=$testtype&testId=$testid"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $header"
    });

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body.toString());
      result = Enrolledmodel.fromJson(items);
      print("enrolled status is ${response.body}");
      print("test status is ${testtype}${testid}");
    }
    else {
      print(" sub cat error status is ${response.statusCode}");
    }
  }catch(e){
    print("dsfg${e.toString()}");
  }
  return result;

}