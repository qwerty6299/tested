import 'package:TESTED/aa_QuestionScreen/scoreboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/ApiProviders.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String thetoken="";

  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the profile token is $thetoken");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken().whenComplete(() async{
      await  Provider.of<CategoryProvider>(context,listen: false).getscorescreen(header: '$thetoken', query: '6355555');
    });
  }
  @override
  Widget build(BuildContext context) {
    final postmodel=Provider.of<CategoryProvider>(context);

    return SafeArea(child:
      Scaffold(
      body: GestureDetector(
        onTap: (){
          Get.to(Scoreboardpage());
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                  FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: 0.72,
                      child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(52, 177, 231, 1),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      )
                    ),
                  )),

                Container(
                  width: double.infinity,

                  child: Column(


                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        GestureDetector(onTap: (){
                          Navigator.maybePop(context);
                        },
                          child: Image(image: AssetImage("images/back_arrow_white.png"),),
                        ),
                          Text('Result',style: TextStyle(color: Colors.white,fontSize: 16),),
                          Text('            ',style: TextStyle(color: Colors.white),),


                        ],


                      ),
                      SizedBox(
                        height:  MediaQuery.of(context).size.height*0.03,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(image: AssetImage('images/ellipse.png')),

                          CircularPercentIndicator(
                            radius:100,
                            lineWidth: 12,
                            percent: 0.8,
                            progressColor: Colors.white,
                            backgroundColor: Color.fromRGBO(22, 168, 232, 1),
                            circularStrokeCap: CircularStrokeCap.round,

                            center:

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(postmodel.scorescreenmodel?.result?[0]?.score==null?"":'${postmodel.scorescreenmodel?.result?[0]?.score}',style: TextStyle(
                                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24
                                        ),),
                                        // Text(' Marks out of four ',style: TextStyle(
                                        //   color: Colors.white,fontSize: 14
                                        // ),),
                                      ],
                                    ),






                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0.0),
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding:   EdgeInsets.all(MediaQuery.of(context).size.width*0.07),
                            height: 200,
                            child: Column(

                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(postmodel.scorescreenmodel?.result?[0]?.answered==null?"":
                                          '${postmodel.scorescreenmodel?.result?[0]?.answered}',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('Answered',style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,

                                          ),),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(postmodel.scorescreenmodel?.result?[0]?.unanswered==null?"":'${postmodel.scorescreenmodel?.result?[0]?.unanswered}',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('UnAnswered',style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,

                                          ),),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                                Spacer(),
                                Row(

                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(postmodel.scorescreenmodel?.result?[0]?.correct==null?"":'${postmodel.scorescreenmodel?.result?[0]?.correct}',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('Correct',style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,

                                          ),),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(postmodel.scorescreenmodel?.result?[0]?.wrong==null?"":'${postmodel.scorescreenmodel?.result?[0]?.wrong}',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('Wrong',style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,

                                          ),),
                                        ],
                                      ),
                                    ),


                                  ],
                                )

                              ],
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularPercentIndicator(
                    radius:100,
                    lineWidth: 12,
                    percent: 0,
                    progressColor: Colors.blue,
                    backgroundColor: Colors.grey,
                    circularStrokeCap: CircularStrokeCap.round,

                    center:

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(postmodel.scorescreenmodel?.result?[0]?.completion==null?"":'   ${postmodel.scorescreenmodel?.result?[0]?.completion}',style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18
                        ),),
                        Text('Done',style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18
                        ),),
                      ],
                    ),






                  ),
                ),


              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
