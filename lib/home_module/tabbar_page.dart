import 'dart:async';
import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:TESTED/about_us/about_us.dart';
import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:TESTED/common_widgets/font_size.dart';
import 'package:TESTED/common_widgets/globals.dart';
import 'package:http/http.dart'as http;
import 'package:TESTED/common_widgets/text_widget.dart';
import 'package:TESTED/home_module/delete_user_module/delete_model.dart';
import 'package:TESTED/home_module/home_mvp/homepage_model.dart';
import 'package:TESTED/home_module/subject_page.dart';
import 'package:TESTED/model/Categorymodel.dart';
import 'package:TESTED/provider/ApiProviders.dart';
import 'package:TESTED/soluton_module/solution_list.dart';
import 'package:TESTED/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../aa_QuestionScreen/ProfilePage.dart';
import '../aa_QuestionScreen/leaderboard_class.dart';
import '../aa_QuestionScreen/myscoretotal4.dart';
import '../terms_condition.dart';
import 'delete_user_module/delete_view.dart';
import 'home_mvp/homepage_view.dart';
import 'homepage_shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements HomepgeView, DeleteUserView {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  HomepageModel? _homePgResp;
  bool _isLoading = true;
  // ignore: prefer_typing_uninitialized_variables
  var noConnection;

  Widget _appBar({required String name, required String image}) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25.0),
    bottomRight: Radius.circular(25.0)),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        color: theme_color,
        child: Column(
          children: [
            SizedBox(
              height: 14,
            ),
            Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Text(name==null?"Hi, $name":"",style: TextStyle(
                          color: Colors.white,fontSize: 20
                        ),),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        radius: 25,//radius is 50
                        backgroundImage:NetworkImage(
                          '$image'),//image url
                      ),
                    ),

                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding:EdgeInsets.only(bottom: 24.0),
                      child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tests AND Evaluate",style: TextStyle(
                            color: Colors.white,fontSize: 30
                        ),),

                      ],
                    ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),

      ),
    );
  }







  bool  loaddata=false;


  List<Datum> dat=[];
  String thetoken="";

  Future gettoken()async{
    final preferences=await SharedPreferences.getInstance();
  String tok=   preferences.getString("token").toString();
    setState(() {
      thetoken=tok;
    });
    print("the token is $thetoken");
  }

  @override
  void initState() {


        gettoken().whenComplete(() async{
          await   Provider.of<CategoryProvider>(context,listen: false).getcat(header: '$thetoken');
          await   Provider.of<CategoryProvider>(context,listen: false).providerprofilemodel(header: '$thetoken');
        });
        super.initState();


  }

  Widget errmsg({required String text}){

      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [

          Container(
            margin: EdgeInsets.only(right:6.00),
            child: Icon(Icons.info, color: Colors.white),
          ),

          Text(text, style: TextStyle(color: Colors.white)),
          //show error message text
        ]),
      );
    }



  @override
  Widget build(BuildContext context) {
    final postmodel=Provider.of<CategoryProvider>(context);
    print("build");
    return SafeArea(
        child: Scaffold(
          drawerEnableOpenDragGesture: false,
          backgroundColor: milky_white,
          key: _key,

          body: WillPopScope(
              onWillPop: _onexit,
             child:postmodel.status==false?   Container(
               child: errmsg(text: "No Internet Connection Available"),
               //to show internet connection message on isoffline = true.
             ): postmodel.isLoading==true ? const HomePageShimmer() :Column(
               children: [
                 _appBar(name: '${postmodel.profilemodel?.data.name}', image: '${postmodel.profilemodel?.data.image}'??""),
                 Expanded(child:
                 StaggeredGridView.countBuilder(
                     shrinkWrap: true,
                     physics: BouncingScrollPhysics(),

                     staggeredTileBuilder: (int index)=>(index==0 ||index==3 || index==4 || index== 7
                         ? StaggeredTile.count(2, 2)
                         : StaggeredTile.count(2, 3)
                     ),
                     crossAxisCount: 4,

                     mainAxisSpacing: 8,
                     crossAxisSpacing: 8,

                     itemCount: postmodel.categorymodel?.data.length,
                     itemBuilder: (context, i) {
                       return GestureDetector(
                         onTap:
                             () {
                           postmodel.categorymodel!.data[i].blink==true?
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => ChangeNotifierProvider(
                                     create: (context) => CategoryProvider(),
                                     child: SubjectPage(
                                      id: postmodel.categorymodel!.data[i].id,
                                     ),
                                   )
                               )
                           ):null ;
                           },
                         child: Container(
                           height: 80,
                           margin: const EdgeInsets.all(10),
                           padding:
                           const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                           decoration: BoxDecoration(
                                   color:   postmodel.categorymodel!=null?( postmodel.categorymodel!.data[i].blink==false?Colors.grey.withOpacity(0.5):(i==0)? Colors.blue:(i==1)?Colors.blueAccent:(i==2)?Colors.orangeAccent:Colors.green):null,
                               border: Border.all(color: shadow_color, width: 0.5),
                               borderRadius: BorderRadius.circular(10)),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding:   EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                 child: TextWidget(
                                   text: '${postmodel.categorymodel?.data[i].name ?? ''}',
                                   size: text_size_18,color: Colors.white,
                                 ),
                               ),
                               Expanded(
                                 child: Padding(
                                   padding:   EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                     mainAxisAlignment:   i==0||i==3? MainAxisAlignment.end: MainAxisAlignment.center,
                                     children: [

                                       TextWidget(
                                         text: 'Subjects : ${postmodel.categorymodel?.data[i].subject ?? 0}',
                                         size: text_size_16,
                                         color: Colors.white,
                                       ),

                                       TextWidget(
                                         text: 'Tests : ${postmodel.categorymodel?.data[i].test ?? 0}',
                                         size: text_size_16,
                                         color: Colors.white,
                                       ),
                                     ],
                                   ),
                                 ),
                               ),


                             ],
                           ),
                         ),
                       );
                     }
                 ))
               ],
             )
             ),
        ));
  }

  // Future<bool> _willscope() async {
  //   return false;
  // }

  Future<bool> _onexit() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            height: 140,
            child: Column(
              children: <Widget>[
                TextWidget(
                  text: 'Are you sure you',
                  size: 18,
                  weight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: TextWidget(
                    text: 'want to exit?',
                    size: 18,
                    weight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  offset: const Offset(0.0, 5.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const TextWidget(
                              text: 'No',
                              size: 15,
                              color: Colors.white,
                              weight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  offset: const Offset(0.0, 5.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const TextWidget(
                              text: 'Yes',
                              size: 15,
                              color: Colors.white,
                              weight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _onDeleteAcc() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            height: 140,
            child: Column(
              children: <Widget>[
                TextWidget(
                  text: 'Are you sure you',
                  size: 18,
                  weight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: TextWidget(
                    text: 'want to Delete your account?',
                    size: 18,
                    weight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  offset: const Offset(0.0, 5.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const TextWidget(
                              text: 'No',
                              size: 15,
                              color: Colors.white,
                              weight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {

                          // SystemChannels.platform
                          //     .invokeMethod('SystemNavigator.pop');
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  offset: const Offset(0.0, 5.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const TextWidget(
                              text: 'Yes',
                              size: 15,
                              color: Colors.white,
                              weight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void homeErr(error) {
    print('Error = $error');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void homeResponse(HomepageModel _homepageModel) {
    print('HOME PG RESP = $_homepageModel');
    if (_homepageModel.status == true) {
      _homePgResp = _homepageModel;
      if (_homePgResp?.data?.user != null) {
        TestedGlobals.userContact = _homePgResp?.data?.user?.contact ?? '';
        TestedGlobals.userName = _homePgResp?.data?.user?.name ?? '';
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void deleteAccErr(error) {
    // TODO: implement deleteAccErr
    print('DELETE ACC -->  $error');
    Fluttertoast.showToast(
        msg: error ?? '',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: shadow_color,
        textColor: black_color,
        fontSize: 16.0);
  }

  @override
  Future<void> deleteAccResp(DeleteUserModel _deleteUserModel) async {
    // TODO: implement deleteAccResp
    print('delete Acc resp -- ${_deleteUserModel.toMap()}');
    if (_deleteUserModel.status == true) {
      Fluttertoast.showToast(
          msg: 'Your account is deleted successfully.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: black_color,
          fontSize: 16.0);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      TestedGlobals.userContact = '';
      TestedGlobals.userName = '';
      Navigator.pushNamedAndRemoveUntil(context, "/LoginPage", (r) => false);
    } else {
      Fluttertoast.showToast(
          msg: _deleteUserModel.message ?? '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: shadow_color,
          textColor: black_color,
          fontSize: 16.0);
    }
  }
}

class BottomTabbarclass extends StatefulWidget {
   int selectedIndex;
   BottomTabbarclass({Key? key,required this.selectedIndex}) : super(key: key);

  @override
  State<BottomTabbarclass> createState() => _BottomTabbarclassState();
}

class _BottomTabbarclassState extends State<BottomTabbarclass> {


  final List _children = [
    ChangeNotifierProvider(

        create: (BuildContext context) {
          CategoryProvider();
        },
        child: HomePage()),
    ChangeNotifierProvider(
        create: (BuildContext context) {
          CategoryProvider();
        },
        child: Leaderboard()),
    ChangeNotifierProvider(create: (BuildContext context) {
      CategoryProvider();
    },
    child: ProfilePage()),

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              widget.selectedIndex=index;
            });
          },
          currentIndex:   widget.selectedIndex,
          items: [
            new BottomNavigationBarItem(
              icon: Image.asset(
                'images/homedash.png',
                width: 15,
                height: 20,
              ),
              label: 'Home',
            ),
            new BottomNavigationBarItem(

              icon: Image.asset(
                'images/leaderdash.png',
                width: 15,
                height: 20,
              ),
              label: 'Leaderboard',
            ),
            new BottomNavigationBarItem(
              icon: Image.asset(
                'images/profiledash.png',
                width: 20,
                height: 20,
              ),
              label: 'Profile',
            )
          ]),
      body: _children[widget.selectedIndex],
    ));
  }
}

