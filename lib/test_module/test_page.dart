import 'package:TESTED/common_widgets/button_widget.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/home_module/home_mvp/homepage_model.dart';
import 'package:TESTED/result_module/result_page.dart';
import 'package:TESTED/wallet_module/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class TestStartPage extends StatefulWidget {
  final ChapTest? chptList;
  final String? sid;
  final String? cid;
  const TestStartPage(
      {Key? key, required this.chptList, required this.sid, required this.cid})
      : super(key: key);

  @override
  State<TestStartPage> createState() => _TestStartPageState();
}

class _TestStartPageState extends State<TestStartPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late AnimationController _animController;
  late TabController _tabController;
  int _selectedAns = 5;
  int _selectQuestion = 1;
  List _ansArray = [];

  late ChapTest? _chptList;

  double progress = 1.0;
  int _selectedTab = 0;

  String _alphabet(i) {
    if (i == 0) {
      return 'A';
    } else if (i == 1) {
      return 'B';
    } else if (i == 2) {
      return 'C';
    } else {
      return 'D';
    }
  }

  Widget _appBar() {
    return Container(
      height: 60,
      color: theme_color,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: white_color),
              child: Image.asset('images/back_arrow.png', height: 18),
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

  Widget _questionNoIcon() {
    return Container(
      height: 50,
      color: transparent,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
          itemCount: _chptList?.paper?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.all(1),
              alignment: Alignment.center,
              height: 25,
              width: 25,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _tabController.index + 1 <= i
                      ? shadow_color
                      : theme_orange_color),
              child: TextWidget(
                text: '${i + 1}',
                color: white_color,
                size: text_size_14,
              ),
            );
          }),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _appBar(),
        Container(
          width: MediaQuery.of(context).size.width,
          color: white_color,
          child: Column(
            children: [
              _title(),
              const SizedBox(
                height: 20,
              ),
              _countDownTimer(),
              const SizedBox(
                height: 20,
              ),
              _questionTabs()
            ],
          ),
        )
      ],
    );
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          TextWidget(
            text: '${_chptList?.name}',
            size: text_size_22,
            weight: FontWeight.w400,
          ),
          const SizedBox(
            height: 15,
          ),
          _questionNoIcon()
          // Container(
          //   height: 30,
          //   margin: const EdgeInsets.symmetric(horizontal: 15),
          //   decoration: BoxDecoration(
          //       border: Border.all(width: 0.5, color: shadow_color),
          //       borderRadius: BorderRadius.circular(30),
          //       color: white_color),
          // )
        ],
      ),
    );
  }

  Widget _countDownTimer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              backgroundColor: Colors.grey.shade900,
              // color: theme_orange_color,
              valueColor: AlwaysStoppedAnimation(theme_orange_color),
            )),
        AnimatedBuilder(
          animation: _animController,
          builder: (context, child) => Container(
            child: Column(
              children: [
                TextWidget(
                  text: counterTxt,
                  size: text_size_22,
                  weight: FontWeight.w400,
                ),
                const TextWidget(
                  text: 'Countdown',
                  size: text_size_16,
                  color: theme_orange_color,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String get counterTxt {
    Duration count = _animController.duration! * _animController.value;
    return '${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _notify() {
    if (counterTxt == '00 : 00') {
      timeupAlert(context);
    }
  }

  List<Widget> _mcqQuest() {
    List<Widget> _list = [];
    for (int i = 0; i < _chptList!.paper!.length; i++) {
      _list.add(
        cardWidget(_chptList!.paper![i]),
      );
    }

    return _list;
  }

  Widget cardWidget(Paper _paper) {
    return Container(
      color: white_color,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 30),
              padding: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5))),
              child: TextWidget(
                text: 'Question - ${_tabController.index + 1}',
                size: text_size_16,
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: const EdgeInsets.only(left: 30),
              child: TextWidget(
                text: '${_paper.question}',
                size: text_size_14,
              )),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _paper.answer?.length ?? 0,
                itemBuilder: (context, i) {
                  return Container(
                    height: 50,
                    color: white_color,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme_orange_color),
                          child: TextWidget(
                            text: _alphabet(i),
                            size: text_size_16,
                            weight: FontWeight.w600,
                            color: white_color,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _ansArray.removeAt(_tabController.index);
                              _ansArray.insert(_tabController.index, {
                                '${_tabController.index + 1}':
                                    _paper.answer![i].value
                              });
                              setState(() {
                                _selectedAns = i;
                                _selectedTab = _tabController.index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    color: transparent,
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: TextWidget(
                                      text: '${_paper.answer![i].name}',
                                      size: text_size_14,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _selectedTab ==
                                                      _tabController.index &&
                                                  _selectedAns == i
                                              ? theme_orange_color
                                              : white_color),
                                      child: const Icon(
                                        Icons.check,
                                        color: white_color,
                                        size: 15,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _questionTabs() {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      color: transparent,
      child: TabBarView(controller: _tabController, children: _mcqQuest()),
    );
  }

  Widget _bottomBar() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 45,
            color: theme_orange_color,
            child: GradientButtonWidget(
                onTap: () {
                  Navigator.maybePop(context);
                },
                color: theme_orange_color,
                child: const TextWidget(
                  text: 'EXIT',
                  color: Colors.white,
                  size: text_size_14,
                )),
          ),
          SizedBox(
            width: _tabController.index > 0 ? 100 : 0,
            height: _tabController.index > 0 ? 45 : 0,
            child: GradientButtonWidget(
                onTap: () {
                  if (_tabController.index > 0) {
                    _tabController.animateTo(_tabController.index - 1);
                  }
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const TextWidget(
                  text: 'PREVIOUS',
                  color: Colors.white,
                  size: text_size_14,
                )),
          ),
          SizedBox(
            width: 80,
            height: 45,
            child: GradientButtonWidget(
                onTap: () {
                  if (_tabController.index + 1 == _tabController.length) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultPage(
                                  data: _ansArray,
                                  testNo: _chptList?.name,
                                  sid: widget.sid,
                                  cid: widget.cid,
                                  length: _chptList?.paper?.length.toString() ??
                                      '0',
                                )));
                  } else {
                    if (_tabController.index + 1 < _tabController.length) {
                      _tabController.animateTo(_tabController.index + 1);
                    }
                  }
                },
                color: _tabController.index + 1 == _tabController.length
                    ? theme_orange_color
                    : theme_color,
                child: TextWidget(
                  text: _tabController.index + 1 == _tabController.length
                      ? 'SUBMIT'
                      : 'NEXT',
                  color: white_color,
                  size: text_size_14,
                )),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _chptList = widget.chptList;
    _animController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1200));

    _animController.addListener(() {
      _notify();
      if (_animController.isAnimating) {
        setState(() {
          progress = _animController.value;
        });
      } else {
        setState(() {
          progress = 1.0;
        });
      }
    });
    for (var i = 0; i < _chptList!.paper!.length; i++) {
      _ansArray.add({'${i + 1}': 'false'});
    }
    _tabController = TabController(
        length: _chptList!.paper?.length ?? 0, vsync: this, initialIndex: 0);
    _animController.reverse(
        from: _animController.value == 0 ? 1.0 : _animController.value);
  }

  @override
  void dispose() {
    _animController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onexit() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            height: 140,
            child: Column(
              children: <Widget>[
                TextWidget(
                  text: 'Are you sure you',
                  size: 18,
                  weight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextWidget(
                    text: 'want to exit?',
                    size: 18,
                    weight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  offset: Offset(0.0, 5.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const TextWidget(
                              text: 'No',
                              size: 15,
                              color: Colors.white,
                              weight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  offset: Offset(0.0, 5.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const TextWidget(
                              text: 'Yes',
                              size: 15,
                              color: Colors.white,
                              weight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black_color,
      child: SafeArea(
          bottom: true,
          top: true,
          child: Scaffold(
            backgroundColor: white_color,
            key: _key,
            body: SingleChildScrollView(
                child: WillPopScope(onWillPop: _onexit, child: _body())),
            bottomNavigationBar: _bottomBar(),
          )),
    );
  }

  Future<void> timeupAlert(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 20),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const TextWidget(
                    text: "Sorry time is up!",
                    size: text_size_16,
                    weight: FontWeight.w600,
                    alignment: TextAlign.center,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultPage(
                                        data: _ansArray,
                                        testNo: _chptList?.name,
                                        sid: widget.sid,
                                        cid: widget.cid,
                                        length: _chptList?.paper?.length
                                                .toString() ??
                                            '0',
                                      )));
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
}
