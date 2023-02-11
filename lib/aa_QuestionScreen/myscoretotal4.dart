import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Test_Score_Found.dart';


class MyScore extends StatefulWidget {

  const MyScore({Key? key}) : super(key: key);

  @override
  State<MyScore> createState() => _MyScoreState();
}

class _MyScoreState extends State<MyScore> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: InkWell(
        onTap: (){
          Get.to(TestScoreFound());
        },
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height:10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.maybePop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image(image: AssetImage('images/back_arrow_white.png'),width: 20,),
                    ),
                  ),

                  CustomText(18, FontWeight.bold, Colors.white, 'My Score'),
                  Text('     ')
                ],
              ),
              Divider(
                color: Colors.white,

              ),

          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: (){

                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(

                    decoration: BoxDecoration(

                      color: Colors.white,

                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('images/leverage.png')),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.01,
                        ),
                        CustomText(14, FontWeight.w700, Colors.black,index==0?'Leverage':(index==1)?
                        'Dividend':(index==2)?'Working Capital':'Receivable'),
                        CustomText(14, FontWeight.normal, Colors.grey,index==0?'0 Tests':(index==1)?
                        '0 Tests':(index==2)?'0 Tests':'0 Tests' ),
                      ],
                    )
                  ),
                ),
              );
            },),
          ),

            ],
          ),
        ),
      ),
    );
  }
}
