import 'dart:ui';

import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/wallet_module/wallet.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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

  Widget _logo() {
    return Column(
      children: [
        Container(
          color: transparent,
          height: 120,
          child: Image.asset(
            'images/theme_logo.png',
            fit: BoxFit.fill,
          ),
        ),
        const TextWidget(
            text: 'Version : 1.8', size: text_size_16, weight: FontWeight.w500),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: const TextWidget(
              text:
                  "We are a test preparation and evaluation start up. Our mission is to encourage students to plan their studies and evaluate their performance through MCQ tests. Students will be rewarded with in-app coins which can be further redeemed to attempt more tests and reap many other benefits.",
              size: text_size_18,
              weight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [_appBar(), _logo()],
      ),
    );
  }

  Widget _subtitle() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: const TextWidget(
          text: 'Designed   &   Developed  By',
          size: text_size_18,
          color: GREY_COLOR_GREY_400,
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _brandlogo() {
    return Image.asset(
      'images/soradis_logo.png',
      height: 80,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black_color,
      child: SafeArea(
          child: Scaffold(
        body: _body(),
        bottomNavigationBar: Container(
          height: 140,
          color: white_color,
          child: Column(
            children: [
              _subtitle(),
              const SizedBox(
                height: 15,
              ),
              _brandlogo()
            ],
          ),
        ),
      )),
    );
  }
}
