import 'package:TESTED/answer_pdf_module/ans_pdf.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/home_module/home_mvp/homepage_model.dart';
import 'package:TESTED/wallet_module/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SolutionPage extends StatefulWidget {
  final List<Solution>? solutions;
  const SolutionPage({Key? key, required this.solutions}) : super(key: key);

  @override
  State<SolutionPage> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  List<Solution>? solutionsList;

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
                padding:  EdgeInsets.all(6),
                margin:  EdgeInsets.symmetric(horizontal: 10),
                decoration:  BoxDecoration(
                    shape: BoxShape.circle, color: white_color),
                child:  Icon(Icons.account_balance_wallet_outlined)),
          ),
        ],
      ),
    );
  }

  Widget _courseData() {
    return Container(
      height: MediaQuery.of(context).size.height - 175,
      child: solutionsList!.isEmpty
          ?  Center(
              child: TextWidget(
              text: 'No Solutions Found',
              size: text_size_22,
              weight: FontWeight.bold,
            ))
          : ListView.builder(
              itemCount: solutionsList?.length ?? 0,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnswerPdfPage(
                                  testNo: i + 1,
                                  url: solutionsList![i].url,
                                )));
                  },
                  child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: white_color,
                          border: Border.all(color: shadow_color, width: 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Image.asset('images/pdf.png'),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextWidget(
                              text: '${solutionsList![i].name}',
                              // 'Test ${i + 1}',
                              size: text_size_18,
                            ),
                          )
                        ],
                      )),
                );
              }),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          _appBar(),
          const SizedBox(
            height: 30,
          ),
          const TextWidget(
            text: 'Solutions',
            size: text_size_22,
            weight: FontWeight.w500,
          ),
          const SizedBox(
            height: 20,
          ),
          _courseData()
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    solutionsList = widget.solutions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white_color,
      child: SafeArea(
          child: Scaffold(
        body: _body(),
      )),
    );
  }
}
