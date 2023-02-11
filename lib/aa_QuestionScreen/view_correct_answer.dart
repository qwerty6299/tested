import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../common_widgets/colors_widget.dart';
import '../common_widgets/loader.dart';
import '../model/Viewanswermodel.dart';
import '../wallet_module/wallet.dart';
import 'constants.dart';

class ViewAnswer extends StatefulWidget {
  const ViewAnswer({Key? key}) : super(key: key);

  @override
  State<ViewAnswer> createState() => _ViewAnswerState();
}

class _ViewAnswerState extends State<ViewAnswer> {
  String thetoken="";
  Viewanswermodel? viewanswermodel;
  PageController pagepageController=PageController();
  bool optionselected=false;
  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the inside subcat  token is $thetoken");
  }
  int currentindex=0;
  @override
  void initState() {

    pagepageController=PageController(initialPage:currentindex );
    super.initState();
    gettoken().whenComplete(() async{
      getmyanswer();
    });
  }
  @override
  void dispose() {
    pagepageController.dispose();
    super.dispose();
  }
  void _nextPage(int delta) {
    pagepageController.animateToPage(
        currentindex + delta,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease
    );
  }
  void _handlePageChanged(int page) {
    setState(() {
      currentindex = page;
      print("current index is $currentindex");
    });
  }
  Future<Viewanswermodel?> getmyanswer()async{
    try {
      final response = await http.get(Uri.parse("http://3.227.35.5:3002/api/v2/view_result?testId=6355555"),headers: {
        HttpHeaders.authorizationHeader:"Bearer $thetoken"
      });

      if (response.statusCode == 200) {
        print(" question is ${response.body}");
        viewanswermodel=viewanswermodelFromJson(response.body);
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
    return viewanswermodel;

  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          _appBar(),

          SizedBox(
            height: size.height*0.03,
          ),
          Expanded(
              child: viewanswermodel?.result==null?Center(
                child: Loader(),
              ): PageView.builder(

                physics: NeverScrollableScrollPhysics(),
                controller: pagepageController,
                itemCount: viewanswermodel?.result?.length,
                onPageChanged:_handlePageChanged,
                itemBuilder: (context, ind) {
                  print("the ddddlen is ${viewanswermodel?.result?.length}");
                  return  SingleChildScrollView(
                    child: Column(


                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Questions ${ind+1}/${viewanswermodel?.result?.length}',style: TextStyle(
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
                          child:
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              viewanswermodel?.result?[ind]?.type=="mcq"?  Text("${viewanswermodel?.result?[ind]?.question}", style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.black)):Text('${viewanswermodel?.result?[ind]!.question}', style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.black)),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              viewanswermodel?.result?[ind]?.type=="mcq"?Container():
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:viewanswermodel?.result?[ind]?.questions?.length,
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
                                            Text('${viewanswermodel?.result?[ind]?.questions?[index]?.subQuestion}',style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ],
                                        ),
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap:true,
                                            itemCount: viewanswermodel?.result?[ind]?.questions?[index]?.options?.length,
                                            itemBuilder: (BuildContext context, int contextindex) {
                                              return    GestureDetector(
                                                onTap: (){
                                                  print("mcqid${viewanswermodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.id}");
                                                  print("mcqid${viewanswermodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.value}");
                                                  print("mcqid${viewanswermodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.choose}");
                                                },
                                                child: Container(
                                                    width:MediaQuery.of(context).size.width,
                                                    margin: EdgeInsets.only(top: kDefaultPadding),
                                                    padding: EdgeInsets.all(kDefaultPadding),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                        border: Border.all(
                                                            color: Colors.grey
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

                                                        Text('${viewanswermodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.op}'),
                                                        Expanded(child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                          viewanswermodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.value==true?Container(
                                                              height: 26,
                                                              width: 26,
                                                              decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                borderRadius: BorderRadius.circular(50.0),

                                                              ),
                                                              child: Icon(Icons.done,color: Colors.white,)):Container(),
                                                            viewanswermodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.value==false?
                                                          (viewanswermodel?.result?[ind]?.questions?[index]?.options?[contextindex]?.choose==true)?
                                                          Container(
                                                              height: 26,
                                                              width: 26,
                                                              decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.circular(50.0),

                                                              ),
                                                              child: Icon(Icons.close,color: Colors.white,)):Container():Container(),
                                                        ],))
                                                      ],
                                                    )),
                                              );
                                            })





                                      ],
                                    );
                                  }),



                              viewanswermodel?.result?[ind]?.type=="mcq"?
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:viewanswermodel?.result?[ind]?.options?.length,
                                  itemBuilder: (ctx,cind){
                                    return GestureDetector(
                                      onTap: (){
                                        print("mcqid${viewanswermodel?.result?[ind]?.options?[cind]?.id}");
                                        print("mcqid${viewanswermodel?.result?[ind]?.options?[cind]?.value}");
                                        print("mcqid${viewanswermodel?.result?[ind]?.options?[cind]?.choose}");
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
                                                      color: Colors.grey
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
                                                  Text('${viewanswermodel?.result?[ind]?.options?[cind]?.op}'),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        viewanswermodel?.result?[ind]?.options?[cind]?.value==true?Container(
                                                            height: 26,
                                                            width: 26,
                                                            decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                borderRadius: BorderRadius.circular(50.0),


                                                            ),
                                                            child: Icon(Icons.done,color: Colors.white,)):Container(),
                                                        viewanswermodel?.result?[ind]?.options?[cind]?.choose==true?Container(
                                                            height: 26,
                                                            width: 26,
                                                            decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.circular(50.0),

                                                            ),
                                                            child: Icon(Icons.close,color: Colors.white,)):Container(),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),




                                        ],
                                      ),
                                    );
                                  }):Container(),
                              SizedBox(
                                height: kDefaultPadding,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  ElevatedButton(

                                    onPressed: (){
                                      _nextPage(-1);

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
    ));
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
}
