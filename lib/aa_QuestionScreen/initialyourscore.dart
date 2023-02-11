import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Test1_result.dart';
import 'my_account_paage.dart';

class InitialYourScore extends StatefulWidget {
  const InitialYourScore({Key? key}) : super(key: key);

  @override
  State<InitialYourScore> createState() => _InitialYourScoreState();
}

class _InitialYourScoreState extends State<InitialYourScore> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  MyAccountPage()));



          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text('Your Coins',style: TextStyle(color: Colors.black87,fontSize: 18),),
                    Text('            ',style: TextStyle(color: Colors.white),),


                  ],


                ),
                SizedBox(
                  height: size.height*0.025,
                ),
                Container(
                  width: size.width*0.9,
                  height: size.height*0.2,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(52, 177, 231, 1),
                      borderRadius: BorderRadius.circular(16.0),

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(16, FontWeight.bold, Colors.white, "Total Coins"),
                      SizedBox(
                        height: size.height * 0.0001,
                      ),
                      CustomText(40, FontWeight.bold, Colors.white, "0"),

                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.025,
                ),
                Container(
                  margin: EdgeInsets.only(left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(16, FontWeight.w700, Colors.black, "Take more test to earn more coins"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.02,
                ),
                Expanded(
                    child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (ctx,i){
                      return Card(
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)
                        ),
                        child: ListTile(
                          leading:i==0? Image(image: AssetImage('images/totalcoin1.png'),):i==1?
                          Image(image: AssetImage('images/testscore2.png'),):Image(image: AssetImage('images/testscore3.png'),),
                          title: Text('Give answers to 10 questions'),


                        ),
                      );
                    })
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      width: size.width*0.95,
                      height: size.height*0.07,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(52, 177, 231, 1),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Center(
                        child:CustomText(14, FontWeight.w400, Colors.white, 'Start Test')
                      ),
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
