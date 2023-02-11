import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'initialyourscore.dart';

class MyTotalScore extends StatefulWidget {
  const MyTotalScore({Key? key}) : super(key: key);

  @override
  State<MyTotalScore> createState() => _MyTotalScoreState();
}

class _MyTotalScoreState extends State<MyTotalScore> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: (){
           Get.to(InitialYourScore());
        },
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.maybePop(context);
                  }, icon: Icon(Icons.arrow_back),color: Colors.black,),
                  CustomText(18, FontWeight.bold, Colors.black, 'My Score'),
                  Text('     ')
                ],
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                width: double.infinity,
                height: size.height*0.4,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(52, 177, 231, 1)
                ),
                child: Column(

                  children: [

                    SizedBox(
                      height: size.height*0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: CircularPercentIndicator(
                        radius:65,
                        lineWidth: 7,
                        percent: 0.7,
                        progressColor: Colors.white,
                        backgroundColor: Colors.blue,
                        circularStrokeCap: CircularStrokeCap.round,

                        center:

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('0',style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24
                            ),),
                            Text('Total Test',style: TextStyle(
                                color: Colors.white,fontSize: 14
                            ),),
                          ],
                        ),






                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              CustomText(18, FontWeight.normal, Colors.white, 'Total Test Attempt'),
                              SizedBox(
                                height: size.height*0.01,
                              ),

                              CustomText(20, FontWeight.bold, Colors.white, '0'),
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.white,  //color of divider
                            width: 60, //width space of divider
                            thickness: 2,
                             ),
                          Column(
                            children: [
                              CustomText(18, FontWeight.normal, Colors.white, 'Remaining Test'),
                              SizedBox(
                                height: size.height*0.01,
                              ),
                              CustomText(20, FontWeight.bold, Colors.white, '0'),
                            ],
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: CustomText(16, FontWeight.w400, Colors.black, 'Rank'),
                  )
                ],
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                width: size.width*0.95,
                height: size.height*0.05,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(52, 177, 231, 1),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CustomText(14, FontWeight.bold, Colors.white, 'Rank'),
                    ),
                    SizedBox(
                      width: size.width*0.12,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: CustomText(14, FontWeight.bold, Colors.white, 'User')
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: CustomText(14, FontWeight.bold, Colors.white, 'Points'),
                            ),
                          ],
                        )
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (ctx,i){
                        return Card(
                          margin: EdgeInsets.only(left: 8,right: 10,bottom: 16.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: ListTile(
                            leading: CustomText(16,FontWeight.w600,Colors.blue,i%2==0?'0'.toUpperCase():'0'.toUpperCase()),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: size.width*0.06,
                                ),
                                Flexible(child: CustomText(14,FontWeight.normal,Colors.black,'Leverage')),
                              ],
                            ),

                            trailing: CustomText(16,FontWeight.w600,Colors.black,i%2==0?'0'.toUpperCase():'0'.toUpperCase()),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
