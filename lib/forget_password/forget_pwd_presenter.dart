import 'package:TESTED/utils/apiconfig.dart';
import 'package:http/http.dart' as http;
import 'forget_pwd_view.dart';

class ForgetPwdPresenter {
  ForgetPwdView? _forgetPwdView;

  void getforgetPwdDetails(ForgetPwdView forgetPwdView, _body) {
    _forgetPwdView = forgetPwdView;

    Apiconfig()
        .forgetPwdApi(
      http.Client(),
      _body,
    )
        .then((value) {
      _forgetPwdView?.forgetPwdResponse(value);
    }).catchError((err) {
      _forgetPwdView?.forgetPwdErr(err);
    });
  }
}
