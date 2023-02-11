import 'dart:ui';

import 'package:TESTED/login/login_page.dart';
import 'package:TESTED/provider/ApiProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common_widgets/colors_widget.dart';
import 'common_widgets/font_size.dart';
import 'common_widgets/globals.dart';
import 'common_widgets/text_widget.dart';
import 'home_module/tabbar_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Widget _title() {
    return Center(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Image.asset(
            'images/theme_logo.png',
            height: 150,
          )),
    );
  }



  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          _title(),
        ],
      ),
    );
  }
  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token")??"";
    setState(() {
      thetoken=tok;
    });
    print("the splashscreen is $thetoken");
  }
  String thetoken="";
  @override
  void initState() {
    gettoken();
    Future.delayed(const Duration(seconds: 4), () async {
      if (thetoken=="") {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));

      } else {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
            create: (context) => CategoryProvider(),
            child: BottomTabbarclass(selectedIndex: 0,))));
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            body: _body(),

          )),
    );
  }
}
