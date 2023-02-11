import 'package:TESTED/utils/apiconfig.dart';
import 'package:http/http.dart' as http;

import 'result_view.dart';

class TestResultPresenter {
  TestResultView? _testResultView;

  void getLoginDetails(TestResultView testResultView, _body) {
    _testResultView = testResultView;

    Apiconfig()
        .testResultAPI(
      http.Client(),
      _body,
    )
        .then((value) {
      _testResultView?.testResultResp(value);
    }).catchError((err) {
      _testResultView?.testResultErr(err);
    });
  }
}
