import 'package:TESTED/utils/apiconfig.dart';

import 'login_view.dart';
import 'package:http/http.dart' as http;

class LoginPresenter {
  LoginView? _loginView;

  void getLoginDetails(LoginView loginView, _body) {
    _loginView = loginView;

    Apiconfig()
        .loginApi(
      http.Client(),
      _body,
    )
        .then((value) {
      _loginView?.loginResponse(value);
    }).catchError((err) {
      _loginView?.loginErr(err);
    });
  }
}
