import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'my_total_score.dart';

class TestScoreFound extends StatefulWidget {
  const TestScoreFound({Key? key}) : super(key: key);

  @override
  State<TestScoreFound> createState() => _TestScoreFoundState();
}

class _TestScoreFoundState extends State<TestScoreFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: (){
          Get.to(MyTotalScore());
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
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.04,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CustomText(25, FontWeight.w900, Colors.black, '2 Test score'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CustomText(25, FontWeight.w900, Colors.black, 'found'),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top:   10.0),
                  child: Image(image: AssetImage('images/testscorefound.png'),),
                ),
                title: CustomText(14, FontWeight.w800, Colors.black, 'Test 1 Score'),
                subtitle: CustomText(14, FontWeight.normal, Colors.grey, 'Leverage'),
                trailing: Icon(Icons.arrow_forward_ios,size: 18,),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.04,
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child:  Image(image: AssetImage('images/testscorefound.png'),),
                ),
                title: CustomText(14, FontWeight.w800, Colors.black, 'Test 2 Score'),
                subtitle: CustomText(14, FontWeight.normal, Colors.grey, 'Leverage'),
                trailing: Icon(Icons.arrow_forward_ios,size: 18,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
