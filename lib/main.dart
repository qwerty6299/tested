import 'dart:async';

import 'package:TESTED/common_widgets/globals.dart';
import 'package:TESTED/provider/ApiProviders.dart';
import 'package:TESTED/register/register.dart';
import 'package:TESTED/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'aa_QuestionScreen/my_account_paage.dart';
import 'common_widgets/auth_utls.dart';
import 'home_module/tabbar_page.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences=await SharedPreferences.getInstance();
  final tok= preferences.getString("token")??"";
  print("the main tokoke is $tok");
  runApp( MyApp(token: '$tok',));

}

class MyApp extends StatelessWidget {
  String token;

   MyApp({Key? key,required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => CategoryProvider(),
        child: GetMaterialApp(
            title: 'TESTED',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:  SplashScreen(),
        ),
      );

  }
}
