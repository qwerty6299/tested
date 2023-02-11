import 'package:TESTED/aa_QuestionScreen/questioncontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Questions.dart';
import 'constants.dart';
import 'option.dart';
class QuestionCard extends StatelessWidget {

   QuestionCard({Key? key,required this.question}) : super(key: key);
 final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController questionController=Get.put(QuestionController());
    return
      Container(

      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(

        boxShadow: [
        BoxShadow(

        color: Colors.grey,
        blurRadius: 5
      ),

    ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0)
      ),
      child:
     ListView(
        children: [
          Text(question.question,style:Theme.of(context).textTheme.headline6!.copyWith(color:Colors.black)),
          SizedBox(
            height: kDefaultPadding/2,
          ),
 
        ...List.generate(question.options.length, (index) => Option(text: question.options[index], index: index, press: (){
      questionController.checkans(question,index);
        })),
      SizedBox(
        height: MediaQuery.of(context).size.height*0.08,
      ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [

              ElevatedButton(

                 onPressed: questionController.previous,
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),),
                child:Text('Previous'),

               ),
           ElevatedButton(
             onPressed: questionController.nextques,
             style: ElevatedButton.styleFrom(
               primary: Colors.blue,
               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
               textStyle: TextStyle(
                   fontSize: 12,
                   fontWeight: FontWeight.bold),),
             child:Text('Next'),

           ),

         ],
       )


        ],
      ),
    );
  }
}


