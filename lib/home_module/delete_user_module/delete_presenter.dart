import 'package:TESTED/home_module/delete_user_module/delete_view.dart';
import 'package:TESTED/utils/apiconfig.dart';
import 'package:http/http.dart' as http;

class DeleteAccPresenter {
  DeleteUserView? _deleteUserView;

  void getLoginDetails(DeleteUserView deleteUserView, _body) {
    _deleteUserView = deleteUserView;

    Apiconfig()
        .deleteAccApi(
      http.Client(),
      _body,
    )
        .then((value) {
      _deleteUserView?.deleteAccResp(value);
    }).catchError((err) {
      _deleteUserView?.deleteAccErr(err);
    });
  }
}
