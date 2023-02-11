
import 'package:TESTED/aa_QuestionScreen/my_account_paage.dart';
import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:TESTED/common_widgets/loader.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/ApiProviders.dart';
class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
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
      await  Provider.of<CategoryProvider>(context,listen: false).getleaderboard(header: '$thetoken');
    });
  }
  @override
  Widget build(BuildContext context) {
    final postmodel=Provider.of<CategoryProvider>(context);
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(

          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: new Icon(Icons.menu_sharp, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyAccountPage()
                          )
                      );

                    },
                  ),
                  Text('Leaderboard',style: TextStyle(color: Colors.black87,fontSize: 18),),
                  IconButton(
                    icon: new Icon(Icons.notifications_active_outlined, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: size.height*0.025,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width*0.33,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: (){
                              setState((){

                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              //color: Colors.white,
                              width: MediaQuery.of(context).size.width*0.30,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color:Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0,3)
                                    )
                                  ]
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage('https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('Nidhi Gupta',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('2254 pts',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Level 10',
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13
                                    ),
                                  ),
                                  SizedBox(height: 8)


                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.topRight,
                            child: DottedBorder(

                              color: Colors.grey.shade600,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(50),
                              padding: EdgeInsets.all(0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.circle,
                                    color: Colors.grey,

                                  ),
                                  child: Text('2'),
                                ),
                              ),
                            )
                        )

                      ],
                    ),
                  ),
                  Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width*0.33,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: (){
                              setState((){

                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              //color: Colors.white,
                              width: MediaQuery.of(context).size.width*0.30,
                              height: 220,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white ,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0,3)
                                    )
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: 20),
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage('https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('Nitin Rai',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('2254 pts',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Level 10',
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13
                                    ),
                                  ),
                                  SizedBox(height: 8)


                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.topRight,
                            child: DottedBorder(
                              color: Colors.grey.shade600,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(50),
                              padding: EdgeInsets.all(0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.circle,
                                    color: Colors.orange,

                                  ),
                                  child: Text('1'),
                                ),
                              ),
                            )
                        )

                      ],
                    ),
                  ),
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width*0.33,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: (){
                              setState((){

                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              //color: Colors.white,
                              width: MediaQuery.of(context).size.width*0.30,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color:Colors.white ,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0,3)
                                    )
                                  ]
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage('https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('Anurag',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('2254 pts',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Level 10',
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13
                                    ),
                                  ),
                                  SizedBox(height: 8)

                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.topRight,
                            child: DottedBorder(
                              color: Colors.orangeAccent,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(50),
                              padding: EdgeInsets.all(0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.circle,
                                    color: Colors.orangeAccent.withOpacity(0.4),

                                  ),
                                  child: Text('3'),
                                ),
                              ),
                            )
                        )

                      ],
                    ),
                  )

                ],
              ),
              SizedBox(
                height: size.height*0.03,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width*0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   Text('Popular'.toUpperCase(),style: TextStyle(
                     fontSize:16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                     color: Colors.black
                   ),),
                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                width: size.width*0.95,
                height: size.height*0.05,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CustomText(14, FontWeight.bold, Colors.white, 'Rank'),
                    ),
                    SizedBox(
                      width: size.width*0.12,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: CustomText(14, FontWeight.bold, Colors.white, 'User')
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: CustomText(14, FontWeight.bold, Colors.white, 'Points'),
                            ),
                          ],
                        )
                    ),

                  ],
                ),
              ),
          SizedBox(
            height: size.height*0.02,
          ),
          Expanded(
              child: ListView.builder(
              itemCount: postmodel.leaderboardmodel?.result?.length,
              itemBuilder: (ctx,i){
                   return    postmodel.isLoading==true ? Center(
                     child: Loader(),
                   ) : Card(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: ListTile(
                    leading: CustomText(16,FontWeight.w600,Colors.blue,postmodel.leaderboardmodel?.result?[i]?.rank==null?"":"${postmodel.leaderboardmodel?.result?[i]?.rank}"),
                    title: Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        postmodel.leaderboardmodel?.result?[i]?.image==null?SizedBox(): CircleAvatar(
                            backgroundColor: Colors.transparent,

                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.network("${postmodel.leaderboardmodel?.result?[i]?.image}",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,),
                            )),

                        SizedBox(
                          width: size.width*0.02,
                        ),
                        Flexible(child: CustomText(14,FontWeight.normal,Colors.black,
                            postmodel.leaderboardmodel?.result?[i]?.name==null?"":'${postmodel.leaderboardmodel?.result?[i]?.name}')),
                      ],
                    ),

                    trailing: CustomText(16,FontWeight.w600,Colors.black,
                        postmodel.leaderboardmodel?.result?[i]?.points==null?"":"${postmodel.leaderboardmodel?.result?[i]?.points}".toUpperCase()),
                  ),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }

}
