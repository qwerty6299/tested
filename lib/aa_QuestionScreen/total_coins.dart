import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/ApiProviders.dart';
import 'leaderboard_class.dart';
import 'my_account_paage.dart';

class TotalCoins extends StatefulWidget {
  const TotalCoins({Key? key}) : super(key: key);

  @override
  State<TotalCoins> createState() => _TotalCoinsState();
}

class _TotalCoinsState extends State<TotalCoins> {
  String thetoken="";

  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
    String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the profile token is $thetoken");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken().whenComplete(() async{
      await  Provider.of<CategoryProvider>(context,listen: false).getcoinhistory(header: '$thetoken',);
    });
  }
  @override
  Widget build(BuildContext context) {
    final postmodel=Provider.of<CategoryProvider>(context);
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: (){
            Get.to(MyAccountPage());
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: size.height*0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                      Navigator.pop(context);
                      },
                      child:  Image(image: AssetImage('images/back_arrow.png'),width: 50,height: 20,),
                    ),

                    Text('Your Coins',style: TextStyle(color: Colors.black87,fontSize: 18),),
                    Text('            ',style: TextStyle(color: Colors.white),),


                  ],


                ),
                SizedBox(
                  height: size.height*0.025,
                ),
                Container(
                  width: size.width*0.9,
                  height: size.height*0.3,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(16, FontWeight.bold, Colors.white, "Total Coins"),
                      SizedBox(
                        height: size.height * 0.0002,
                      ),
                      CustomText(40, FontWeight.bold, Colors.white,postmodel.coinHistorymodel?.result?.balance==null?"":
                      "${postmodel.coinHistorymodel?.result?.balance}"),

                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.025,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(16, FontWeight.normal, Colors.black87, "Recent Activity"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.02,
                ),
                Expanded(child: ListView.builder(
                  itemCount: postmodel.coinHistorymodel?.result?.history?.length,

                    itemBuilder: (ctx,i){
                  return Card(
                    margin: EdgeInsets.only(left: 16,right: 16,bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: ListTile(
                      leading:postmodel.coinHistorymodel?.result?.history?[i]?.logo==null?Container(
                        height: 20,
                        width: 40,
                      ): Image.network("${postmodel.coinHistorymodel?.result?.history?[i]?.logo}"),
                      title: Text(postmodel.coinHistorymodel?.result?.history?[i]?.title==null?"":'${postmodel.coinHistorymodel?.result?.history?[i]?.title}'),
                      subtitle: Text(postmodel.coinHistorymodel?.result?.history?[i]?.subtitle==null?"":'${postmodel.coinHistorymodel?.result?.history?[i]?.subtitle}'),
                      trailing: Container(
                          height: 40, width: 40,
                        decoration: BoxDecoration(
                          color:postmodel.coinHistorymodel?.result?.history?[i]?.debit==true? Colors.red:Colors.green,
                          shape: BoxShape.circle
                        ),
                          child: Center(child:Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CustomText(14,FontWeight.w800,Colors.white,(postmodel.coinHistorymodel?.result?.history?[i]?.amount==null)?"":postmodel.coinHistorymodel?.result?.history?[i]?.debit==false?
                            "+ ${postmodel.coinHistorymodel?.result?.history?[i]?.amount}":"- ${postmodel.coinHistorymodel?.result?.history?[i]?.amount}"),
                          ))
                      ),
                    ),
                  );
                })
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  CustomText(this.fontSize, this.fontWeight, this.color, @required this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight
      ),

    );
  }
}