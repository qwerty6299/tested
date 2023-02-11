/*
Author Name : Animesh Banerjee
Creted On : 07/04/2022
*/

import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/forget_password/forget_pwd_model.dart';
import 'package:TESTED/forget_password/reset_pwd_module/reset_pwd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../forget_pwd_presenter.dart';
import '../forget_pwd_view.dart';

class ResetOtpPage extends StatefulWidget {
  final String? contct;
  final data;
  const ResetOtpPage({Key? key, this.contct, required this.data})
      : super(key: key);

  @override
  State<ResetOtpPage> createState() => _ResetOtpPageState();
}

class _ResetOtpPageState extends State<ResetOtpPage> implements ForgetPwdView {
  final _pincontroller = TextEditingController();
  bool _isValidNoErr = false;
  bool _isLoading = false;
  bool resendOtp = false;
  Widget _continueBtn() {
    return Container(
      width: 180,
      height: 55,
      color: transparent,
      child: GradientButtonWidget(
          onTap: () {
            var _reqBody = {
              "contact": "${widget.contct}",
              "otp": _pincontroller.text
            };
            setState(() {
              _isLoading = true;
            });
            ForgetPwdPresenter().getforgetPwdDetails(this, _reqBody);
          },
          child: const TextWidget(
            text: 'Continue',
            color: Colors.white,
            weight: FontWeight.bold,
            size: 18,
          )),
    );
  }

  Widget _resendOtp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: 'Did not receive OTP? ',
          color: Colors.grey.shade400,
          size: text_size_18,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isLoading = true;
              resendOtp = true;
            });
            Fluttertoast.showToast(
                msg: 'OTP has been successfully sent to the registered number.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: shadow_color,
                textColor: red_color.shade700,
                fontSize: 16.0);
            ForgetPwdPresenter().getforgetPwdDetails(this, widget.data);
          },
          child: const TextWidget(
            text: 'Click here',
            color: Colors.blue,
            size: text_size_20,
          ),
        )
      ],
    );
  }

  Widget _otp() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 55,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.5))),
            child: Center(
              child:
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 50, right: 50),
                child: PinCodeTextField(
                  appContext: context,
                  enablePinAutofill: false,
                  mainAxisAlignment: MainAxisAlignment.center,
                  pastedTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeFillColor: Colors.white,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      borderWidth: 2,
                      selectedColor: Colors.grey,
                      shape: PinCodeFieldShape.underline,
                      fieldOuterPadding: const EdgeInsets.only(
                          top: 6, left: 6, right: 6, bottom: 8),
                      fieldHeight: 35,
                      fieldWidth: 35),
                  cursorColor: Colors.black,
                  controller: _pincontroller,
                  cursorHeight: 19,
                  cursorWidth: 1.2,
                  backgroundColor: Colors.white,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  autoFocus: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onCompleted: (value) {},
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
          // _isvalid
          //     ? Container(
          //         height: 15,
          //         margin: EdgeInsets.only(top: 0, bottom: 10),
          //         alignment: Alignment.center,
          //         child: TextWidget(
          //             text: errormsg,
          //             color: red_color,
          //             size: text_font_size_x_small,
          //             weight: FontWeight.w700),
          //       )
          //     : Container(
          //         height: 15,
          // ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: white_color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            child: Image.asset('images/theme_logo.png'),
          ),
          const TextWidget(
            text: 'Please Enter OTP',
            size: text_size_20,
            weight: FontWeight.w500,
          ),
          const SizedBox(
            height: 40,
          ),
          const TextWidget(
            text: 'An OTP has been sent to',
            size: text_size_18,
          ),
          const SizedBox(
            height: 5,
          ),
          const TextWidget(
            text: 'your mobile number',
            size: text_size_18,
          ),
          const SizedBox(
            height: 80,
          ),
          _otp(),
          const SizedBox(
            height: 80,
          ),
          _isLoading
              ? Container(
                  height: 50,
                  width: 120,
                  child: const Loader(),
                )
              : _continueBtn(),
          const SizedBox(
            height: 100,
          ),
          _resendOtp(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _pincontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent,
      child: SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
            backgroundColor: white_color,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: _body()),
          )),
    );
  }

  @override
  void forgetPwdErr(error) {
    print('otp - error $error');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void forgetPwdResponse(ForgetPwdModel _forgetPwdModelResp) {
    print('_forgetPwdModelResp == ${_forgetPwdModelResp.toMap()}');
    setState(() {
      _isLoading = false;
    });
    if (_forgetPwdModelResp.status == true &&
        _forgetPwdModelResp.data == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPwdPage(
                    contctNo: '${widget.contct}',
                  )));
    }
  }
}
