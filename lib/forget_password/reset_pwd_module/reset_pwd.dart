import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/connectivity.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/common_widgets/no_internet.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/forget_password/reset_otp/reset_pwd_model.dart';
import 'package:TESTED/forget_password/reset_otp/reset_pwd_presenter.dart';
import 'package:TESTED/forget_password/reset_otp/reset_pwd_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ResetPwdPage extends StatefulWidget {
  final String? contctNo;
  const ResetPwdPage({Key? key, required this.contctNo}) : super(key: key);

  @override
  State<ResetPwdPage> createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> implements ResetPwdView {
  // var _phoneController = TextEditingController();
  TextEditingController _passwrdController = TextEditingController();
  TextEditingController _cnfPasswrdController = TextEditingController();
  bool _showPwd = true;
  bool _showCnfPwd = true;
  final String _url = 'https://www.soradisdigital.com';
  bool _validPwd = false;
  bool _validCnPwd = false;
  bool _isLoading = false;
  var noConnection;

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  Widget _loginTxt() {
    return Container(
      margin: const EdgeInsets.all(0),
      child: const TextWidget(
        text: "Reset Password",
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
              Expanded(
                child: Container(
                  // height: 35,
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
                      onChanged: (value) {
                        if (_validPwd == true) {
                          setState(() {
                            _validPwd = false;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: black_color,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
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
        ),
        _validPwd
            ? Container(
                alignment: Alignment.centerLeft,
                color: white_color,
                margin: const EdgeInsets.only(left: 30, top: 8),
                child: TextWidget(
                    text: 'Please enter password',
                    size: text_size_14,
                    color: Colors.red.shade800),
              )
            : const SizedBox(
                height: 0,
              ),
        const SizedBox(
          height: 30,
        ),
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
              Expanded(
                child: Container(
                  // height: 35,
                  color: transparent,
                  width: MediaQuery.of(context).size.width - 180,
                  child: TextFormField(
                      controller: _cnfPasswrdController,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      obscureText: _showCnfPwd,
                      cursorColor: black_color,
                      cursorWidth: 1.0,
                      onChanged: (value) {
                        if (_validCnPwd == true) {
                          setState(() {
                            _validCnPwd = false;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: black_color,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      decoration: const InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          hintText: "Re-enter your password",
                          hintStyle: TextStyle(
                              color: GREY_COLOR_GREY_400,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          border: InputBorder.none)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showCnfPwd = !_showCnfPwd;
                  setState(() {});
                },
                child: Container(
                    height: 25,
                    margin: const EdgeInsets.only(right: 15),
                    child: Image.asset(
                      !_showCnfPwd
                          ? 'images/Eye-Icon-wsj93.png'
                          : 'images/icons8-hide-96.png',
                      color: shadow_color,
                    )),
              )
            ],
          ),
        ),
        _validCnPwd
            ? Container(
                alignment: Alignment.centerLeft,
                color: white_color,
                margin: const EdgeInsets.only(left: 30, top: 8),
                child: TextWidget(
                    text: 'Please confirm your password',
                    size: text_size_14,
                    color: Colors.red.shade800),
              )
            : const SizedBox(
                height: 0,
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
            if (_passwrdController.text.isNotEmpty) {
              setState(() {
                _validPwd = false;
              });
            } else {
              setState(() {
                _validPwd = true;
              });
            }
            if (_cnfPasswrdController.text.isNotEmpty &&
                (_cnfPasswrdController.text != _passwrdController.text)) {
              setState(() {
                _validCnPwd = true;
              });
            } else {
              setState(() {
                _validCnPwd = false;
              });
            }

            if (_validPwd == false && _validCnPwd == false) {
              var _requestBody = {
                "contact": "${widget.contctNo}",
                "password": "${_passwrdController.text}"
              };
              setState(() {
                _isLoading = true;
              });
              Internetconnectivity().isConnected().then((value) async {
                if (value == true) {
                  ResetPwdPresenter().getforgetPwdDetails(this, _requestBody);
                  // LoginPresenter().getLoginDetails(this, _requestBody);
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
                    ResetPwdPresenter().getforgetPwdDetails(this, _requestBody);
                    // LoginPresenter().getLoginDetails(this, _requestBody);
                  }
                }
              });
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
          _loginTxt(),
          const SizedBox(
            height: 80,
          ),
          _contactNo(),
          const SizedBox(
            height: 80,
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
    super.initState();
    _passwrdController = TextEditingController();
    _cnfPasswrdController = TextEditingController();
  }

  @override
  void dispose() {
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
  void resetPwdErr(error) {
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
  void resetPwdResponse(ResetPwdModel _resetPwdModel) {
    setState(() {
      _isLoading = false;
    });
    if (_resetPwdModel.status == true) {
      Fluttertoast.showToast(
          msg: _resetPwdModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: red_color.shade700,
          fontSize: 16.0);
      Navigator.pushReplacementNamed(context, "/LoginPage");
    } else {
      Fluttertoast.showToast(
          msg: _resetPwdModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: red_color.shade700,
          fontSize: 16.0);
    }
  }
}
