import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'aa_QuestionScreen/constants.dart';
import 'model/Submitanswermodel.dart';

class Selectanswer extends StatefulWidget {
  int cind;
  String optionname,id,type;
   Selectanswer({Key? key, required this.cind,required this.optionname,required this.id,required this.type}) : super(key: key);

  @override
  State<Selectanswer> createState() => _SelectanswerState();
}

class _SelectanswerState extends State<Selectanswer> {
  Submitanswermodel? submitanswermodel;
  int selectedIndex=-1;
  String thetoken="";


  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the submit answer token is $thetoken");
  }
  Future<Submitanswermodel?> postmyanswer()async{
    try {
      var body={
        "testId": "12",
        "questionId": "13",
        "answerId":["","","",""],
        "testName":"test a",
        "questionType":"${widget.type}"
      };
      final response = await http.post(Uri.parse("http://3.227.35.5:3002/api/v2/submit_answer"),headers: {
        HttpHeaders.authorizationHeader:"Bearer $thetoken"
      },body:json.encode(body));

      if (response.statusCode == 200) {
        print("submit answer is ${response.body}");
        submitanswermodel=submitanswermodelFromJson(response.body);
        print("body isss${body}");
        setState(() {
        });

      }
      else {
        print("error submit answer ${response.body}");
      }
    }catch(e){
      print("1234r5t6y7u8${e.toString()}");
    }
    return submitanswermodel;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
  }
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: (){
        setState(() {

          selectedIndex=widget.cind;
          print("cind value is ${selectedIndex}");
        });
       print("mcqid${widget.id}");

      },
      child: Column(
        children: [

          Container(
              width:MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(

                      color: selectedIndex == widget.cind?Colors.blue:Colors.grey
                  )
              ),
              child: Row(
                children: [
                  Text(widget.cind==0?"A.":(widget.cind==1)?"B.":(widget.cind==2)?"C.":"D.",style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    width: 10,
                  ),
                  Text('${widget.optionname}'),
                  selectedIndex == widget.cind?     Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                    height: 26,
                    width: 26,
                       decoration: BoxDecoration(
                       color: Colors.blue,
                       borderRadius: BorderRadius.circular(50.0),
                       border: Border.all(color: Colors.blue)
                        ),
                          child: Icon(
                          Icons.done, color: Colors.white, size: 16,)
                          )

                    ],
                  )):SizedBox()
                ],
              )),




        ],
      ),
    );
  }
}


