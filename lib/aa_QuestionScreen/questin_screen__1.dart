import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:TESTED/aa_QuestionScreen/scoreboard.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:TESTED/model/Questionmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_widgets/colors_widget.dart';
import '../model/Endquestionmodel.dart';
import '../model/Submitanswermodel.dart';
import '../provider/ApiProviders.dart';
import 'all_question_screen.dart';
import 'constants.dart';
import '../wallet_module/wallet.dart';
import 'package:http/http.dart' as http;

class QuestionScreen1 extends StatefulWidget {
  int currentindex;
   QuestionScreen1({Key? key,required this.currentindex}) : super(key: key);

  @override
  State<QuestionScreen1> createState() => _QuestionScreen1State();
}

class _QuestionScreen1State extends State<QuestionScreen1> with SingleTickerProviderStateMixin {
  double _value = 0.0;
  double _secondValue = 0.0;

dynamic selectedindex=-1;
dynamic submcqselectedindex=-1;
dynamic twosubmcqselectedindex=-1;
dynamic threesubmcqselectedindex=-1;
dynamic foursubmcqselectedindex=-1;
  Timer? _progressTimer;
  Timer? _secondProgressTimer;
  bool optionselected=false;
  bool secondoptionselected=false;
PageController pagepageController=PageController();
  bool _done = false;
  List questionsandoption=[];
  Questionmodel? questionmodel;
  String thetoken="";
  String timeremain="";
  String testid="";
  String testype="";
  Future gettime()async{
    final prefs = await SharedPreferences.getInstance();
    String dd=prefs.getString("savetime").toString();
    String dd1=prefs.getString("savetestid").toString();
    String dd2=prefs.getString("savetesttype").toString();
    setState((){
      timeremain=dd;
      testid=dd1;
      testype=dd2;
    });
    print("time get is $timeremain");
    print("time get is $testid");
    print("time get is $testype");
  }

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
      final response = await http.get(Uri.parse("http://3.227.35.5:3002/api/v2/load_questions?testType=$testype&testId=$testid&page=1"),headers: {
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

  void _handlePageChanged(int page) {
    setState(() {
      widget.currentindex = page;
      print("current index is ${widget.currentindex}");
    });
  }
  double percent = 0.0;
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  Timer? countdownTimer;
  Duration? myDuration ;
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration!.inSeconds - reduceSecondsBy;
      if (seconds < 0) {

        countdownTimer!.cancel();

      } else {
        percent += 0.1;
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  @override
  void initState() {
gettime().whenComplete(() async{
  myDuration = Duration(minutes:int.parse("$timeremain"));
});

    gettoken().whenComplete(() async{
      await getmyquestion();
    }) ;










    pagepageController=PageController(initialPage: widget.currentindex );

    _resumeProgressTimer();
    _secondProgressTimer =
        Timer.periodic(const Duration(milliseconds: 10), (_) {
          setState(() {
            _secondValue += 0.001;
            if (_secondValue >= 1) {
              _secondProgressTimer!.cancel();
            }
          });
        });
    stopWatchStream();
    print("vhbjjkj${double.parse("${secondsStr}")/100}");
    super.initState();
    startTimer();
    timerStream = stopWatchStream();
    timerSubscription = timerStream!.listen((int newTick) {
      setState(() {
        // hoursStr = ((newTick / (60 * 60)) % 60)
        //     .floor()
        //     .toString()
        //     .padLeft(2, '0');
        minutesStr = ((newTick / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        secondsStr =
            (newTick % 60).floor().toString().padLeft(2, '0');
      });
    });
  }

  _resumeProgressTimer() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() {
        _value += 0.0005;
        if (_value >= 1) {
          _progressTimer!.cancel();
          _done = true;
        }
      });
    });
  }
  @override
  void dispose() {
    _progressTimer?.cancel();
    _secondProgressTimer?.cancel();
    pagepageController.dispose();
    super.dispose();
  }
  void _nextPage(int delta) {
    if( widget.currentindex +1 == questionmodel?.result?.length){

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => CategoryProvider(),
                child: Scoreboardpage(),
              )
          )
      );
    }

    pagepageController.animateToPage(
      widget.currentindex + delta,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,

    );
    print("my current index is${widget.currentindex}");
  }
  void _previouspage(int delta) {


    pagepageController.animateToPage(
      widget.currentindex + delta,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,

    );
    print("my current index is${widget.currentindex}");
  }


  bool countDown =true;
  bool flag = true;
  Stream<int>? timerStream;
  StreamSubscription<int>?  timerSubscription;
  String minutesStr = '00';
  String secondsStr = '00';
  Stream<int> stopWatchStream() {
    StreamController<int> streamController = StreamController();
    Timer? timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }
  Endquestionmodel? endquestionmodel;
  void callendquestn() async{
    var response= await http.post(Uri.parse("http://3.227.35.5:3002/api/v2/load_questions?testType=A&testId=63c4e8b803b49dcd4dd14b85&page=1"),headers: {
      HttpHeaders.authorizationHeader:"Bearer $thetoken"
    });
    if(response.statusCode==200){
      print("end question${response.body}");
      setState((){
        endquestionmodel=endquestionmodelFromJson(response.body);
      });

      Navigator.of(context).pop(true);

    }else{
      print("sta${response.body}");
    }
  }


  @override
  Widget build(BuildContext context) {
    // getanswer();
    String strDigits(int n) => n.toString().padLeft(2, '0');
    // final days = strDigits(myDuration!.inDays);
    // Step 7
   // final hours = strDigits(myDuration!.inHours.remainder(24));
    final minutes =strDigits(myDuration!=null? myDuration!.inMinutes.remainder(60):0);
    final seconds = strDigits(myDuration!=null? myDuration!.inSeconds.remainder(60): 0);
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          _appBar(),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 20,
              child: LiquidLinearProgressIndicator(
                value: percent ,

                valueColor: AlwaysStoppedAnimation(Colors.orange),
                backgroundColor: Colors.white,
                borderColor: Colors.white,
                borderWidth: 1.0,
                borderRadius: 4.0,
                direction: Axis.horizontal,

              ),
            ),
        SizedBox(
          height: 6,
        ),

        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$minutes:$seconds',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 10),
                ),

              ],
            ),
          ),
        ),
            SizedBox(
              height: size.height*0.01,
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AllQuestionScreen()));
            },
              child: buttons(text:'All Questions' )),
          GestureDetector(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(

                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(image: AssetImage('images/solvedtesta.png'),),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Do you want to end the test?'),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                        TextButton(
                          onPressed: () {

                            callendquestn();
                          },
                          child: Text('Yes'),
                        )
                      ],
                    );
                  });
            },
              child: buttons(text:'End Questions' )),
        ],
      ),

            SizedBox(
              height: size.height*0.01,
            ),

      Expanded(
          child: questionmodel?.result==null?Center(
            child: Loader(),
          ): PageView.builder(

            physics: NeverScrollableScrollPhysics(),
            controller: pagepageController,
            itemCount: questionmodel?.result?.length,
            onPageChanged:_handlePageChanged,
            itemBuilder: (context, ind) {
              print("the ddddlen is ${questionmodel?.result?.length}");
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('Questions ${ind+1}/${questionmodel?.result?.length}',style: TextStyle(
                              color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
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
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          questionmodel?.result?[ind]?.pattern=="mcq"?  Row(
                            children: [
                              Text('In Q${ind+1} , ',style: Theme
                          .of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black) ),
                              SizedBox(
                                width: 6,
                              ),
                              Text("${questionmodel?.result?[ind]?.question}",maxLines: 3,style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.black,)),
                            ],
                          ):Text('In Q${ind+1} , ${questionmodel?.result?[ind]!.question}',maxLines: 3, style: Theme
                              .of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black) ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          questionmodel?.result?[ind]?.pattern=="mcq"?Container():
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:questionmodel?.result?[ind]?.questions?.length,
                                  itemBuilder: (ctx,index){
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: kDefaultPadding,
                                    ),
                                    Row(
                                      children: [
                                        Text(index==0?"${ind+1}.${index+1}":(index==1)?"${ind+1}.${index+1}":
                                        (index==2)?"${ind+1}.${index+1}":"${ind+1}.${index+1}",style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('${questionmodel?.result?[ind]?.questions?[index]?.subQuestion}',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                        ),),
                                      ],
                                    ),
                                    ListView.builder(
                                        key:  PageStorageKey<String>('page'),
                                        physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap:true,
                                        itemCount: questionmodel?.result?[ind]?.questions?[index]?.options?.length,
                                        itemBuilder: (BuildContext context, int contextindex) {
                                    return GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          if(index==0) {
                                            submcqselectedindex = questionmodel
                                                ?.result?[ind]?.questions?[index]
                                                ?.options?[contextindex];
                                            postmyanswer(type: '${questionmodel
                                                ?.result?[ind]?.pattern}');
                                            saveanswer(answer: "${submcqselectedindex}");
                                            print(
                                                "cind value is ${submcqselectedindex}");
                                          }
                                          if(index==1){
                                            twosubmcqselectedindex = questionmodel
                                                ?.result?[ind]?.questions?[index]
                                                ?.options?[contextindex];
                                            postmyanswer(type: '${questionmodel
                                                ?.result?[ind]?.pattern}');
                                            saveanswer(answer: "${twosubmcqselectedindex}");
                                            print(
                                                "twosubmcqselectedindex value is ${twosubmcqselectedindex}");
                                          }
                                          if(index==2){
                                            threesubmcqselectedindex = questionmodel
                                                ?.result?[ind]?.questions?[index]
                                                ?.options?[contextindex];
                                            postmyanswer(type: '${questionmodel
                                                ?.result?[ind]?.pattern}');
                                            saveanswer(answer: "${threesubmcqselectedindex}");
                                            print(
                                                "threesubmcqselectedindex value is ${threesubmcqselectedindex}");
                                          }
                                          if(index==3){
                                            foursubmcqselectedindex = questionmodel
                                                ?.result?[ind]?.questions?[index]
                                                ?.options?[contextindex];
                                            postmyanswer(type: '${questionmodel
                                                ?.result?[ind]?.pattern}');
                                            saveanswer(answer: "${foursubmcqselectedindex}");
                                            print("foursubmcqselectedindex value is ${foursubmcqselectedindex}");
                                          }
                                          });
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

                                               color:(index==0)? (submcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex] ?Colors.blue:Colors.grey):
                                               (index==1)?(twosubmcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex] ? Colors.blue:Colors.grey):
                                               (index==2)?(threesubmcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex] ? Colors.blue:Colors.grey):
                                               (index==3)?(foursubmcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex] ? Colors.blue:Colors.grey):
                                               Colors.grey

                                                  )
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(contextindex==0?"A.":(contextindex==1)?"B.":(contextindex==2)?"C.":"D.",style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('${questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.option}'),
                                                  (index==0)?    (submcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex]?
                                                  Expp():SizedBox()):(index==1)? (twosubmcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex]?
                                                  Expp():SizedBox()):(index==2)? (threesubmcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex]?
                                                  Expp():SizedBox()):(index==3)? (foursubmcqselectedindex == questionmodel?.result?[ind]?.questions?[index]?.options?[contextindex]?
                                                  Expp():SizedBox()):
                                                  SizedBox()
                                                ],
                                              )),




                                        ],
                                      ),
                                    );

                                    })





                                  ],
                                );
                              }),



                          questionmodel?.result?[ind]?.pattern=="mcq"?
                          ListView.builder(

                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount:questionmodel?.result?[ind]?.options?.length,
                              itemBuilder: (ctx,cind){
                                return    GestureDetector(
                                  onTap: (){
                                    setState(() {


                                      selectedindex=questionmodel?.result?[ind]?.options?[cind];

                                      postmyanswer(type:"${questionmodel?.result?[ind]?.pattern}");
                                      print("cind value is ${selectedindex}");
                                    });
                                    // saveanswer(answer: "${questionmodel?.result?[ind]?.options?[cind]?.}");
                                    // print("cgvhh${questionmodel?.result?[ind]?.options?[cind]?.optionId}");


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

                                                  color:selectedindex==questionmodel?.result?[ind]?.options?[cind]?Colors.blue:Colors.grey
                                              )
                                          ),
                                          child: Row(
                                            children: [
                                              Text(cind==0?"A.":(cind==1)?"B.":(cind==2)?"C.":"D.",style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('${questionmodel?.result?[ind]?.options?[cind]?.option}'),
                                              selectedindex==questionmodel?.result?[ind]?.options?[cind]? Expp()    :SizedBox()
                                            ],
                                          )),




                                    ],
                                  ),
                                );
                                 // Selectanswer(cind: cind, optionname: "${questionmodel?.data?[ind]?.options?[cind]?.op}",
                                 //   id: '${questionmodel?.data?[ind]?.options?[cind]?.id}', type: '${questionmodel?.data?[ind]?.type}',);
                              }):Container(),
                          SizedBox(
                            height: kDefaultPadding,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              ElevatedButton(

                                onPressed: (){
                                  _previouspage(-1);

                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),),
                                child: Text('Previous'),

                              ),
                              ElevatedButton(
                                onPressed:(){
                                  _nextPage(1);
                                } ,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),),
                                child: Text('Next'),

                              ),

                            ],
                          )

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text('${ind+1}. ${questionmodel?.data[ind].options[0].a}',
                          //       style: TextStyle(
                          //         //  color: gettherightcolor()
                          //           fontSize: 16, fontWeight: FontWeight.bold
                          //       ),),
                          //
                          //     optionselected==true?    Container(
                          //         height: 26,
                          //         width: 26,
                          //         decoration: BoxDecoration(
                          //             color: Colors.blue,
                          //             borderRadius: BorderRadius.circular(50.0),
                          //             border: Border.all(color: Colors.blue)
                          //         ),
                          //         child: Icon(
                          //           Icons.done, color: Colors.white, size: 16,)
                          //     ):SizedBox()
                          //   ],
                          // ),


                          // SizedBox(
                          //   height: MediaQuery
                          //       .of(context)
                          //       .size
                          //       .height * 0.018,
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       secondoptionselected=!secondoptionselected;
                          //       optionselected=false;
                          //     });
                          //   },
                          //   child: Container(
                          //     margin: EdgeInsets.only(top: kDefaultPadding),
                          //     padding: EdgeInsets.all(kDefaultPadding),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15.0),
                          //         border: Border.all(
                          //
                          //             color:secondoptionselected==true?Colors.blue: Colors.grey
                          //         )
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text('2. ${questionmodel?.data?[ind].options?[1].b}',
                          //           style: TextStyle(
                          //             //  color: gettherightcolor()
                          //               fontSize: 16, fontWeight: FontWeight.bold
                          //           ),),
                          //
                          //         secondoptionselected==true?  Container(
                          //             height: 26,
                          //             width: 26,
                          //             decoration: BoxDecoration(
                          //                 color: Colors.blue,
                          //                 borderRadius: BorderRadius.circular(50.0),
                          //                 border: Border.all(color: Colors.blue)
                          //             ),
                          //             child: Icon(
                          //               Icons.done, color: Colors.white, size: 16,)
                          //         ):SizedBox()
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery
                          //       .of(context)
                          //       .size
                          //       .height * 0.018,
                          // ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     margin: EdgeInsets.only(top: kDefaultPadding),
                          //     padding: EdgeInsets.all(kDefaultPadding),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15.0),
                          //         border: Border.all(
                          //
                          //             color: Colors.grey
                          //         )
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text('3. ${questionmodel?.data?[ind].options?[2].c}',
                          //           style: TextStyle(
                          //             //  color: gettherightcolor()
                          //               fontSize: 16, fontWeight: FontWeight.bold
                          //           ),),
                          //
                          //         // Container(
                          //         //     height: 26,
                          //         //     width: 26,
                          //         //     decoration: BoxDecoration(
                          //         //         color: Colors.green,
                          //         //         borderRadius: BorderRadius.circular(50.0),
                          //         //         border: Border.all(color: Colors.green)
                          //         //     ),
                          //         //     child: Icon(
                          //         //       Icons.done, color: Colors.white, size: 16,)
                          //         // )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery
                          //       .of(context)
                          //       .size
                          //       .height * 0.018,
                          // ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     margin: EdgeInsets.only(top: kDefaultPadding),
                          //     padding: EdgeInsets.all(kDefaultPadding),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15.0),
                          //         border: Border.all(
                          //
                          //             color: Colors.grey
                          //         )
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text('4. ${questionmodel?.data?[ind].options?[3].d}',
                          //           style: TextStyle(
                          //             //  color: gettherightcolor()
                          //               fontSize: 16, fontWeight: FontWeight.bold
                          //           ),),
                          //
                          //         // Container(
                          //         //     height: 26,
                          //         //     width: 26,
                          //         //     decoration: BoxDecoration(
                          //         //         color: Colors.green,
                          //         //         borderRadius: BorderRadius.circular(50.0),
                          //         //         border: Border.all(color: Colors.green)
                          //         //     ),
                          //         //     child: Icon(
                          //         //       Icons.done, color: Colors.white, size: 16,)
                          //         // )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery
                          //       .of(context)
                          //       .size
                          //       .height * 0.04,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //
                          //     ElevatedButton(
                          //
                          //       onPressed: (){
                          //         _nextPage(-1);
                          //
                          //       },
                          //       style: ElevatedButton.styleFrom(
                          //         primary: Colors.grey,
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 20, vertical: 5),
                          //         textStyle: TextStyle(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.bold),),
                          //       child: Text('Previous'),
                          //
                          //     ),
                          //     ElevatedButton(
                          //       onPressed:(){
                          //         _nextPage(1);
                          //      } ,
                          //       style: ElevatedButton.styleFrom(
                          //         primary: Colors.blue,
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 30, vertical: 5),
                          //         textStyle: TextStyle(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.bold),),
                          //       child: Text('Next'),
                          //
                          //     ),
                          //
                          //   ],
                          // )


                        ],
                      ),
                    )


                  ],
                ),
              );
            },
          )

     )



          ],
        ),
      ),
    );
  }
  Widget _appBar() {
    return Container(
      height: 60,
      color: theme_color,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: white_color),
              child: Image.asset('images/back_arrow.png', height: 18),
            ),
          ),
          Expanded(
            child: Image.asset(
              'images/theme_2_logo.png',
              height: 180,
              fit: BoxFit.fitHeight,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WalletPage()));
            },
            child: Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: white_color),
                child: const Icon(Icons.account_balance_wallet_outlined)),
          ),
        ],
      ),
    );
  }
  Submitanswermodel? submitanswermodel;
  Future<Submitanswermodel?> postmyanswer({required String type})async{
    try {
      var body={
        "testId": "12",
        "questionId": "13",
        "answerId":["","","",""],
        "testName":"test a",
        "questionType":"${type}"
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
  saveanswer({required String answer})async{
    final prefs=await SharedPreferences.getInstance();
    prefs.setString("$answer", "answer");
  }
  String xxx="";
  getanswer()async{
    final prefs=await SharedPreferences.getInstance();
   xxx=  prefs.getString("answer").toString();
    setState(() {
print("the vvv$xxx");
    });
  }
  Widget buttons({required String text}){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue.shade600,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5),

        ),
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

}
class Expp extends StatelessWidget {
  const Expp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Row(
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
    ));
  }
}

