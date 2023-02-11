import 'package:TESTED/utils/apiconfig.dart';
import 'package:TESTED/wallet_module/wallet_view.dart';
import 'package:http/http.dart' as http;

class WalletPresenter {
  WalletPointsView? _walletPointsView;

  void getLoginDetails(WalletPointsView walletPointsView, _body) {
    _walletPointsView = walletPointsView;

    Apiconfig()
        .walletPointsApI(
      http.Client(),
      _body,
    )
        .then((value) {
      _walletPointsView?.walletPtResp(value);
    }).catchError((err) {
      _walletPointsView?.walletErr(err);
    });
  }
}
