import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../Services/ApiCallServices.dart';
import '../model/Categorymodel.dart';
import '../model/CoinHistorymodel.dart';
import '../model/Enrolledmodel.dart';
import '../model/InsideSubCategorymodel.dart';
import '../model/NewUpdateprofilemodel.dart';
import '../model/Profilemodel.dart';
import '../model/Questionmodel.dart';
import '../model/Scorescreenmodel.dart';
import '../model/Subcategorymodel.dart';
import '../model/leaderboardmodel.dart';



class CategoryProvider extends ChangeNotifier{

  bool isLoading=false;

  SubCategorymodel? subcatpro;
  InsideSubCategorymodel? insideSubCategorymodel;
  Questionmodel? questionmodel;
  Categorymodel? categorymodel;
  Profilemodel? profilemodel;
  NewUpdateprofilemodel? updateprofilemodel;
  Scorescreenmodel? scorescreenmodel;
  CoinHistorymodel? coinHistorymodel;
  Leaderboardmodel? leaderboardmodel;
  bool status=true;
  Enrolledmodel? enrolledmodel;


  getcat({required String header})async{
    var result = await Connectivity().checkConnectivity();
    if(result== ConnectivityResult.mobile || result ==  ConnectivityResult.wifi) {
      status=true;
      isLoading = true;
      categorymodel = (await getapicate(header: '$header'))!;
      isLoading = false;
      notifyListeners();
    }else if(result == ConnectivityResult.none){
      status=false;
      notifyListeners();
    }
    }




  getsubcategory(String id,String header) async{
    isLoading=true;
    subcatpro=(await getsubcat("$id", header: '$header'))!;
    isLoading=false;
    notifyListeners();
  }

  getinsidesubcat(String idd,{required String header})async{
    isLoading=true;
    insideSubCategorymodel=(await getserviceinsidesubcat("$idd",header: header))!;
    isLoading=false;
    notifyListeners();
  }

  providerprofilemodel({required String header})async{
  isLoading=true;
  profilemodel=(await apiprofilemodel(header: '$header'))!;
  isLoading=false;
  notifyListeners();
  }

  updateprofile({required String header,required String name,required String phone
    ,required String email,required String password,required String dob})async{
    isLoading=true;
    updateprofilemodel=(await updatingprofile(header: '$header',email: email,password: password,phone: phone,dob: dob,name: name))!;
    isLoading=false;
    notifyListeners();
  }

  getscorescreen({required String header,required String query})async{
    isLoading=true;
    scorescreenmodel=(await apiscorescreenmodel(header: '$header', query: '$query'))!;
    isLoading=false;
    notifyListeners();
  }

  getcoinhistory({required String header})async{
    isLoading=true;
    coinHistorymodel=(await apicoinhistorymodel(header: header))!;
    isLoading=false;
    notifyListeners();
  }

  getleaderboard({required String header})async{
    isLoading=true;
    leaderboardmodel=(await apileaderboard(header: header))!;
    isLoading=false;
    notifyListeners();
  }
  getenrolled({required String header,required String testtype , required String testid})async{
    isLoading=true;
    enrolledmodel=(await enrolledapi(header: header, testtype: '$testtype', testid: '$testid'))!;
    isLoading=false;
    notifyListeners();
  }

}