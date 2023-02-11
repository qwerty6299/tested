import 'dart:convert';
import 'dart:io';

import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/connectivity.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/common_widgets/no_internet.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/login/otp_module/otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:TESTED/register/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Courseslistmodel.dart';
import '../model/NewSignupModel.dart';
import 'register_presenter.dart';
import 'register_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> implements RegisterView {
  final _nameController = TextEditingController();
  final _contctController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwrdController = TextEditingController();
  final _pwdCnfController = TextEditingController();
  final specialityController = TextEditingController();
  Courseslistmodel? courseslistmodel;
  Map<String?, dynamic>? specialityChoosen = null;
  String? specialityId;
  String? typeApi;
  List<dynamic> specialityListItem = [];
  List<Datum> categoryItemlist = [];
  String name="";
  String id="";
  Future getmycourses()async{
    final response = await http.get(Uri.parse("http://3.227.35.5:3002/api/auth/v2/course"));

      if (response.statusCode == 200) {
        print("ther re is ${response.body}");

        setState(() {
          courseslistmodel = Courseslistmodel.fromJson(json.decode(response.body));
          for( var item in courseslistmodel!.data ){
            specialityListItem.add({
              "name" : item.name,
              "id" : item.id
            });
          }


          print('working 3');
          //print(dataUserDetailsModel);

        });

      }
      else {
        print(" 0000 ${response.body}");
      }
    return specialityListItem;

  }
  bool _showPwd = true;
  bool _shwCnfPwd = true;
  bool _isLoading = false;

  String? dropdownvalue;
  String _nmValidatn = '';
  String _phnValidatn = '';
  String _emailValidatn = '';
  String _pwdValidatn = '';
  String _cnfpwdValidatn = '';
  bool dropDwnValidty = false;
  var noConnection;
  Widget _titleLogo() {
    return Container(
      child: Image.asset(
        'images/theme_logo.png',
        height: 100,
      ),
    );
  }
  static  calltoast({required String toastname}){
    Fluttertoast.showToast(
        msg: '$toastname',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: shadow_color,
        textColor: red_color.shade700,
        fontSize: 16.0);
  }

  Widget _registerTxt() {
    return Container(
      margin: const EdgeInsets.all(0),
      child: const TextWidget(
        text: "Welcome to Register Page",
        size: text_size_22,
        weight: FontWeight.w600,
        color: black_color,
      ),
    );
  }

  Widget _nameField() {
    return Container(
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
          Expanded(
            child: Container(
              color: transparent,
              width: MediaQuery.of(context).size.width - 180,
              child: TextFormField(
                  controller: _nameController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  cursorColor: black_color,
                  cursorWidth: 1.0,
                  style: const TextStyle(
                      color: black_color,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  onChanged: (value) {

                  },
                  decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      hintText: "Enter your name",
                      hintStyle: TextStyle(
                          color: GREY_COLOR_GREY_400,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactField() {
    return Container(
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
          Expanded(
            child: Container(
              color: transparent,
              width: MediaQuery.of(context).size.width - 180,
              child: TextFormField(
                  controller: _contctController,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  cursorColor: black_color,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorWidth: 1.0,
                  onChanged: (value) {

                  },
                  style: const TextStyle(
                      color: black_color,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      hintText: "Enter your mobile number",
                      hintStyle: TextStyle(
                          color: GREY_COLOR_GREY_400,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailField() {
    return Container(
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
          Expanded(
            child: Container(
              color: transparent,
              width: MediaQuery.of(context).size.width - 180,
              child: TextFormField(
                  controller: _emailController,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  cursorColor: black_color,
                  onChanged: (value) {

                  },
                  inputFormatters: [
                    FilteringTextInputFormatter((RegExp('[\\ ]')),
                        allow: false),
                  ],
                  cursorWidth: 1.0,
                  style: const TextStyle(
                      color: black_color,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      hintText: "Enter your email ID",
                      hintStyle: TextStyle(
                          color: GREY_COLOR_GREY_400,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pwdField() {
    return Container(
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
          Expanded(
            child: Container(
              color: transparent,
              width: MediaQuery.of(context).size.width - 180,
              child: TextFormField(
                  controller: _passwrdController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  obscureText: _showPwd,
                  cursorColor: black_color,
                  cursorWidth: 1.0,
                  style: const TextStyle(
                      color: black_color,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  onChanged: (value) {

                  },
                  decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                          color: GREY_COLOR_GREY_400,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none)),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showPwd = !_showPwd;
              setState(() {});
            },
            child: Container(
                height: 25,
                margin: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  !_showPwd
                      ? 'images/Eye-Icon-wsj93.png'
                      : 'images/icons8-hide-96.png',
                  color: shadow_color,
                )),
          )
        ],
      ),
    );
  }

  Widget _confirmpwdField() {
    return Container(
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
          Expanded(
            child: Container(
              color: transparent,
              width: MediaQuery.of(context).size.width - 180,
              child: TextFormField(
                  controller: _pwdCnfController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  obscureText: _shwCnfPwd,
                  cursorColor: black_color,
                  cursorWidth: 1.0,
                  onChanged: (value) {

                  },
                  style: const TextStyle(
                      color: black_color,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      hintText: "Confirm your password",
                      hintStyle: TextStyle(
                          color: GREY_COLOR_GREY_400,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none)),
            ),
          ),
          GestureDetector(
            onTap: () {
              _shwCnfPwd = !_shwCnfPwd;
              setState(() {});
            },
            child: Container(
                height: 25,
                margin: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  !_shwCnfPwd
                      ? 'images/Eye-Icon-wsj93.png'
                      : 'images/icons8-hide-96.png',
                  color: shadow_color,
                )),
          )
        ],
      ),
    );
  }


  Widget _courseDrpdwn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: transparent,
          border: Border.all(width: 0.5, color: shadow_color),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          // Expanded(
          //   child:courseslistmodel==null?Text(""): DropdownButton(
          //     isExpanded: true,
          //     underline: const SizedBox(
          //       height: 0,
          //     ),
          //     value: courseslistmodel!.data,
          //     hint: const TextWidget(
          //         text: 'Select any',
          //         color: Colors.grey,
          //         size: text_size_14,
          //         weight: FontWeight.normal),
          //     icon: const Icon(
          //       Icons.keyboard_arrow_down,
          //     ),
          //     items: categoryItemlist.map((items) {
          //       return DropdownMenuItem(
          //         value: items.name,
          //         child: Padding(
          //           padding:  EdgeInsets.only(left: 10),
          //           child: TextWidget(
          //             text: items.name,
          //             size: text_size_14,
          //           ),
          //         ),
          //       );
          //     }).toList(), onChanged:(newval) {
          //       setState(() {
          //         selectedSpinnerItem = newval.toString();
          //       });
          //       print("dg$selectedSpinnerItem");
          //   },
          //     // onChanged: (Courseslistmodel? newValue) {
          //     //   setState(() {
          //     //
          //     //     dropDwnValidty = false;
          //     //     courseslistmodel = newValue!;
          //     //     print("bdfjsb$dropdownvalue");
          //     //   });
          //     // },
          //   ),
          // ),
          Expanded(
            child:  DropdownButton(
              hint: Text('Select any one',style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),),
                        elevation: 1,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        isDense: false,
                        isExpanded: true,
                        underline: SizedBox(),
                       style: TextStyle(
                color: Colors.grey,
                fontSize: 12
            ),

                        dropdownColor: Colors.grey.shade50,
                        icon: Icon(Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        value: specialityChoosen,
                        items: specialityListItem.map(
                                (dynamic valueItem){
                              print("this is value item ${valueItem}");
                              return DropdownMenuItem(
                                  value: valueItem as Map,
                                  child: Text(valueItem["name"].toString(),style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12
                                  ),));
                            }
                        ).toList(),
                        onChanged: (dynamic value){
                          setState(() {
                            print("this is value ${value}");
                            specialityId = value!["id"].toString();
                            typeApi = value!["name"].toString();
                            specialityChoosen=value;

                          });
                        }
                    ),



          ),
        ],
      ),
    );
  }

  Widget _alreadyACCField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(
            text: 'If you already have an account ',
            size: text_size_15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/LoginPage", (r) => false);
            },
            child: const TextWidget(
              text: 'Click here',
              size: text_size_16,
              color: theme_color,
              weight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _Loginbtn() {
    return SizedBox(
      width: 150,
      height: 45,
      child: GradientButtonWidget(
          onTap: () {
            if(_nameController.text.toString().isEmpty){
              calltoast(toastname: 'name field is empty');
            }
           else  if(_contctController.text.toString().isEmpty){
              calltoast(toastname: 'contact field is empty');
            }
            else   if(_contctController.text.length!=10){
              calltoast(toastname: 'contact field is not valid');
            }
            else   if(_emailController.text.toString().isEmpty){
              calltoast(toastname: 'Email field is empty');
            }
            else   if(_passwrdController.text.toString().isEmpty){
              calltoast(toastname: 'password field is empty');
            }
            else   if(_emailController.text.toString().isEmpty){
              calltoast(toastname: 'Email field is empty');
            }
            else  if(_pwdCnfController.text.toString().isEmpty){
              calltoast(toastname: 'confirm password field is empty');
            }
            else  if(specialityId==null){
              calltoast(toastname: 'choose atleast one exam');
            }
             else {
               apipostsignup(name: '${_nameController.text.toString()}',
                   phone: '${_contctController.text.toString()}',
                   password: '${_passwrdController.text.toString()}',
                   course: '${specialityId}',
                   email: '${_emailController.text.toString()}');
             }

          },
          child: const TextWidget(
            text: 'Submit',
            color: Colors.white,
            weight: FontWeight.bold,
            size: 18,
          )),
    );
  }

  // bool _validNm() {
  //   if (_nameController.text.isNotEmpty) {
  //     _nmValidatn = '';
  //     setState(() {});
  //     return false;
  //   } else {
  //     _nmValidatn = 'Please enter your name';
  //     setState(() {});
  //     return true;
  //   }
  // }
  //
  // bool _validPhn() {
  //   if (_contctController.text.isNotEmpty) {
  //     if (_contctController.text.length < 10) {
  //       _phnValidatn = 'Please enter valid contact number';
  //     } else {
  //       _phnValidatn = '';
  //     }
  //
  //     setState(() {});
  //     return false;
  //   } else {
  //     _phnValidatn = 'Please enter your contact number';
  //     setState(() {});
  //     return true;
  //   }
  // }
  //
  // bool _validemail() {
  //   if (_emailController.text.isNotEmpty) {
  //     RegExp regx = RegExp(
  //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  //     if (regx.hasMatch(_emailController.text)) {
  //       _emailValidatn = '';
  //       setState(() {});
  //       return false;
  //     } else {
  //       _emailValidatn = 'Please enter valid email ID';
  //       setState(() {});
  //       return true;
  //     }
  //   } else {
  //     _emailValidatn = 'Please enter your email ID';
  //     setState(() {});
  //     return true;
  //   }
  // }
  //
  // bool _validpwd() {
  //   if (_passwrdController.text.isNotEmpty) {
  //     _pwdValidatn = '';
  //     setState(() {});
  //     return false;
  //   } else {
  //     _pwdValidatn = 'Please enter password';
  //     setState(() {});
  //     return true;
  //   }
  // }
  //
  // bool _validcnfpwd() {
  //   if (_pwdCnfController.text.isNotEmpty) {
  //     _cnfpwdValidatn = '';
  //     setState(() {});
  //     return false;
  //   } else {
  //     _cnfpwdValidatn = 'Please enter confirm password';
  //     setState(() {});
  //     return true;
  //   }
  // }
  //
  // bool _validDrpDwn() {
  //   if (dropdownvalue != null) {
  //     dropDwnValidty = false;
  //     setState(() {});
  //     return false;
  //   } else {
  //     dropDwnValidty = true;
  //     setState(() {});
  //     return true;
  //   }
  // }

  Widget _body() {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _titleLogo(),
          _registerTxt(),
          const SizedBox(
            height: 20,
          ),
          _nameField(),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: _nmValidatn,
              color: red_color.shade700,
              size: text_size_14,
            ),
          ),
          _contactField(),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: _phnValidatn,
              color: red_color.shade700,
              size: text_size_14,
            ),
          ),
          _emailField(),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: _emailValidatn,
              color: red_color.shade700,
              size: text_size_14,
            ),
          ),
          _pwdField(),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: _pwdValidatn,
              color: red_color.shade700,
              size: text_size_14,
            ),
          ),
          _confirmpwdField(),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: _cnfpwdValidatn,
              color: red_color.shade700,
              size: text_size_14,
            ),
          ),
          _courseDrpdwn(),
          Container(

            margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: dropDwnValidty ? 'Please select a course' : '',
              color: red_color.shade700,
              size: text_size_14,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          _Loginbtn(),
          const SizedBox(
            height: 100,
          ),
          _alreadyACCField(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
void apipostsignup({required String name, required String phone
    ,required String password,required String email,required String course})async{
    NewSignupModel? result;

    try {
      var body= {
        "name": "$name",
        "phone": "$phone",
        "password": "$password",
        "email": "$email",
        "course": "$course"
      };

      final response = await http.post(
          Uri.parse("http://3.227.35.5:3002/api/auth/v2/register"),body: body);

      if (response.statusCode == 200) {
        setState(() {
          final items = jsonDecode(response.body.toString());
          result = NewSignupModel.fromJson(items);
          print(" sub catstatus is ${response.body}");
          print("the body is$body");
            print("dfg${result?.otp.toString()}");
            calltoast(toastname: '${result?.otp.toString()}');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPScreen(
                    phone: _contctController.text,
                    otp: '${result?.otp.toString()}',

                  )));
        });

      }
      else {
        print(" sub cat error status is ${response.statusCode}");
      }
    }catch(e){
      print("dsfg${e.toString()}");
    }


  }

  @override
  void initState() {
    super.initState();
    getmycourses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white_color,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: white_color,
          body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: _body()),
        ),
      ),
    );
  }

  @override
  void registerErr(error) {
    print('register $error');
    setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: shadow_color,
        textColor: red_color.shade700,
        fontSize: 16.0);
  }

  @override
  void registerResponse(RegisterModel _registerModel) {
    print('REgister resp = ${_registerModel.toMap()}');
    setState(() {
      _isLoading = false;
    });
    if (_registerModel.status == true) {
      Fluttertoast.showToast(
          msg: _registerModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: red_color.shade700,
          fontSize: 16.0);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(
                    phone: _contctController.text, otp: '',

                  )));
    } else {
      Fluttertoast.showToast(
          msg: _registerModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: red_color.shade700,
          fontSize: 16.0);
    }
  }
}
