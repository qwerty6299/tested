import 'package:TESTED/utils/apiconfig.dart';

import 'package:http/http.dart' as http;

import 'otp_view.dart';

class OTPPresenter {
  OTPView? _oTPView;

  void getLoginDetails(OTPView oTPView, _body, otpcode) {
    _oTPView = oTPView;

    Apiconfig().otpverfifyApi(http.Client(), _body, otpcode).then((value) {
      _oTPView?.otpResponse(value);
    }).catchError((err) {
      _oTPView?.otpErr(err);
    });
  }
}
