import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/connectivity.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/globals.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/common_widgets/no_internet.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/wallet_module/wallet_model.dart';
import 'package:TESTED/wallet_module/wallet_presenter.dart';
import 'package:TESTED/wallet_module/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> implements WalletPointsView {
  bool _isLoading = true;
  late int? _walletPoints;
  var noConnection;
  Widget _appBar() {
    return Container(
      height: 60,
      color: theme_color,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/HomePage", (r) => false);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: white_color),
              child: Icon(
                Icons.home,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 30),
              alignment: Alignment.center,
              child: Image.asset(
                'images/theme_2_logo.png',
                height: 180,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          // Container(
          //     padding: const EdgeInsets.all(6),
          //     margin: const EdgeInsets.symmetric(horizontal: 10),
          //     decoration: const BoxDecoration(
          //         shape: BoxShape.circle, color: white_color),
          //     child: const Icon(Icons.account_balance_wallet_outlined)),
        ],
      ),
    );
  }

  Widget _totalScore() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: white_color,
              ),
              padding: const EdgeInsets.all(20),
              child: CircularProgressIndicator(
                strokeWidth: 20,
                backgroundColor: shadow_color,
                value: _walletPoints != 0 ? _walletPoints! / 10 : 0.0,
                valueColor: AlwaysStoppedAnimation(dark_color),
              )),
          TextWidget(
            text: '${_walletPoints ?? 0}',
            size: 30,
            weight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget _coinTxt() {
    return const TextWidget(
      text: 'Coins',
      size: text_size_22,
      weight: FontWeight.w600,
    );
  }

  Widget _txt() {
    return const TextWidget(
      text: 'Take more test to earn more coins',
      size: text_size_18,
      weight: FontWeight.w400,
    );
  }

  Widget _viewSolutionBtn() {
    return Container(
      width: 150,
      height: 45,
      color: theme_orange_color,
      child: GradientButtonWidget(
          onTap: () {},
          color: theme_orange_color,
          child: const TextWidget(
            text: 'View Solution',
            color: Colors.white,
            size: text_size_16,
          )),
    );
  }

  Widget _backHomeBtn() {
    return Container(
      width: 150,
      height: 45,
      color: theme_color,
      child: GradientButtonWidget(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/HomePage", (r) => false);
          },
          color: theme_color,
          child: const TextWidget(
            text: 'Back to Home',
            color: Colors.white,
            size: text_size_16,
          )),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          _appBar(),
          _totalScore(),
          const SizedBox(
            height: 80,
          ),
          _coinTxt(),
          const SizedBox(
            height: 50,
          ),
          _txt(),
          const SizedBox(
            height: 60,
          ),
          _backHomeBtn()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _walletPtsapiCall();
  }

  void _walletPtsapiCall() {
    Internetconnectivity().isConnected().then((value) async {
      if (value == true) {
        WalletPresenter().getLoginDetails(this, TestedGlobals.userContact);
      } else {
        setState(() {
          _isLoading = false;
        });
        noConnection = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const NoInternet()));
        if (noConnection != null) {
          setState(() {
            _isLoading = true;
          });
          WalletPresenter().getLoginDetails(this, '6261589f320e36de9298156b');
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black_color,
      child: SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: _isLoading
                ? Center(
                    child: Container(
                      height: 50,
                      width: 120,
                      child: const Loader(),
                    ),
                  )
                : _body(),
          )),
    );
  }

  @override
  void walletErr(error) {
    print('Wallet err- -- $error');
    setState(() {
      _walletPoints = 0;
      _isLoading = false;
    });
  }

  @override
  void walletPtResp(WalletPointsModel _walletPointsModel) {
    print('Wallet Pts == ${_walletPointsModel.toMap()}');
    if (_walletPointsModel.status == true) {
      _walletPoints = _walletPointsModel.data![0].points ?? 0;
    } else {
      _walletPoints = 0;
    }
    setState(() {
      _isLoading = false;
    });
  }
}
