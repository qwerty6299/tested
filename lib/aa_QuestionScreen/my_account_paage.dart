import 'package:TESTED/aa_QuestionScreen/score_screen.dart';
import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:TESTED/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_module/tabbar_page.dart';
import '../provider/ApiProviders.dart';
import '../terms_condition.dart';
import 'leaderboard_class.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  Future removetoken()async{
    final  prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("token");
    setState(() {

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          LoginPage()), (Route<dynamic> route) => false);
    });
  }
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
      await  Provider.of<CategoryProvider>(context,listen: false).providerprofilemodel(header: '$thetoken');
    });
  }
  @override
  Widget build(BuildContext context) {
    final postmodel=Provider.of<CategoryProvider>(context);
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),
                      child: CustomText(18, FontWeight.bold, Colors.black, 'My Account'),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height*0.017 ,
                ),
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2)
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(52, 177, 231, 1),

                    child: Center(
                      child:  CustomText(16, FontWeight.bold, Colors.white,postmodel.profilemodel?.data.name==null?"": '${postmodel.profilemodel?.data.name[0]}'),
                    ),
                  ),
                  title: CustomText(14, FontWeight.bold, Colors.black,postmodel.profilemodel?.data.name==null?"": '${postmodel.profilemodel?.data.name}'),
                  subtitle: CustomText(12, FontWeight.normal, Colors.grey,postmodel.profilemodel?.data.phone ==null ?"":'+91 -${postmodel.profilemodel?.data.phone}'),
                ),
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                      color:   Colors.grey.withOpacity(0.2)
                  ),
                ),
                SizedBox(
                  height: size.height*0.017 ,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                   child: GestureDetector(
                     behavior: HitTestBehavior.opaque,
                     onTap: (){
                       Navigator.push(
                           context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                           create: (context) => CategoryProvider(),
                           child: BottomTabbarclass(selectedIndex: 2,))));
                     },
                     child: Row(
                        children: [
                          Image(image: AssetImage('images/account_profile.png'),fit: BoxFit.cover),
                          SizedBox(
                            width: size.width*0.05,
                          ),
                          CustomText(14, FontWeight.normal, Colors.black, 'Profile'),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios,size: 20,)
                              ],
                            ),
                          )
                        ],
                      ),
                   )
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                        child: Row(
                          children: [
                            Image(image: AssetImage('images/account_scoreboard.png'),fit: BoxFit.cover),
                            SizedBox(
                              width: size.width*0.05,
                            ),
                            CustomText(14, FontWeight.normal, Colors.black, 'My Scoreboard'),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios,size: 20,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,

                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                            create: (context) => CategoryProvider(),
                            child: BottomTabbarclass(selectedIndex: 1,))));
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                          child: Row(
                            children: [
                              Image(image: AssetImage('images/account_leaderdashboard.png'),fit: BoxFit.cover),
                              SizedBox(
                                width: size.width*0.05,
                              ),
                              CustomText(14, FontWeight.normal, Colors.black, 'Leader Dashboard'),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_forward_ios,size: 20,)
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                            create: (context) => CategoryProvider(),
                            child: TotalCoins())));

                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                          child: Row(
                            children: [
                              Image(image: AssetImage('images/accounts_aboutus.png'),fit: BoxFit.cover),
                              SizedBox(
                                width: size.width*0.05,
                              ),
                              CustomText(14, FontWeight.normal, Colors.black, 'Total coins'),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_forward_ios,size: 20,)
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                        child: Row(
                          children: [
                            Image(image: AssetImage('images/accounts_aboutus.png'),fit: BoxFit.cover),
                            SizedBox(
                              width: size.width*0.05,
                            ),
                            CustomText(14, FontWeight.normal, Colors.black, 'About Us'),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios,size: 20,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                            create: (context) => CategoryProvider(),
                            child: TermsAndCondition(checkURL: '',))));
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                          child: Row(
                            children: [
                              Image(image: AssetImage('images/accounts_terms_and_conditions.png'),fit: BoxFit.cover),
                              SizedBox(
                                width: size.width*0.05,
                              ),
                              CustomText(14, FontWeight.normal, Colors.black, 'Terms & Conditions'),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_forward_ios,size: 20,)
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                        child: Row(
                          children: [
                            Image(image: AssetImage('images/account-privacy.png'),fit: BoxFit.cover),
                            SizedBox(
                              width: size.width*0.05,
                            ),
                            CustomText(14, FontWeight.normal, Colors.black, 'Privacy Policy'),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios,size: 20,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0,top: 16.0),

                        child: Row(
                          children: [
                            Image(image: AssetImage('images/account_delete_account.png'),fit: BoxFit.cover),
                            SizedBox(
                              width: size.width*0.05,
                            ),
                            CustomText(14, FontWeight.normal, Colors.black, 'Delete Account'),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios,size: 20,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Divider(
                      height: 8,
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey,
                    ),






                  ],
                ),
                SizedBox(
                  height: size.height*0.017 ,
                ),
               Container(
                 margin: EdgeInsets.only(left: 12,right: 12,top: 16,bottom: 12),
                    decoration: BoxDecoration(
                      color:Color.fromRGBO(52, 177, 231, 1),

                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ExpandTapWidget(
                             tapPadding: EdgeInsets.only(
                               right: 200,
                               left: 200,
                               top: 20,
                               bottom: 20
                             ),
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                      // title: Text('Log out',style: TextStyle(
                                      //   fontWeight: FontWeight.bold,
                                      //   color: Colors.black,
                                      //   fontSize: 15
                                      // ),),
                                        content: Text('Do you really want to log out?'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('No')),
                                          TextButton(
                                            onPressed: ()async {
                                           await   removetoken();
                                            },
                                            child: Text('Yes'),
                                          )
                                        ],
                                      );
                                    });
                              },
                                child: CustomText(14, FontWeight.bold, Colors.white, 'Log Out')),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.logout,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
