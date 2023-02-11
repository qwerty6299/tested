import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:TESTED/forget_password/forget_pwd_model.dart';
import 'package:TESTED/forget_password/reset_otp/reset_pwd_model.dart';
import 'package:TESTED/home_module/check_eligible/check_model.dart';
import 'package:TESTED/home_module/delete_user_module/delete_model.dart';
import 'package:TESTED/home_module/home_mvp/homepage_model.dart';
import 'package:TESTED/login/login_model.dart';
import 'package:TESTED/login/otp_module/otp_model.dart';
import 'package:TESTED/register/register_model.dart';
import 'package:TESTED/result_module/result_model.dart';
import 'package:TESTED/wallet_module/wallet_model.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

class Apiconfig {
  static var timeoutrespon = {"status": false, "message": "timeout"};

  static Future<dynamic> postAPITyp(url, [header, params]) async {
    print('post');
    print(header);
    print(json.encode(params));
    print(url);
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: json.encode(params),
            headers: header,
          )
          .timeout(const Duration(seconds: 20));

      final responseBody = json.decode(response.body);

      return responseBody;
    } on TimeoutException catch (e) {
      print('Timeout $e');
      return timeoutrespon;
    } on SocketException catch (e) {
      print('socketeee: $e');
      return timeoutrespon;
    } on Error catch (e) {
      print("in catch--");
      print('Error: $e');
    }
  }

  static Future<dynamic> getMethod(url, [header]) async {
    print(url);
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: header,
          )
          .timeout(const Duration(seconds: 20));

      final statusCode = response.statusCode;
      if (statusCode != 200 || response.body == null) {
        throw TimeoutException(
            'An error ocurred : [Status Code : $statusCode]');
      }
      final responseBody = json.decode(response.body);

      return responseBody;
    } on TimeoutException catch (e) {
      print('Timeout $e');
      return timeoutrespon;
    } on SocketException catch (e) {
      print(e);
      return timeoutrespon;
    } on Error catch (e) {
      print('Error: $e');
    }
  }

  Future<LoginModel> loginApi(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response =
        await postAPITyp(TestedContants.BASE_URL + 'login', header, request);
    print('response === $response');
    LoginModel data = LoginModel.fromMap(response);
    return data;
  }

  Future<RegisterModel> regiserApi(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response =
        await postAPITyp(TestedContants.BASE_URL + 'register', header, request);

    RegisterModel data = RegisterModel.fromMap(response);
    return data;
  }

  Future<OtpModel> otpverfifyApi(http.Client client, request, _otpCode) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response = await postAPITyp(
        TestedContants.BASE_URL + 'contact-verify?code=$_otpCode',
        header,
        request);

    OtpModel data = OtpModel.fromMap(response);
    return data;
  }

  Future<HomepageModel> homePageAPI(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response = await postAPITyp(
        TestedContants.BASE_URL + 'course-data', header, request);
    print(response);
    HomepageModel data = HomepageModel.fromMap(response);
    return data;
  }

  Future<WalletPointsModel> walletPointsApI(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response = await getMethod(
        TestedContants.BASE_URL + 'get-points/$request', header);
    WalletPointsModel data = WalletPointsModel.fromMap(response);
    return data;
  }

  Future<TestResultModel> testResultAPI(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response = await postAPITyp(
        TestedContants.BASE_URL + 'answer-report', header, request);
    print(response);
    TestResultModel data = TestResultModel.fromMap(response);
    return data;
  }

  Future<EligibilityModel> eligibilityAPI(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response = await postAPITyp(
        TestedContants.BASE_URL + 'test-eligible', header, request);
    EligibilityModel data = EligibilityModel.fromMap(response);
    return data;
  }

  Future<ForgetPwdModel> forgetPwdApi(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response =
        await postAPITyp(TestedContants.BASE_URL + 'forgot', header, request);
    ForgetPwdModel data = ForgetPwdModel.fromMap(response);
    print(data.toMap());
    return data;
  }

  Future<ResetPwdModel> resetPwdApi(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response =
        await postAPITyp(TestedContants.BASE_URL + 'reset', header, request);
    ResetPwdModel data = ResetPwdModel.fromMap(response);
    print(data.toMap());
    return data;
  }

  Future<DeleteUserModel> deleteAccApi(http.Client client, request) async {
    var header = {
      "Content-Type": "application/json",
      "API_KEY": TestedContants.API_KEY
    };

    final response = await postAPITyp(
        TestedContants.BASE_URL + 'users/delete', header, request);
    print(response);
    DeleteUserModel data = DeleteUserModel.fromMap(response);
    return data;
  }
}
