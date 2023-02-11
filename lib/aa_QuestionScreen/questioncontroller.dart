import 'package:TESTED/aa_QuestionScreen/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Questions.dart';

class QuestionController extends GetxController with GetSingleTickerProviderStateMixin{
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late  Animation<double> _animation;
  Animation get animation=> this._animation;
  PageController get pagecontroller=> this._pageController;
  List<Question> question= Question.sample_data.map((question) => Question(
      question: question['question'],
      id: question['id'],
      answer: question['answer_index'],
      options: question['options']
  )
  ).toList();
  List<Question> get questions=>this.question;
  bool _isAnswered=false;
  bool get isAnswered=>this._isAnswered;
  int? _correctans;
  int? get correctans=>this._correctans;
  int? _selectans;
  int? get selectans=>this._selectans;
  RxInt _questionnumber=1.obs;
  RxInt get questionnumber=>this._questionnumber;
  int _numOfCorrectAnswer=0;
  int? get numOfCorrectAnswer=>this._numOfCorrectAnswer;
  @override
  void onInit() {
    _animationController=AnimationController(duration: Duration(seconds: 20),vsync: this);
    _animation=Tween(begin: 0.0,end: 1.0).animate(_animationController)..addListener(() {
      update();
    });
    _animationController.forward();
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pagecontroller.dispose();
  }
  void checkans(Question question,int selectedindex){
    _isAnswered=true;
    _correctans=question.answer;
    _selectans=selectedindex;
    if(_correctans==_selectans) {

  _numOfCorrectAnswer++;
      update();

    }
    // Future.delayed(Duration(seconds: 3), () {
    //   nextques();
    // });
  }
  void nextques(){
    if(_questionnumber.value!=questions.length){
      _isAnswered=false;
      _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
  else  {
      Get.to(ScoreScreen());
    }
  }
  void previous(){
    if(_questionnumber.value!=1){
      _isAnswered=false;
      _pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
  }
  void updatetheqnnumber(int index){
    _questionnumber.value=index+1;
  }

}
