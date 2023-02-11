import 'package:TESTED/aa_QuestionScreen/questioncontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'constants.dart';
class Option extends StatelessWidget {
   Option({Key? key,required this.text,required this.index,required this.press}) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (qnController) {
        Color gettherightcolor2(){
          if(qnController.isAnswered){
            if(index==qnController.selectans){
              return Colors.blue;
            }

          }    return kGrayColor;
        }
        Color gettherightcolor(){
          if(qnController.isAnswered){
            if(index==qnController.correctans){
              return kGreenColor;
            }else if(index==qnController.selectans&& qnController.selectans!=qnController){
          return kRedColor;
            }

          }    return kGrayColor;
        }
        IconData getTherighticon(){
          return gettherightcolor()==kRedColor?Icons.close:Icons.done;
        }
        return
          Column(
          children: [
            InkWell(
              onTap:press,
              child: Container(
                margin: EdgeInsets.only(top: kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(15.0),
                    border:Border.all(
                        color: gettherightcolor2()
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${index+1}. $text',style: TextStyle(
                      //  color: gettherightcolor()
                    fontSize: 16,fontWeight: FontWeight.bold
                    ),),

                    Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        color: gettherightcolor2()==kGrayColor?Colors.transparent:gettherightcolor2(),
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: gettherightcolor2())
                      ),
                     child: gettherightcolor2()==kGrayColor?null:Icon(Icons.done,color: Colors.white,size: 16,)
                    )
                  ],
                ),
              ),
            ),

          ],
        );
      }
    );
  }
}
