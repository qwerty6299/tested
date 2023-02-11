import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:TESTED/answer_pdf_module/ans_pdf.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/connectivity.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/globals.dart';

import 'package:TESTED/common_widgets/no_internet.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/home_module/check_eligible/check_model.dart';
import 'package:TESTED/test_module/test_page.dart';
import 'package:TESTED/wallet_module/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Shimmer/chapterpageshimmer.dart';
import '../aa_QuestionScreen/questin_screen__1.dart';
import '../provider/ApiProviders.dart';
import 'check_eligible/check_presenter.dart';
import 'check_eligible/check_view.dart';
import 'home_mvp/homepage_model.dart';

class ChapterPage extends StatefulWidget {

  final String sid;
  const ChapterPage(
      {Key? key,


      required this.sid})
      : super(key: key);

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage>
    implements CheckEligibityView {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  int? selectedTest;
  var noConnection;
  bool _isLoading = false;
  ChapTest? _chptListApplied;
  String? _cid;
  int _testNo = 1;
  bool testatapped=false;
  void _checkEligibleApiCall(i, cid) {
    Internetconnectivity().isConnected().then((value) async {
      var _reqBody = {
        "contact": TestedGlobals.userContact,
        "test": i,
        "s_id": widget.sid != null ? widget.sid : '',
        "c_id": cid
      };
      if (value == true) {
        CheckEligibilityPresenter().getcheckResp(this, _reqBody);
      } else {
        setState(() {
          _isLoading = false;
        });
        noConnection = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const NoInternet()));
        if (noConnection != null) {
          setState(() {
            _isLoading = true;
          });
          CheckEligibilityPresenter().getcheckResp(this, _reqBody);
        }
      }
    });
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


