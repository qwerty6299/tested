import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../common_widgets/colors_widget.dart';
import '../common_widgets/text_widget.dart';

class Chapterpageshimmer extends StatelessWidget {
  const Chapterpageshimmer({Key? key}) : super(key: key);
  Widget _appBar() {
    return Container(
      height: 60,
      color: theme_color,
      child: Row(
        children: [
          InkWell(
            onTap: () {

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
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const WalletPage()));
            // },
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
  Widget _courseData(){
    return    ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Container(

            margin:  EdgeInsets.all(10),
            padding:  EdgeInsets.symmetric(horizontal: 15,),
            decoration: BoxDecoration(
                color: white_color,
                border: Border.all(color: shadow_color, width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Column(


              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 9,),
                            child: TextWidget(
                              text:
                              '{insidesubcat.insideSubCategorymodel?.chapters[i].name} : Leverage',
                              size: 16,
                              weight: FontWeight.w700,
                            ),
                          ),



                        ],
                      ),
                    ),


                  ],
                ),

                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 8),
                //   child: const Divider(
                //     color: shadow_color,
                //     height: 2.0,
                //     thickness: 2.0,
                //   ),
                // ),

              ],
            ),
          );
        });
}
  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return Column(
        children: [

          _appBar(),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 1),
                  height: 20,
                  width: 150,
                  color: GREY_COLOR_GREY.shade100),
              const SizedBox(
                height: 20,
              ),
              _courseData()
            ],
          )
        ],
      );
    }
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Shimmer.fromColors(
                  baseColor: GREY_COLOR_GREY.shade300,
                  highlightColor: GREY_COLOR_GREY.shade100,
                  child: _body()),
            ),

          ],
        ),
      ),
    );
  }
}
