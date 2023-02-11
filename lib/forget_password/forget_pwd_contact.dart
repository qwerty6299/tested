import 'package:TESTED/common_widgets/auth_utls.dart';
import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/connectivity.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/globals.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/common_widgets/no_internet.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/forget_password/forget_pwd_model.dart';
import 'package:TESTED/forget_password/reset_otp/reset_otp.dart';
import 'package:TESTED/home_module/tabbar_page.dart';
import 'package:TESTED/login/login_model.dart';
import 'package:TESTED/login/otp_module/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'forget_pwd_presenter.dart';
import 'forget_pwd_view.dart';

class ForgetPwdLogin extends StatefulWidget {
  const ForgetPwdLogin({Key? key}) : super(key: key);

  @override
  State<ForgetPwdLogin> createState() => _ForgetPwdLoginState();
}

class _ForgetPwdLoginState extends State<ForgetPwdLogin>
    implements ForgetPwdView {
  var _phoneController = TextEditingController();
  TextEditingController _passwrdController = TextEditingController();
  bool _showPwd = true;
  final String _url = 'https://www.soradisdigital.com';
  bool _validPhone = false;
  bool _validPwd = false;
  bool _isLoading = false;
  var noConnection;

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  _checkPhn(text) {
    var _regg = RegExp(r"^[0-9]");
    if (_regg.hasMatch(text) && _phoneController.text.length == 10) {
      setState(() {
        _validPhone = false;
      });
    } else {
      setState(() {
        _validPhone = true;
      });
    }
  }

  Widget _loginTxt() {
    return Container(
      margin: const EdgeInsets.all(0),
      child: const TextWidget(
        text: "Forget Password",
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
                    onChanged: (value) {
                      if (_validPhone == true) {
                        setState(() {
                          _validPhone = false;
                        });
                      }
                    },
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
        _validPhone
            ? Container(
                alignment: Alignment.centerLeft,
                color: white_color,
                margin: const EdgeInsets.only(left: 30, top: 8),
                child: TextWidget(
                    text: 'Please enter phone number',
                    size: text_size_14,
                    color: Colors.red.shade800),
              )
            : const SizedBox(
                height: 0,
              ),
        const SizedBox(
          height: 20,
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
            if (_phoneController.text.isNotEmpty) {
              _checkPhn(_phoneController.text);
            } else {
              setState(() {
                _validPhone = true;
              });
            }

            if (_validPhone == false) {
              var _requestBody = {
                "contact": '${_phoneController.text}',
              };
              setState(() {
                _isLoading = true;
              });
              Internetconnectivity().isConnected().then((value) async {
                if (value == true) {
                  ForgetPwdPresenter().getforgetPwdDetails(this, _requestBody);
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                  noConnection = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const NoInternet()));
                  if (noConnection != null) {
                    setState(() {
                      _isLoading = true;
                    });
                    ForgetPwdPresenter()
                        .getforgetPwdDetails(this, _requestBody);
                  }
                }
              });
            }
          },
          child: const TextWidget(
            text: 'Continue',
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
              _launchURL();
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

  Widget _body() {
    return Container(
      color: white_color,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleLogo(),
          const SizedBox(
            height: 20,
          ),
          _loginTxt(),
          const SizedBox(
            height: 100,
          ),
          _contactNo(),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 50,
          ),
          _isLoading
              ? Container(
                  height: 50,
                  width: 120,
                  child: const Loader(),
                )
              : _Loginbtn(),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController = TextEditingController();
    _passwrdController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: _body()),
            bottomNavigationBar: _bottomtitle(),
          )),
    );
  }

  @override
  void forgetPwdErr(error) {
    print('error');
    print(error);
    setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(
        msg: 'Something went wrong!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: shadow_color,
        textColor: red_color.shade700,
        fontSize: 16.0);
  }

  @override
  void forgetPwdResponse(ForgetPwdModel _forgetPwdModelResp) {
    setState(() {
      _isLoading = false;
    });
    if (_forgetPwdModelResp.status == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetOtpPage(
                    contct: _phoneController.text,
                    data: {
                      "contact": '${_phoneController.text}',
                    },
                  )));
    } else {
      Fluttertoast.showToast(
          msg: _forgetPwdModelResp.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: red_color.shade700,
          fontSize: 16.0);
    }
  }
}
