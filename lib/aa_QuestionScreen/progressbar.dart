import 'package:TESTED/aa_QuestionScreen/questioncontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width:MediaQuery.of(context).size.width*0.9,

      height: 15,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5)
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
         // print("111111111111${controller.animation.value}");
          return Stack(
            children: [
              LayoutBuilder(
                  builder: (context,constraints)=>Container(
                    width: constraints.maxWidth*controller.animation.value,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                    ),
                  )
              ),
              Positioned.fill(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${(controller.animation.value*60).round()} sec"),

                  ],
                ),
              ))
            ],
          );
        }
      ),
    );
  }
}
