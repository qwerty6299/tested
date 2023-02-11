import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:TESTED/aa_QuestionScreen/view_correct_answer.dart';
import 'package:TESTED/home_module/tabbar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/ApiProviders.dart';

class TestResult extends StatefulWidget {
  const TestResult({Key? key}) : super(key: key);

  @override
  State<TestResult> createState() => _TestResultState();
}

class _TestResultState extends State<TestResult> {
  String thetoken="";

  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the test 1  token is $thetoken");
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(52, 177, 231, 1),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                        )
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back,color: Colors.white,),
                            CustomText(16, FontWeight.normal, Colors.white, 'Test 1 '),
                            CustomText(12, FontWeight.normal, Colors.white, '       ')

                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [

                                Image( image: AssetImage('images/group_circularbar.png')),
                                  Container(
                                    padding: EdgeInsets.all(32.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle
                                    ),
                                    child: Column(
                                      children: [
                                        Text(postmodel.scorescreenmodel?.result?[0]?.score==null?"":'${postmodel.scorescreenmodel?.result?[0]?.score}',style: TextStyle(
                                            color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 28
                                        ),),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Your Score',style: TextStyle(
                                            color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 11
                                        ),),
                                        // Text('out of 100',style: TextStyle(
                                        //     color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 11
                                        // ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),

                  ),
                  DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      maxChildSize: 0.6,
                      minChildSize: 0.5,
                      builder:(context,controller){
                        return  Container(
                          margin: EdgeInsets.only(top: 12.0,left: 12.0,right: 12.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              )
                          ),
                          child: ListView(
                            controller: controller,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.1,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,


                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.007,
                                                right: MediaQuery.of(context).size.width * 0.025),
                                            child: Image(image: AssetImage('images/ellipsenine.png')),
                                          ),

                                          Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,

                                            children: [
                                              Text(postmodel.scorescreenmodel?.result?[0]?.completion==null?"":'${postmodel.scorescreenmodel?.result?[0]?.completion}',style: TextStyle(
                                                  color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold
                                              ),),
                                              Text('Completion',style: TextStyle(
                                                  color: Colors.grey
                                              ),),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.04,
                                      ),
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.007,
                                                right: MediaQuery.of(context).size.width *0.025),
                                            child: Image(image: AssetImage('images/ellipsenine.png'),color: Colors.green,),
                                          ),
                                          Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text(postmodel.scorescreenmodel?.result?[0]?.correct==null?"":'${postmodel.scorescreenmodel?.result?[0]?.correct}', textAlign: TextAlign.start,style: TextStyle(
                                                  color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold
                                              ),),
                                              Text('correct',style: TextStyle(
                                                  color: Colors.grey
                                              ),),
                                            ],
                                          )
                                        ],
                                      ),


                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.007,
                                                right: MediaQuery.of(context).size.width * 0.025),
                                            child: Image(image: AssetImage('images/ellipsenine.png')),
                                          ),
                                          Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text(postmodel.scorescreenmodel?.result?[0]?.totalQuestions==null?"":'${postmodel.scorescreenmodel?.result?[0]?.totalQuestions}',style: TextStyle(
                                                  color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold
                                              ),),
                                              Text('Total Question',style: TextStyle(
                                                  color: Colors.grey
                                              ),),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.04,
                                      ),
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.007,
                                                right: MediaQuery.of(context).size.width *0.025),
                                            child: Image(image: AssetImage('images/ellipsenine.png'),color: Colors.red,),
                                          ),
                                          Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text(postmodel.scorescreenmodel?.result?[0]?.wrong==null?"":'${postmodel.scorescreenmodel?.result?[0]?.wrong}', textAlign: TextAlign.start,style: TextStyle(
                                                  color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold
                                              ),),
                                              Text('Wrong', textAlign: TextAlign.start, style: TextStyle(
                                                color: Colors.grey,

                                              ),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),






                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.05,
                              ),
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const ViewAnswer()));
                                    },
                                    child: Column(

                                      children: [
                                        Image(image: AssetImage('images/group_viewanswer.png')),
                                        SizedBox(
                                        height: 2,
                                        ),
                                        CustomText(12, FontWeight.normal, Colors.grey, 'View Answer')
                                                    ],
                                                  ),
                                  ),
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>  BottomTabbarclass(selectedIndex: 1)));
                                    },
                                    child: Column(
                                      children: [
                                       Image(image: AssetImage('images/group_leaderboard.png')),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        CustomText(12, FontWeight.normal, Colors.grey, 'Leaderboard')
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>  BottomTabbarclass(selectedIndex: 0,)));
                                    },
                                    child: Column(
                                      children: [
                                        Image(image: AssetImage('images/group_home.png')),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        CustomText(12, FontWeight.normal, Colors.grey, 'home')
                                      ],
                                    ),
                                  )

                                ],
                              ),

                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.05,
                              ),
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Image(image: AssetImage('images/group_download.png')),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      CustomText(12, FontWeight.normal, Colors.grey, 'Download Subjective\n          Solution')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                  Image(image: AssetImage('images/group_download.png',),color: Colors.white),

                                      Text('                                                ')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image(image: AssetImage('images/group_download.png',),color: Colors.white),
                                      Text('             ')
                                    ],
                                  ),

                                ],
                              )
                            ],
                          ),
                        );
                      })




                ]),
          ),
        ),
      ),
    );

  }
}
