import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static final String endPoint = '';
  static final String ath_key = 'isLogin';
  static final String studentdData = "studentdData";
  static final String userType = 'user_type';
  static setIntValue(key, value) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();

    return sharedPref.setString(key, value);
  }

  static getIntValue(key) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();

    return sharedPref.getString(key) ?? null;
  }

  static getBoolValue(key) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();

    return sharedPref.getBool(key) ?? null;
  }

  static setBoolValue(key, value) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setBool(key, value);
  }

  static setStringValue(key, value) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString(key, value.toString());
  }

  static getStringValue(key) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(key) ?? null;
  }

//Set&Get User Type
  static Future<String?> getuserType(key) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();

    return sharedPref.getString(key);
  }

  static setuserType(key, value) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString(key, value);
  }

//Student data shop --Ruchita
  static setStudentData(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(studentdData, value);
  }

  static getStudentData(SharedPreferences prefs) {
    return prefs.getString(studentdData);
  }
}
