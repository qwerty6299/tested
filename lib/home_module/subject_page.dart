import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/wallet_module/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Shimmer/subjectpage_shimmer.dart';

import '../provider/ApiProviders.dart';
import 'chapter_page.dart';


class SubjectPage extends StatefulWidget {
final String id;
  const SubjectPage(
      {Key? key, required this.id})
      : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {





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
                  MaterialPageRoute(builder: (context) =>  WalletPage()));
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



  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the subjevt token is $thetoken");
  }
  @override
  void initState() {
    super.initState();
    print("dfbgfd${widget.id}");
    gettoken().whenComplete(() async{
   await   Provider.of<CategoryProvider>(context, listen: false).getsubcategory(widget.id,'$thetoken');
    });
    }

  String thetoken="";

  @override
  Widget build(BuildContext context) {
    final subcat=Provider.of<CategoryProvider>(context);
    return Container(
      color: black_color,
      child: SafeArea(
          bottom: true,
          top: true,
          child: Scaffold(
            backgroundColor: milky_white,

           body: subcat.isLoading == true ?const Subjectpageshimmer():Column(
             children: [
               _appBar(),
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.01,
               ),
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 16.0),
                         child: Text('${ subcat.subcatpro?.data.course??""}',style: TextStyle(
                           fontWeight: FontWeight.bold,fontSize: 18
                         ),),
                       )
                     ],
                   ),
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.01,
               ),


               GridView.builder(
                   shrinkWrap: true,
                   itemCount: subcat.subcatpro?.data.books.length ?? 0,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     crossAxisSpacing: 5.0,
                     mainAxisSpacing: 5.0,


                   ), itemBuilder: (ctx,i){
                 return GestureDetector(
                   onTap: () {
                     print("go to chapterpage");
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
                             create: (context) => CategoryProvider(),
                             child: ChapterPage(sid: '${subcat.subcatpro?.data.books[i].bookId}'))));
                   },
                   child: Container(
                     margin: const EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       color:i%2==0? Color.fromRGBO(255,242,231,1): Color.fromRGBO(229, 247, 255, 1),
                       border: Border.all(color: shadow_color, width: 0.5),
                       borderRadius: BorderRadius.only(
                           topLeft:Radius.circular(25.0),
                           topRight:Radius.circular(25.0),
                           bottomLeft: Radius.circular(25.0),
                           bottomRight: Radius.circular(25.0)),),
                     child: Column(

                       children: [
                         Row(

                           children: [

                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Column(
                                       children: [
                                         Image(image: AssetImage('images/subjectpage_icon.png'))

                                       ],
                                     ),

                                     Container(
                                         width: 50,
                                         height: 50,
                                         child:
                                         CircularPercentIndicator(
                                           radius: 20.0,
                                           lineWidth: 2.0,
                                           animation: true,

                                           percent:double.parse("${subcat.subcatpro?.data.books[i].attempted}")/10,
                                           center: Text("${subcat.subcatpro?.data.books[i].attempted}",style: TextStyle(
                                               color: Colors.black
                                           ),),
                                           progressColor: i==0?Colors.orangeAccent:Color.fromRGBO(52, 177, 231, 1),
                                         )
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),

                         Column(
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.stretch,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                                   child: TextWidget(
                                     text: "${subcat.subcatpro?.data.books[i].bookName ?? ''}",
                                     size: text_size_18,
                                   ),
                                 ),
                               ],
                             ),
                             Align(
                               alignment: FractionalOffset.bottomCenter,
                               child: Card(

                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(50.0),

                                 ),
                                 child: Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08,vertical: 8.0),
                                   child: TextWidget(
                                     text: 'Tests : ${subcat.subcatpro?.data.books[i].tests}',
                                     size: text_size_16,
                                     color: Colors.grey.shade600,
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 );
               })
             ],
           ),
          )),
    );
  }
}
