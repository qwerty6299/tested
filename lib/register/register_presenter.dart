import 'package:TESTED/utils/apiconfig.dart';

import 'package:http/http.dart' as http;

import 'register_view.dart';

class RegisterPresenter {
  RegisterView? _registerView;

  void getLoginDetails(RegisterView registerView, _body) {
    _registerView = registerView;

    Apiconfig()
        .regiserApi(
      http.Client(),
      _body,
    )
        .then((value) {
      _registerView?.registerResponse(value);
    }).catchError((err) {
      _registerView?.registerErr(err);
    });
  }
}
