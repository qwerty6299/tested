import 'package:TESTED/aa_QuestionScreen/score_screen.dart';
import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../home_module/tabbar_page.dart';
import '../provider/ApiProviders.dart';
import 'Test1_result.dart';
class Scoreboardpage extends StatefulWidget {
  const Scoreboardpage({Key? key}) : super(key: key);

  @override
  State<Scoreboardpage> createState() => _ScoreboardpageState();
}

class _ScoreboardpageState extends State<Scoreboardpage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: GestureDetector(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //     context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                    //     //     create: (context) => CategoryProvider(),
                    //     //     child: BottomTabbarclass(selectedIndex: 0,))));
                    //   },
                    // ),
                    Text('Result',style: TextStyle(color: Colors.white,fontSize: 18),),
                    // Text('            ',style: TextStyle(color: Colors.white),),


                  ],


                ),
                SizedBox(
                  height: size.height*0.025,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                   "images/profilepi.png",
                 fit: BoxFit.fitWidth,
                   width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: size.height*0.025,
                ),
                Container(
                  width: double.infinity,
                  height: size.height*0.08,
                   margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Text('0 Score',style: TextStyle(
                      color: Colors.blue
                    ),),
                  ),
                ),
                SizedBox(
                  height: size.height*0.025,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )
                  ),

                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 40.0,vertical: 40.0),
                          child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),

                        ),
                        SizedBox(
                          height: size.height*0.02,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangeNotifierProvider(
                                      create: (context) => CategoryProvider(),
                                      child: TestResult(),
                                    )
                                )
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: size.height*0.08,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Center(
                              child: Text('View Scoreboard',style: TextStyle(
                                  color: Colors.white,fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                      ],
                    ),

                ))
              ],
            ),
          ),
        ),

      ),
    );
  }
}