  String thetoken="";

  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the inside subcat  token is $thetoken");
  }
  @override
  void initState() {
     super.initState();
     print("fjsdnfj${widget.sid}");
     gettoken().whenComplete(() async{
     await   Provider.of<CategoryProvider>(context,listen: false).getinsidesubcat(widget.sid,header:thetoken);

     });
  }



  @override
  Widget build(BuildContext context) {

    final insidesubcat=Provider.of<CategoryProvider>(context);
    return SafeArea(

        child: Scaffold(
          backgroundColor: milky_white,

          body:
          insidesubcat.isLoading == true ?Chapterpageshimmer():
          Column(
            children: [
              _appBar(),
              SizedBox(
               height: 20,
              ),

                  Expanded(
                    child: ListView.builder(
                           shrinkWrap: true,
                           itemCount: insidesubcat.insideSubCategorymodel?.data.length,
                           itemBuilder: (ctx,indo){
                         return  Column(
                           children: [
                             Text('${insidesubcat.insideSubCategorymodel?.data[indo].bookName}'??""),
                             SizedBox(
                               height:MediaQuery.of(context).size.height,
                               child: ListView.builder(
                                   shrinkWrap: true,
                                   itemCount: insidesubcat.insideSubCategorymodel?.data[indo].chapters.length,
                                   itemBuilder: (ctx,indd){
                                     return Container(
                                       margin: EdgeInsets.all(6.0),

                                       padding: const EdgeInsets.symmetric(horizontal: 15,),
                                       decoration: BoxDecoration(
                                           color: white_color,
                                           border: Border.all(color: shadow_color, width: 0.5),
                                           borderRadius: BorderRadius.circular(10)),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,

                                             children: [
                                               SizedBox(
                                                 height: 10,
                                               ),
                                               Padding(
                                                 padding:  EdgeInsets.symmetric(vertical: 9),

                                                 child: TextWidget(
                                                   softwrap: true,
                                                   maxLines: 2,
                                                   text:
                                                   'Chapter ${indd+1} : ${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].chapterName}',
                                                   size: 16,
                                                   weight: FontWeight.w700,
                                                 ),
                                               ),
                                               SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   Image(image: AssetImage('images/clock.png')),
                                                   SizedBox(width: 5,),
                                                   TextWidget(
                                                     text:
                                                     'Time : ${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].time}',
                                                     size: 12,
                                                     weight: FontWeight.w500,
                                                   ),
                                                 ],
                                               ),
                                               SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   Image(image: AssetImage('images/question.png')),
                                                   SizedBox(width: 5,),
                                                   TextWidget(
                                                     text:
                                                     'Question:   ${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].questions}',
                                                     size: 12,
                                                     weight: FontWeight.w500,
                                                   ),
                                                 ],
                                               )
                                             ],
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.symmetric(vertical : 15.0),
                                             child: SizedBox(
                                             width: 100,
                                               height: 80,
                                               child: ListView.builder(
                                                   shrinkWrap: true,
                                                   itemCount: insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests.length,
                                                   itemBuilder: (ctx,testindex){
                                                 return  Column(
                                                   children: [
                                                     SizedBox(
                                                       height: 6,
                                                     ),
                                                     GestureDetector(
                                                       onTap: (){
                                                         savetime(savetime: "${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].time}",
                                                        testtype: "${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName[5]}" ,
                                                         testid: "${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testId}");
                                                         (insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].attempted==true)?null:

                                                        (insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].enrolled==true)?

                                                         Navigator.push(context,
                                                             MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
                                                                 create: (context) => CategoryProvider(),
                                                                 child:  QuestionScreen1(currentindex: 0,)))):
                                                         insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName=="test a" &&
                                                             insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].attempted==false ?

                                                         // showDialog(
                                                         //   context: context,
                                                         //   builder: (BuildContext context) {
                                                         //     return AlertDialog(
                                                         //       shape: RoundedRectangleBorder(
                                                         //         borderRadius: BorderRadius.circular(10.0),
                                                         //       ),
                                                         //
                                                         //
                                                         //       content: Column(
                                                         //         mainAxisSize: MainAxisSize.min,
                                                         //         children: [
                                                         //
                                                         //
                                                         //           Image(image: AssetImage('images/solvedtesta.png'),),
                                                         //           SizedBox(
                                                         //             height: MediaQuery.of(context).size.height*0.02,
                                                         //           ),
                                                         //           CustomText(14, FontWeight.bold, Colors.black,
                                                         //               '25 points will be deducted from\n your wallet to open Test 2'),
                                                         //         ],
                                                         //       ),
                                                         //       actions: [
                                                         //         Center(child: ElevatedButton(
                                                         //           child: Text('Ok'),
                                                         //           style: ElevatedButton.styleFrom(
                                                         //             primary: Colors.blue,
                                                         //
                                                         //             textStyle: const TextStyle(
                                                         //                 color: Colors.white, fontSize: 14, fontStyle: FontStyle.normal),
                                                         //           ),
                                                         //           onPressed: () {
                                                         //             Navigator.push(context,
                                                         //                 MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
                                                         //                     create: (context) => CategoryProvider(),
                                                         //                     child: const QuestionScreen1())));
                                                         //           },
                                                         //         ),
                                                         //         )
                                                         //       ],
                                                         //     );
                                                         //   },
                                                         // )
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
                                                                     Text('Have You Solved Test 1 \n Question Paper?',style: TextStyle(
                                                                       fontSize: 14,
                                                                       fontWeight: FontWeight.bold,
                                                                       color: Colors.black
                                                                     ),),
                                                                   ],
                                                                 ),
                                                                 actions: <Widget>[
                                                                   TextButton(
                                                                       onPressed: () {
                                                                         Navigator.push(
                                                                             context,
                                                                             MaterialPageRoute(
                                                                                 builder: (context) => AnswerPdfPage(
                                                                                   url:"${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].link}" ?? '',
                                                                                 )));
                                                                       },
                                                                       child: Text('No')),
                                                                   TextButton(
                                                                     onPressed: () async{
                                                                       // Navigator.pop(context);
                                                                       // showDialog(
                                                                       //   context: context,
                                                                       //   builder: (BuildContext context) {
                                                                       //     return AlertDialog(
                                                                       //       shape: RoundedRectangleBorder(
                                                                       //         borderRadius: BorderRadius.circular(10.0),
                                                                       //       ),
                                                                       //
                                                                       //
                                                                       //       content: Column(
                                                                       //         mainAxisSize: MainAxisSize.min,
                                                                       //         children: [
                                                                       //           Image(image: AssetImage('images/alert_dia.png'),),
                                                                       //           SizedBox(
                                                                       //             height: MediaQuery.of(context).size.height*0.02,
                                                                       //           ),
                                                                       //           CustomText(14, FontWeight.bold, Colors.black,
                                                                       //               '25 points will be deducted from\n your wallet to open Test 2'),
                                                                       //         ],
                                                                       //       ),
                                                                       //       actions: [
                                                                       //         Center(child: ElevatedButton(
                                                                       //           child: Text('Ok'),
                                                                       //           style: ElevatedButton.styleFrom(
                                                                       //             primary: Colors.blue,
                                                                       //
                                                                       //             textStyle: const TextStyle(
                                                                       //                 color: Colors.white, fontSize: 14, fontStyle: FontStyle.normal),
                                                                       //           ),
                                                                       //           onPressed: () {
                                                                       //             Navigator.pop(context);
                                                                       //             Navigator.push(context,
                                                                       //                 MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
                                                                       //                     create: (context) => CategoryProvider(),
                                                                       //                     child:  QuestionScreen1(currentindex: 0,))));
                                                                       //           },
                                                                       //         ),
                                                                       //         )
                                                                       //       ],
                                                                       //     );
                                                                       //   },
                                                                       // );
                                                                       await   Provider.of<CategoryProvider>(context,listen: false).getenrolled(
                                                                           header:thetoken,testtype: "${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName[5]}",
                                                                           testid:"${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testId}");
                                                                     await  Navigator.push(context,
                                                                           MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
                                                                               create: (context) => CategoryProvider(),
                                                                               child:  QuestionScreen1(currentindex: 0,))));
                                                                       Navigator.of(context).pop();

                                                                     },
                                                                     child: Text('Yes'),
                                                                   )
                                                                 ],
                                                               );
                                                             })
                                                             :null;

                                                       },
                                                       child: Container(
                                                         padding: EdgeInsets.symmetric(
                                                             horizontal: 10, vertical: 5),
                                                         decoration: BoxDecoration(
                                                             color:insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName=="test a" &&
                                                                 insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].attempted==true?
                                                               Colors.grey:Colors.orange.shade700,
                                                             borderRadius: BorderRadius.circular(5)),
                                                         child: Row(
                                                           children: [


                                                             ((insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName=="test b")&&

                                                                 insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].attempted==false)?

                                                                Icon(Icons.lock_outline_sharp,color: Colors.white,size: 10,):SizedBox.shrink(),
                                                             ((insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName=="test b")&&

                                                                 insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].attempted==false)?    SizedBox(
                                                               width: 5,
                                                             ):SizedBox.shrink(),
                                                             insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName=="test a" &&
                                                                 insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].attempted==true?

                                                             Row(
                                                               children: [
                                                                 Icon(Icons.lock_outline_sharp,color: Colors.white,size: 10,),
                                                                 SizedBox(
                                                                   width: 5,
                                                                 ),
                                                                 TextWidget(
                                                                   text: 'Attempted',
                                                                   size: 12.8,
                                                                   color: white_color,
                                                                 ),
                                                               ],
                                                             ):

                                                             TextWidget(
                                                               text: '${insidesubcat.insideSubCategorymodel?.data[indo].chapters[indd].tests[testindex].testName}',
                                                               size: text_size_16,
                                                               color: white_color,
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                     SizedBox(height: 5,)
                                                   ],
                                                 );
                                               }),
                                             ),
                                           ),
                                         ],
                                       ),
                                     );
                                   }),
                             ),
                           ],
                         );

                 }
                  ),
                  ),
            ],
          ),
        ));
  }
  Future savetime({required String savetime,required String testid , required String testtype})async{
    final prefs=await SharedPreferences.getInstance();
    prefs.setString("savetime", savetime).toString();
    prefs.setString("savetestid", testid).toString();
    prefs.setString("savetesttype", testtype).toString();
    setState(() {

    });
  }

  Future<bool> _onWillPop(List<ChapTest>? _chptList, testno, i) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: [
              Image(image: AssetImage("images/dialopic.png")),
              SizedBox(
                height: 10,
              ),
              Text('Have you solved Test1'),
            ],
          ),
          content: Text('Question paper?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  // print(_chptList?[testno].url);
                  Navigator.of(context).pop(false);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnswerPdfPage(
                            url: _chptList?[testno].url ?? '',
                          )));

                },
                child: Text('No')),
            TextButton(
              onPressed: () {

              },
              child: Text('Yes'),
            )
          ],
        );

        //   Dialog(
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(25.0),
        //           bottomRight: Radius.circular(25.0))),
        //   child: Container(
        //     margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
        //     height: 140,
        //     child: Column(
        //       children: <Widget>[
        //         Container(
        //           child: TextWidget(
        //             text: 'Have you solved Test1',
        //             size: text_size_16,
        //             weight: FontWeight.bold,
        //             color: Colors.grey[700],
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 10,
        //         ),
        //         Container(
        //           child: TextWidget(
        //             text: 'Question paper?',
        //             size: text_size_16,
        //             weight: FontWeight.bold,
        //             color: Colors.grey[700],
        //           ),
        //         ),
        //         Container(
        //           margin: const EdgeInsets.only(top: 22),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: <Widget>[
        //               InkWell(
        //                 onTap: () {
        //                   setState(() {
        //                     _isLoading = false;
        //                   });
        //                   // print(_chptList?[testno].url);
        //                   Navigator.of(context).pop(false);
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => AnswerPdfPage(
        //                                 url: _chptList?[testno].url ?? '',
        //                               )));
        //                 },
        //                 child: Container(
        //                   width: 80,
        //                   height: 30,
        //                   alignment: Alignment.center,
        //                   padding:
        //                       EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        //                   decoration: BoxDecoration(
        //                     boxShadow: [
        //                       BoxShadow(
        //                           color: Colors.blue.withOpacity(0.5),
        //                           offset: Offset(0.0, 2.0),
        //                           blurRadius: 2.0,
        //                           spreadRadius: 0.0)
        //                     ],
        //                     color: theme_color,
        //                     borderRadius: BorderRadius.circular(5),
        //                   ),
        //                   child: const TextWidget(
        //                       text: 'No',
        //                       size: 15,
        //                       color: Colors.white,
        //                       weight: FontWeight.bold),
        //                 ),
        //               ),
        //               InkWell(
        //                 onTap: () {
        //                   // print(i);
        //                   // print(_chptList![testno].toMap());
        //                   // print(testno);
        //                   setState(() {
        //                     _chptListApplied = _chptList![testno];
        //                     _cid = _chapterList![i].cId;
        //                   });
        //                   _checkEligibleApiCall(
        //                       testno == 0 ? 1 : 2, _chapterList![i].cId);
        //                 },
        //                 child: Container(
        //                   width: 80,
        //                   height: 30,
        //                   alignment: Alignment.center,
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 20, vertical: 6),
        //                   decoration: BoxDecoration(
        //                     boxShadow: [
        //                       BoxShadow(
        //                           color: Colors.blue.withOpacity(0.5),
        //                           offset: Offset(0.0, 2.0),
        //                           blurRadius: 2.0,
        //                           spreadRadius: 0.0)
        //                     ],
        //                     color: theme_color,
        //                     borderRadius: BorderRadius.circular(5),
        //                   ),
        //                   child: const TextWidget(
        //                       text: 'Yes',
        //                       size: 15,
        //                       color: Colors.white,
        //                       weight: FontWeight.bold),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }

  Widget _redeemDialog() {
    print('object');
    return Dialog(
      child: Container(
        height: 400,
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(''), fit: BoxFit.cover)),
            ),
            const TextWidget(
              text: 'You have successfully earned TESTED points',
              size: text_size_16,
              color: black_color,
              alignment: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void checkEligibleErr(error) {
    print(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void checkResponse(EligibilityModel _eligibilityModelresp)



  {
    print(_eligibilityModelresp.toMap());
    if (_eligibilityModelresp.status == true) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop(false);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TestStartPage(
                    chptList: _chptListApplied,
                    sid: widget.sid,
                    cid: _cid,
                    // testNo: testno,
                  )));
    } else {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop(false);
      Fluttertoast.showToast(
          msg: _eligibilityModelresp.message ?? 'Already taken the test.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: red_color.shade700,
          fontSize: 16.0);
    }
  }

  Future<void> testRestrictionAlert(
      BuildContext context, List<ChapTest>? _chapterList, i) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 20),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const TextWidget(
                    text:
                        "25 Points will be deducted from your wallet to open Test 2",
                    size: text_size_16,
                    weight: FontWeight.w600,
                    alignment: TextAlign.center,
                  ),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: theme_color,
                        // gradient: theme_color,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                          _onWillPop(_chapterList, 1, i);
                        },
                        child: const TextWidget(
                          text: "Ok",
                          color: white_color,
                          size: text_size_14,
                          weight: FontWeight.bold,
                        )),
                  ),
                ],
              )),
        );
      },
    );
  }
}
