import 'dart:io';

import 'package:TESTED/aa_QuestionScreen/questin_screen__1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_widgets/loader.dart';
import '../model/Questionmodel.dart';
import '../provider/ApiProviders.dart';

class AllQuestionScreen extends StatefulWidget {
  const AllQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AllQuestionScreen> createState() => _AllQuestionScreenState();
}

class _AllQuestionScreenState extends State<AllQuestionScreen> {
  Questionmodel? questionmodel;
  String thetoken="";

  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the inside subcat  token is $thetoken");
  }



  Future<Questionmodel?> getmyquestion()async{
    try {
      final response = await http.get(Uri.parse("http://3.227.35.5:3002/api/v2/load_questions?testType=A&testId=63c4e8b803b49dcd4dd14b85&page=1"),headers: {
        HttpHeaders.authorizationHeader:"Bearer $thetoken"
      });

      if (response.statusCode == 200) {
        print(" question is ${response.body}");
        questionmodel=questionmodelFromJson(response.body);
        // print(questionmodel?.data?.length);
        setState(() {
        });

      }
      else {
        print(" 0000 ${response.body}");
      }
    }catch(e){
      print("1234r5t6y7u8${e.toString()}");
    }
    return questionmodel;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken().whenComplete(() async{
      getmyquestion();
    });
  }
  int selectedindex=-1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0,top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('      ',style: TextStyle(
                      color: Colors.white
                    ),),
                    Text('All Questions',style: TextStyle(
                        color: Colors.black
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Expanded(child: questionmodel?.result==null?Center(
                child: Loader(),
              ): GridView.builder(
                shrinkWrap: true,
                itemCount: questionmodel!.result?.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedindex=index;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
                              create: (context) => CategoryProvider(),
                              child:  QuestionScreen1(currentindex: selectedindex,))));
                      print("the selected is $selectedindex");

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                      child: Container(
                        height: 31,
                        width: 31,
                        alignment: Alignment.center,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color:(index==3||index==5||index==9||index==12)?Colors.green:Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:(index==3||index==5||index==9||index==12)? Colors.white:Colors.blueGrey
                            )
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              "${index+1}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )

                    ),
                  );
                },

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 5.0
                ),
              ),)

            ],
          ),
        ),
      ),
    );
  }
}
