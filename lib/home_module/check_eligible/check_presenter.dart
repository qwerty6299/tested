import 'package:TESTED/utils/apiconfig.dart';
import 'package:http/http.dart' as http;

import 'check_view.dart';

class CheckEligibilityPresenter {
  CheckEligibityView? _checkEligibityView;

  void getcheckResp(CheckEligibityView checkEligibityView, _body) {
    _checkEligibityView = checkEligibityView;

    Apiconfig()
        .eligibilityAPI(
      http.Client(),
      _body,
    )
        .then((value) {
      _checkEligibityView?.checkResponse(value);
    }).catchError((err) {
      _checkEligibityView?.checkEligibleErr(err);
    });
  }
}
