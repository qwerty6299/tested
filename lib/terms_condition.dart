import 'dart:io';

import 'package:TESTED/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common_widgets/colors_widget.dart';
import 'common_widgets/font_size.dart';
import 'common_widgets/loader.dart';
import 'common_widgets/text_widget.dart';

class TermsAndCondition extends StatefulWidget {
  final String? checkURL;
  final String? route;

  const TermsAndCondition({Key? key, required this.checkURL, this.route})
      : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool isloading = true;
  String? url;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    if (widget.checkURL != null) {
      url = widget.checkURL;
    } else {
      url = TestedContants.TERMS_CONDITION;
    }
    print(url);
  }

  Widget _appbar() {
    return AppBar(
        backgroundColor: theme_color,
        centerTitle: false,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: theme_color),
        ),
        title: TextWidget(
          text: widget.route != 'policy'
              ? 'Terms and Conditions'
              : 'Privacy Policy',
          size: text_size_18,
          color: white_color,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: transparent),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            appBar: PreferredSize(
                child: _appbar(), preferredSize: const Size.fromHeight(60)),
            extendBody: true,
            body: Container(
              color: white_color,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                            color: Colors.white,
                            child: WebView(
                              initialUrl: url,
                              javascriptMode: JavascriptMode.unrestricted,
                              onPageStarted: (finish) {
                                setState(() {
                                  isloading = false;
                                });
                              },
                            )),
                        isloading == true
                            ?  Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Loader(),
                                ),
                              )
                            :  SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
