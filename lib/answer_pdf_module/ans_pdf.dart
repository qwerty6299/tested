import 'dart:io';

import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/wallet_module/wallet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AnswerPdfPage extends StatefulWidget {
  final int? testNo;
  final String? url;
  const AnswerPdfPage({Key? key, this.testNo, required this.url})
      : super(key: key);

  @override
  State<AnswerPdfPage> createState() => _AnswerPdfPageState();
}

class _AnswerPdfPageState extends State<AnswerPdfPage> {
  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("the url is ${widget.url}");
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
  Future<File?> downloadFile(String url,String name)async{
    final appstorage = await getApplicationDocumentsDirectory();
    final file = File("${appstorage.path}/$name");
    try {
      final response = await Dio().get(
          url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0
          )
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    }catch(e){
      return null;
    }
  }
Future openfile({required String url,required String name}) async{
    final file = await downloadFile(url,name);
    if(file==null){
      return;
    }else{
      print("path is ${file.path}");
      OpenFile.open(file.path);
    }
}
  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: milky_white,
      child: Column(
        children: [
          _appBar(),
          const SizedBox(
            height: 40,
          ),
          TextWidget(
            text: widget.testNo != null
                ? 'Test ${widget.testNo} Solution'
                : 'Test 1 Question Paper',
            size: text_size_20,
            weight: FontWeight.w500,
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              'images/pdf.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget(
                text: 'Click ',
                size: text_size_20,
              ),
              GestureDetector(
                onTap: () {
                  openfile(url:"${widget.url}", name: "s");
                },
                child: const TextWidget(
                  text: 'here ',
                  size: text_size_20,
                  color: theme_color,
                ),
              ),
              const TextWidget(
                text: 'to download',
                size: text_size_20,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black_color,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: milky_white,
        body: _body(),
      )),
    );
  }
}
