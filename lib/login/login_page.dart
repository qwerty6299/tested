import 'dart:convert';

import 'package:TESTED/common_widgets/auth_utls.dart';
import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/connectivity.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/globals.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/common_widgets/no_internet.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/forget_password/forget_pwd_contact.dart';
import 'package:TESTED/home_module/tabbar_page.dart';
import 'package:TESTED/login/login_model.dart';
import 'package:TESTED/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/NewLoginModel.dart';
import '../provider/ApiProviders.dart';
import 'package:http/http.dart'as http;
import 'login_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
  var _phoneController = TextEditingController();
  TextEditingController _passwrdController = TextEditingController();
  ValueNotifier<bool> showpwd = ValueNotifier(true);


  _checkPhn(text) {
    var _regg = RegExp(r"^[0-9]");
    if (_regg.hasMatch(text) && _phoneController.text.length == 10) {
      setState(() {

      });
    } else {
      setState(() {

      });
    }
  }

  Widget _loginTxt() {
    return Container(
      margin: const EdgeInsets.all(0),
      child: const TextWidget(
        text: "Login",
        size: text_size_20,
        weight: FontWeight.w400,
        color: black_color,
      ),
    );
  }

  Widget _titleLogo() {
    return SizedBox(
      height: 120,
      child: Image.asset('images/theme_logo.png'),
    );
  }

  Widget _contactNo() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 45,
          decoration: BoxDecoration(
              color: white_color,
              border: Border.all(width: 0.5, color: shadow_color),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 8,
              ),
              Container(
                // height: 35,
                color: transparent,
                width: MediaQuery.of(context).size.width - 180,
                child: TextFormField(
                    controller: _phoneController,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    cursorColor: black_color,
                    cursorWidth: 1.0,
                    style: const TextStyle(
                        color: black_color,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        hintText: "Enter Phone Number",
                        hintStyle: TextStyle(
                            color: GREY_COLOR_GREY_400,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        border: InputBorder.none)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),

        Container(

          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 45,
          decoration: BoxDecoration(
              color: white_color,
              border: Border.all(width: 0.5, color: shadow_color),
              borderRadius: BorderRadius.circular(30)),
          child: ValueListenableBuilder<bool>(
            valueListenable: showpwd,
            builder: (context , bool count,_) {
              return TextFormField(

                  obscureText: count,
                  controller: _passwrdController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  maxLength: 50,

                  cursorColor: black_color,
                  cursorWidth: 1.0,

                  style: const TextStyle(
                      color: black_color,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  decoration:  InputDecoration(
                    suffixIcon:  GestureDetector(
                      onTap: () {
                     showpwd.value = !showpwd.value;
                     print(showpwd.value);
                     print(count);
                      },
                      child: Container(
                          height: 25,
                          margin: const EdgeInsets.only(right: 15),
                          child: Image.asset(

                            showpwd.value==false?"images/Eye-Icon-wsj93.png":'images/icons8-hide-96.png',
                            color: shadow_color,
                          )),
                    ),
                      counterText: '',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                          color: GREY_COLOR_GREY_400,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none));
            },
          ),

        ),

      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Loginbtn() {
    return SizedBox(
      width: 150,
      height: 45,
      child: GradientButtonWidget(
          onTap: () {
            if (_phoneController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Phone cannot be empty',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: shadow_color,
                  textColor: red_color.shade700,
                  fontSize: 16.0);
            }
            else  if (_phoneController.text.length!=10) {
              Fluttertoast.showToast(
                  msg: 'Number is not Valid',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: shadow_color,
                  textColor: red_color.shade700,
                  fontSize: 16.0);
            }
         else   if (_passwrdController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Password cannot be empty',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: shadow_color,
                  textColor: red_color.shade700,
                  fontSize: 16.0);
            }
           else{

             postlogin();
             Fluttertoast.showToast(
                 msg: '$newLoginmessage',
                 toastLength: Toast.LENGTH_SHORT,
                 gravity: ToastGravity.BOTTOM,
                 backgroundColor: shadow_color,
                 textColor: red_color.shade700,
                 fontSize: 16.0);
            }



          },
          child:TextWidget(
            text: 'Login',
            color: Colors.white,
            weight: FontWeight.bold,
            size: 18,
          )),
    );
  }

  Widget _bottomtitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(
            text: 'POWERED BY - ',
            size: text_size_14,
          ),
          GestureDetector(
            onTap: () {

            },
            child: const TextWidget(
              text: 'Soradis Digital',
              size: text_size_16,
              color: theme_color,
              weight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _togoRegister() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(
            text: 'New user? ',
            size: text_size_16,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
            child: const TextWidget(
              text: 'Click here',
              size: text_size_18,
              color: theme_color,
              weight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _forgetPwd() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const ForgetPwdLogin()));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 25),
        alignment: Alignment.centerRight,
        child: const TextWidget(
          text: 'Forget password?',
          size: text_size_16,
          color: theme_color,
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      color: white_color,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleLogo(),
          _loginTxt(),
          const SizedBox(
            height: 50,
          ),
          _contactNo(),
          const SizedBox(
            height: 20,
          ),
          _forgetPwd(),
          const SizedBox(
            height: 50,
          ),
        _Loginbtn(),
          const SizedBox(
            height: 50,
          ),
          _togoRegister()
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Container(
      color: white_color,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: white_color,
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: WillPopScope(onWillPop: _onWillPop, child: _body())),
            bottomNavigationBar: _bottomtitle(),
          )),
    );
  }

  Future<bool> _onWillPop() async {
    return false;
  }


  NewLoginModel? newLoginModel;
  bool? newLoginstatus;
  String newLoginmessage="";
  String newLoginid="";
  String newlogintoken="";

bool logintap=false;

  void postlogin()async{



      var body={
        "password":"${_passwrdController.text.toString()}",
        "phone":"${_phoneController.text.toString()}"
      };
      final response = await http.post(
          Uri.parse("http://3.227.35.5:3002/api/auth/v2/login"),body:body );

      if (response.statusCode == 200) {

        setState(() {

        print("the body is $body");
        final items = response.body.toString();
        newLoginModel = newLoginModelFromJson(items);
        print(" login catstatus is ${response.body}");

          newLoginstatus=newLoginModel!.status;
          newLoginmessage=newLoginModel!.message.toString();
          newLoginid=newLoginModel!.data.id.toString();
        newlogintoken=newLoginModel!.data.token.toString();


          print("the status is $newLoginstatus");
          print("the status is $newLoginid");
          print("the status is $newlogintoken");
        });
        if(newLoginstatus=true){
          Fluttertoast.showToast(
              msg: '$newLoginmessage',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: shadow_color,
              textColor: red_color.shade700,
              fontSize: 16.0);
          savetoken(token: '${newLoginModel!.data.token.toString()}');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
              create: (context) => CategoryProvider(),
              child: BottomTabbarclass(selectedIndex: 0,))));
          setState((){

          });

        }
        else{
          Fluttertoast.showToast(
              msg: 'Something is wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: shadow_color,
              textColor: red_color.shade700,
              fontSize: 16.0);
        }
      }
      else{
        print("error${response.body}");
        print("error${response.statusCode}");
      }
  }
  Future savetoken({required String token})async{
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("token",token).toString();

  }
}
