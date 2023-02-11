import 'package:TESTED/answer_pdf_module/ans_pdf.dart';
import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/connectivity.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/globals.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/common_widgets/no_internet.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/result_module/result_model.dart';
import 'package:TESTED/result_module/result_view.dart';
import 'package:TESTED/wallet_module/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'result_presenter.dart';

class ResultPage extends StatefulWidget {
  final String? testNo;
  final data;
  final String? sid;
  final String? cid;
  final String? length;
  const ResultPage(
      {Key? key,
      required this.data,
      this.testNo,
      required this.sid,
      required this.cid,
      required this.length})
      : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> implements TestResultView {
  bool _isLoading = true;
  late TestResultModel _testResult;
  var noConnection;
  String? _pdfUrl;

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
            child: Image.asset(
              'images/theme_2_logo.png',
              height: 180,
              fit: BoxFit.fitHeight,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WalletPage()));
            },
            child: Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: white_color),
                child: const Icon(Icons.account_balance_wallet_outlined)),
          ),
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
          SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                strokeWidth: 20,
                backgroundColor: shadow_color,
                value:
                    _testResult.data!.score! / num.parse(widget.length ?? '1'),
                valueColor: const AlwaysStoppedAnimation(theme_orange_color),
              )),
          TextWidget(
            text: '${_testResult.data?.score ?? ''}',
            size: 30,
            weight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget _scoreTxt() {
    return TextWidget(
      text: 'Your Score out of ${widget.length ?? 0}',
      size: text_size_22,
      weight: FontWeight.w600,
    );
  }

  Widget _viewSolutionBtn() {
    return Container(
      width: 150,
      height: 45,
      color: theme_orange_color,
      child: GradientButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnswerPdfPage(
                          testNo: 1,
                          url: _pdfUrl,
                        )));
          },
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
          _scoreTxt(),
          const SizedBox(
            height: 50,
          ),
          _viewSolutionBtn(),
          const SizedBox(
            height: 50,
          ),
          _backHomeBtn()
        ],
      ),
    );
  }

  Future<bool> _willscope() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    print('DATA = ${widget.data}');
    resultApiCall();
  }

  Future<void> _getrewardsPointsAlert(BuildContext context, _points) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 20),
              height: 250,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    'images/1426770.png',
                    height: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextWidget(
                    text: "Congratulations!!!",
                    size: text_size_16,
                    weight: FontWeight.w600,
                    alignment: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextWidget(
                    text: "You have successfully earned",
                    size: text_size_16,
                    weight: FontWeight.w600,
                    alignment: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    text: "$_points points",
                    size: text_size_18,
                    weight: FontWeight.bold,
                    color: theme_orange_color,
                    alignment: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: theme_color,
                        // gradient: theme_color,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const TextWidget(
                          text: "Ok",
                          color: white_color,
                          size: text_size_14,
                          weight: FontWeight.bold,
                        )),
                  ),
                ],
              )),
        );
      },
    );
  }

  void resultApiCall() {
    Internetconnectivity().isConnected().then((value) async {
      var _reqBody = {
        "answers": widget.data,
        "test_no": widget.testNo == 'Test 1' ? 1 : 2,
        "contact": TestedGlobals.userContact,
        "c_id": widget.cid,
        "s_id": widget.sid
      };
      if (value == true) {
        TestResultPresenter().getLoginDetails(this, _reqBody);
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
          TestResultPresenter().getLoginDetails(this, _reqBody);
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
            body: WillPopScope(
                onWillPop: () => _willscope(),
                child: _isLoading
                    ? const Center(
                        child: Loader(),
                      )
                    : _body()),
          )),
    );
  }

  @override
  void testResultErr(error) {
    print(error);
    _isLoading = false;
    setState(() {});
  }

  @override
  void testResultResp(TestResultModel _testResultModel) {
    print(_testResultModel.toMap());

    _testResult = _testResultModel;
    _isLoading = false;
    if (_testResultModel.status == true) {
      _pdfUrl = _testResultModel.data?.url?.url ?? '';
      if (_testResultModel.data!.walletPoints! > 0) {
        _getrewardsPointsAlert(
            context, _testResultModel.data?.walletPoints ?? 0);
      }
    }
    setState(() {});
  }
}
