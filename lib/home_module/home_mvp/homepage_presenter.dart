import 'package:TESTED/utils/apiconfig.dart';
import 'package:http/http.dart' as http;

import 'homepage_view.dart';

class HomePresenter {
  HomepgeView? _homepgeView;

  void getLoginDetails(HomepgeView homepgeView, _body) {
    _homepgeView = homepgeView;

    Apiconfig()
        .homePageAPI(
      http.Client(),
      _body,
    )
        .then((value) {
      _homepgeView?.homeResponse(value);
    }).catchError((err) {
      _homepgeView?.homeErr(err);
    });
  }
}
