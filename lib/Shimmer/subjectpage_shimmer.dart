import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../common_widgets/colors_widget.dart';
import '../common_widgets/font_size.dart';
import '../common_widgets/text_widget.dart';

class Subjectpageshimmer extends StatefulWidget {
  const Subjectpageshimmer({Key? key}) : super(key: key);

  @override
  State<Subjectpageshimmer> createState() => _SubjectpageshimmerState();
}

class _SubjectpageshimmerState extends State<Subjectpageshimmer> {
  Widget _courseData() {
    return  GridView.builder(
        shrinkWrap: true,
        itemCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,


        ), itemBuilder: (ctx,i){
      return GestureDetector(
        onTap: () {

        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin:  EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:i%2==0? Color.fromRGBO(255,242,231,1): Color.fromRGBO(229, 247, 255, 1),
            border: Border.all(color: shadow_color, width: 0.5),
            borderRadius: BorderRadius.only(
                topLeft:Radius.circular(25.0),
                topRight:Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)),),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image(image: AssetImage('images/subjectpage_icon.png'))

                            ],
                          ),

                          Container(
                              width: 50,
                              height: 50,
                              child:
                              CircularPercentIndicator(
                                radius: 20.0,
                                lineWidth: 2.0,
                                animation: true,

                                percent:0,
                                center: Text("{subcat.subcatpro?.subCat[i].attemted}",style: TextStyle(
                                    color: Colors.black
                                ),),
                                progressColor: i==0?Colors.orangeAccent:Color.fromRGBO(52, 177, 231, 1),
                              )







                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                        child: TextWidget(
                          text: "{ subcat.subcatpro?.subCat[i].name ?? ''}",
                          size: text_size_18,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Card(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),

                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08,vertical: 8.0),
                        child: TextWidget(
                          // text: 'Tests : ${_subList![i].sTests ?? 0}',
                          text: 'Tests : { subcat.subcatpro?.subCat[i].totalTest}',
                          size: text_size_16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                         Container(

                  margin: const EdgeInsets.only(top: 1),
                  height: 20,
                  width: 50,
                  color: GREY_COLOR_GREY.shade100),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
          _courseData()
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
