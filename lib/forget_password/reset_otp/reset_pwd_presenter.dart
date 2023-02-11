import 'package:TESTED/utils/apiconfig.dart';
import 'package:http/http.dart' as http;

import 'reset_pwd_view.dart';

class ResetPwdPresenter {
  ResetPwdView? _resetPwdView;

  void getforgetPwdDetails(ResetPwdView resetPwdView, _body) {
    _resetPwdView = resetPwdView;

    Apiconfig()
        .resetPwdApi(
      http.Client(),
      _body,
    )
        .then((value) {
      _resetPwdView?.resetPwdResponse(value);
    }).catchError((err) {
      _resetPwdView?.resetPwdErr(err);
    });
  }
}
