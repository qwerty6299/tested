import 'package:TESTED/aa_QuestionScreen/total_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/ApiProviders.dart';
import 'myscoretotal4.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String thetoken="";
  final fullnamecontroller = TextEditingController();
  final mobilenumbercontroller = TextEditingController();
  final emailaddresscontroller = TextEditingController();
  final dateofbirthcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final lastmobilecontroller = TextEditingController();
  ValueNotifier<bool> password = ValueNotifier(false);


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
     print("profile is build");
   final postmodel=Provider.of<CategoryProvider>(context);
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,),

                        Text('         ',),

                        Text('         ')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.05,
                  ),

                  Expanded(
                    child:Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))
                          ),

                        ),

                        Positioned.fill(
                          top: -50,
                          left: 0,

                          child:Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  )
                                ),

                                child:Stack(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 16.0),

                                      child:
                                      ClipRRect(

                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          topLeft: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                        child:postmodel.profilemodel?.data.image!=null?Image.network("${postmodel.profilemodel?.data.image}",fit: BoxFit.cover,):Container()


                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        showDialog( context: context,
                                            builder: (BuildContext context){
                                        return AlertDialog(
                                          titlePadding: const EdgeInsets.only(
                                              top: 0, left: 0, right: 12),
                                          contentPadding: const EdgeInsets.only(
                                              top: 0, left: 0, bottom: 20),
                                          insetPadding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          content: Container(
                                            decoration: const BoxDecoration(
                                                borderRadius: (BorderRadius.only(
                                                  topRight: Radius.circular(10.0),
                                                  topLeft: Radius.circular(10.0),
                                                  bottomLeft: Radius.circular(10.0),
                                                  bottomRight: Radius.circular(10.0),
                                                ))),
                                            height: 200,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  color: Color.fromRGBO(52, 177, 231, 1),
                                                  height: 55,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "Image",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 18),
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                          children: [
                                                            IconButton(onPressed: (){
                                                              Navigator.pop(context);
                                                            }, icon: Icon(Icons.close,size:20,color: Colors.white,)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Container(

                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {

                                                        },
                                                        child: Column(
                                                          children: [
                                                           Image(image: AssetImage('images/camera.png')),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Take Photo\n   ",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {

                                                        },
                                                        child: Column(
                                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Image(image: AssetImage('images/gallery.png'),),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Choose from\n       gallery ",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 14),
                                                            ),
                                                          ],
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
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.blueAccent),
                                                color:  Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20.0),
                                                  topLeft: Radius.circular(20.0),
                                                  bottomLeft: Radius.circular(20.0),
                                                  bottomRight: Radius.circular(20.0),
                                                )
                                            ),
                                            child: Icon(Icons.camera_alt,color: Colors.blueAccent,)),
                                      ),
                                    )
                                  ],
                                )

                              )
                          ),
                        ),
                        Positioned.fill(
                         bottom: -80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              abovename('Full name'),
                              SizedBox(
                                height: size.height*0.02,
                              ),


                                 buildtextfield(postmodel.profilemodel?.data.name!=null?"${postmodel.profilemodel?.data.name}":"",  TextInputType.name,false,fullnamecontroller),



                              SizedBox(
                                height: size.height*0.04,
                              ),
                             abovename('Mobile Number'),
                              SizedBox(
                                height: size.height*0.02,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: TextField(
                                  controller: lastmobilecontroller,

                                  cursorColor: Colors.grey,
                                  maxLines: 1,
                                  minLines: 1,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    //labelText: "Phone number",
                                      hintText:postmodel.profilemodel?.data.phone!=null? "${postmodel.profilemodel?.data.phone}":"",

                                      suffix: GestureDetector(
                                        onTap:(){
                                          showModalBottomSheet(
                                              context: context,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(25.0),

                                                ),
                                              ),

                                              builder: (context) {
                                                return AnimatedPadding(
                                                  padding: MediaQuery.of(context).viewInsets,
                                                  duration: const Duration(milliseconds: 100),
                                                  curve: Curves.decelerate,
                                                  child: SizedBox(
                                                    height: 200,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      mainAxisSize: MainAxisSize.min,
                                                      children:  <Widget>[
                                                        SizedBox(
                                                          height: size.height*0.03,
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.only(left: 25,right: 20,bottom: 22),
                                                            child: CustomText(16, FontWeight.w500, Colors.black, 'Enter New Mobile Number')),
                                                        buildtextfield("Enter New Mobile Number", TextInputType.phone, false,mobilenumbercontroller),
                                                        SizedBox(
                                                          height: size.height*0.03,
                                                        ),
                                                        InkWell(

                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 12,right: 12,top: 20),
                                                            decoration: BoxDecoration(
                                                              color: Colors.blue,

                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(14.0),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  CustomText(14, FontWeight.bold, Colors.white, 'Send OTP'),


                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child:Text("Change"),
                                      ),
                                      suffixStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14
                                      ),


                                      hintStyle: TextStyle(
                                          color: Colors.black
                                      ),
                                      contentPadding: EdgeInsets.all(5),   //  <- you can it to 0.0 for no space
                                      isDense: true,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black))
                                    //border: InputBorder.none
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: size.height*0.04,
                              ),
                             abovename('Email Address'),
                                SizedBox(
                                  height: size.height*0.02,
                                ),

                              buildtextfield(postmodel.profilemodel?.data.email==null?"":'${postmodel.profilemodel?.data.email}',  TextInputType.emailAddress,false,emailaddresscontroller),

                              SizedBox(
                                height: size.height*0.04,
                              ),
                              abovename('Password'),
                              SizedBox(
                                height: size.height*0.02,
                              ),
                              buildtextfield('******',  TextInputType.emailAddress,true,passwordcontroller),
                              SizedBox(
                                height: size.height*0.04,
                              ),
                              abovename('Date of Birth'),
                              SizedBox(
                                height: size.height*0.02,
                              ),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            child: TextField(
                              controller: dateofbirthcontroller,
                              onTap: ()async{
                                DateTime? pickeddate = await showDatePicker(context: context,
                                    initialDate: DateTime.now(), firstDate: DateTime(1980), lastDate: DateTime(2101));
                                if(pickeddate!=null){
                                  setState(() {
                                    dateofbirthcontroller.text=DateFormat('yyyy-MM-dd').format(pickeddate);
                                  });
                                }
                              },
                              //maxLength: 10,

                              cursorColor: Colors.grey,
                              maxLines: 1,
                              minLines: 1,

                              decoration: InputDecoration(
                                //labelText: "Phone number",




                                  suffixStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14
                                  ),


                                  hintStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  contentPadding: EdgeInsets.all(5),   //  <- you can it to 0.0 for no space
                                  isDense: true,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black))
                                //border: InputBorder.none
                              ),
                            ),
                          ),
                              SizedBox(
                                height: size.height*0.04,
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                width: size.width,
                                  child: ElevatedButton(onPressed: (){
                                    Provider.of<CategoryProvider>(context,listen: false).updateprofile(header: '$thetoken',
                                        name: '${fullnamecontroller.text.toString()}', phone: '${lastmobilecontroller.text.toString()}',
                                        email: '${emailaddresscontroller.text.toString()}', password: '${passwordcontroller.text.toString()}',
                                        dob: '${dateofbirthcontroller.text.toString()}');
                                  }, child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text('Save Changes'),
                                  )))



            ],

                          ),
                        )
                      ],
                    ),


                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget abovename(String name){
    return  Container(
      margin: EdgeInsets.only(left: 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(16, FontWeight.normal, Colors.grey, '$name'),
        ],
      ),
    );
  }
  Widget buildtextfield(String textfield,TextInputType textInputType,bool obsecure,TextEditingController controller){
 return
   Container(
  margin: EdgeInsets.only(left: 20,right: 20),
  child: TextField(
    controller: controller,
  //maxLength: 10,
    obscureText: obsecure,
  cursorColor: Colors.grey,
  maxLines: 1,
  minLines: 1,
  keyboardType: textInputType,
  decoration: InputDecoration(
  //labelText: "Phone number",
  hintText: '$textfield',
  


  suffixStyle: TextStyle(
    color: Colors.black,
    fontSize: 14
  ),


  hintStyle: TextStyle(
  color: Colors.black
  ),
  contentPadding: EdgeInsets.all(5),   //  <- you can it to 0.0 for no space
  isDense: true,
  enabledBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.grey)),
  focusedBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.black))
  //border: InputBorder.none
  ),
  ),
  );
}
}
