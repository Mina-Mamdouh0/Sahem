
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/constant.dart';
import 'package:sahem/modal/report_model.dart';
import 'package:sahem/modal/task_model.dart';
import 'package:sahem/modal/user_model.dart';
import 'package:sahem/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState()) ;
  static AppCubit get(context) => BlocProvider.of(context);
  //nav bar
  int currentIndex=0;
  void changeScreen(int index){
    currentIndex=index;
    emit(ChangeScreenState());
  }
  bool obscureText=true;
  void visiblePassword(){
    obscureText=!obscureText;
    emit(VisiblePasswordLogin());
  }

  UserModel?userModel;

  void login({required String identityNumber, required String password,}) async {
    emit(LoadingLoginState());
     await Api.post(url: Constant.apiAuth,
        body: json.encode({
          'user-login': identityNumber,
          'password-login': password,
        })
    ).then((value)async{
      userModel=UserModel.fromJson(value);
      SharedPreferences preferences=await SharedPreferences.getInstance();
      preferences.setString('token', userModel!.token);
      preferences.setString('typeAccount', userModel!.accountType);
      emit(SuccessLoginState());
    }).onError((error, stackTrace) {
      emit(ErrorLoginState(error: error.toString()));
    });
  }

  UserDate? userDate;
  void getDateProfile()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null){
      emit(LoadingGetUserDate());
      await Api.post(url: Constant.apiDateProfile,
          body:json.encode({'token': preferences.getString('token').toString()})
      ).then((value){
        userDate=UserDate.fromJson(value['data']);
        emit(SuccessGetUserDate());
      }).onError((error, stackTrace){
        emit(ErrorGetUserDate(
            error: error.toString()
        ));
      });
    }
  }

  List empName=[];
  void getEmpTasks()async{
    empName=[];
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null
        && preferences.getString('typeAccount')=='moshrif' ){
      emit(LoadingGetEmpDate());
      await Api.post(url: Constant.apiEmpTask,
          body:json.encode({'token': preferences.getString('token').toString()})
      ).then((value){
        empName.addAll(value['data']);
        emit(SuccessGetEmpDate());
      }).onError((error, stackTrace){
        emit(ErrorGetEmpDate(
            error: error.toString()
        ));
      });
    }
  }

  void postTasks({required String to, required String subject, required String nameSubject,
  required String date, required String massage,
})async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null
        && preferences.getString('typeAccount')=='moshrif' ){
      emit(LoadingPostTask());
      await Api.post(url: Constant.apiPostTask,
          body:json.encode({
            'token': preferences.getString('token').toString(),
            "to":to,
            "subject":subject,
            "nameSubject":nameSubject,
            "date":date,
          'massage':massage})
      ).then((value){
        if(value['status'].toString()=='success'){
          emit(SuccessPostTask());
        }
      }).onError((error, stackTrace){
        emit(ErrorPostTask(
            error: error.toString()
        ));
      });
    }
  }

List<TaskModel> tasksList=[];
  void getTasks()async{
    tasksList=[];
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null){
      emit(LoadingGetTask());
      await Api.post(url: Constant.apiGetTask,
          body:json.encode({'token': preferences.getString('token').toString()})
      ).then((value){
        List list=value['data'];
        for(int i=0;i<list.length;i++){
          tasksList.add(TaskModel.fromJson(value['data'][i]));
        }
        emit(SuccessGetTask());
      }).onError((error, stackTrace){
        emit(ErrorGetTask(error: error.toString()));
      });
    }
  }


  List mosquesName=[];
  void getMosques()async{
    mosquesName=[];
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null && preferences.getString('typeAccount')=='moraqib' ){
      emit(LoadingGetMosques());
      await Api.post(url: Constant.apiGetMosques,
          body:json.encode({'token': preferences.getString('token').toString()})
      ).then((value){
        mosquesName.addAll(value['data']);
        emit(SuccessGetMosques());
      }).onError((error, stackTrace){
        emit(ErrorGetMosques(
            error: error.toString()
        ));
      });
    }
  }

  MosqueDate? mosqueDate;
  void getDateMosque({required String mosqueName})async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null && preferences.getString('typeAccount')=='moraqib' ){
      emit(LoadingGetDataMosque());
      await Api.post(url: Constant.apiGetDataMosque,
          body:json.encode({
            'token': preferences.getString('token').toString(),
            "mosque_name":mosqueName
          })
      ).then((value){
        mosqueDate=MosqueDate.fromJson(value['data']);
        emit(SuccessGetDataMosque());
      }).onError((error, stackTrace){
        emit(ErrorGetDataMosque(
            error: error.toString()
        ));
      });
    }
  }



  void postReport({
    String? imageOne,//base 64
    String? imageTwo,
    String? imageThree,
    String? imageOneName,//name
    String? imageTwoName,
    String? imageThreeName,
    required String lat,
    required String lng,
    required String mosque_id,
    required String nameReport,
    required String address,
    required String createdAt,
    required String name,
    required String muezzinName,
    required String muezzinPhone,
    required String imamName,
    required String imamPhone,
    required String oratorName,
    required String oratorPhone,
    required String servantName,
    required String servantPhone,
    required String neighborhood,
    required String presence,
    required String najdReading,
    required String oratorPresence,
    required String oratorCommitment,
    required String externalAmplifiers,
    required String internalAmplifiers,
    required String levelOfCleanliness,
    required String otherNodes,
    required String publisherName,
    required String publisherPhone,
    required String khotba,
    required String hijri_date,

  })async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null && preferences.getString('typeAccount')=='moraqib' ){
      emit(LoadingPostReport());
      await Api.post(url:Constant.apiPostReport,
          body:json.encode({
          "token": preferences.getString('token').toString(),
          "lat": lat,
          "lng": lng,
          "mosque_id": mosque_id,
          "nameReport":nameReport,
          "address": address,
          "createdAt": createdAt,
          "name": name,
          "muezzinName": muezzinName,
          "muezzinPhone": muezzinPhone,
          "imamName": imamName,
          "imamPhone": imamPhone,
          "oratorName": oratorName,
          "oratorPhone": oratorPhone,
          "servantName": servantName,
          "servantPhone": servantPhone,
          "neighborhood": neighborhood,
          "presence": presence,
          "najdReading": najdReading,
          "oratorPresence": oratorPresence,
          "oratorCommitment": oratorCommitment,
          "external_amplifiers": externalAmplifiers,
          "internal_amplifiers": internalAmplifiers,
          "levelOfCleanliness": levelOfCleanliness,
          "otherNodes": otherNodes,
          "publisherName": publisherName,
          "publisherPhone": publisherPhone,
          "publishedDate": DateTime.now().toString(),
            "imageOne":imageOne,
            "imageTwo":imageTwo,
            "imageThree":imageThree,
            "imageOneName":imageOneName,
            "imageTwoName":imageTwoName,
            "imageThreeName":imageThreeName,
          })

      ).then((value){
        if(value['status'].toString()=='success'){
          emit(SuccessPostReport());
        }else if(value['status'].toString()=='error'){
          emit(ErrorPostReportState());
        }
      }).onError((error, stackTrace){
        emit(ErrorPostReport(error: error.toString()));
        print(error.toString());
      });
    }
  }

  List<ReportModel> reportsList=[];
  void getReports()async{
    reportsList=[];
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null){
      emit(LoadingGetReport());
      await Api.post(url: Constant.apiGetReports,
          body:json.encode({'token': preferences.getString('token').toString()})
      ).then((value){
        List list=value['data'];
        for(int i=0;i<list.length;i++){
          reportsList.add(ReportModel.fromJson(value['data'][i]));
        }
        emit(SuccessGetReport());
      }).onError((error, stackTrace){
        emit(ErrorGetReport(error: error.toString()));
      });
    }
  }



  void postRate({required String reportId, required String message, required String rating,})
  async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString('token')!=null
        && preferences.getString('typeAccount')=='moshrif' ){
      emit(LoadingPostRate());
      await Api.post(url: Constant.apiPostRate,
          body:json.encode({
            'token': preferences.getString('token').toString(),
            "report_id":reportId,
            "message":message,
            "rating":rating})
      ).then((value){
        print(value.toString());
        if(value['status'].toString()=='error'){
          emit(ErrorPostRate(error: 'moshrif cannot post a report'));
        }
        if(value['status'].toString()=='success'){
          emit(SuccessPostRate());
        }
      }).onError((error, stackTrace){
        emit(ErrorPostRate(
            error: error.toString()
        ));
      });
    }
  }

  double rate=0.0;
  void addRate(double r){
    rate=r;
    emit(AddRate());
  }

  void signOut()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    userDate=null;
    userModel=null;
    preferences.remove('token');
    preferences.remove('typeAccount');
    emit(SignOutState());
  }

  File? file1;
  File? file2;
  File? file3;
  String? base641;
  String? base642;
  String? base643;
  String? imagePath1;
  String? imagePath2;
  String? imagePath3;
  void changeImage1(String imagePath){
    file1=File(imagePath);
    if(file1!=null){
      base641=base64Encode(file1!.readAsBytesSync());
      imagePath1=file1!.path.split('/').last;
      print(base641);
      print(imagePath1);
      emit(ChangeImage1());
    }

  }
  void changeImage2(String imagePath){
    file2=File(imagePath);
    if(file2!=null){
      base642=base64Encode(file2!.readAsBytesSync());
      imagePath2=file2!.path.split('/').last;
      emit(ChangeImage2());
    }

  }
  void changeImage3(String imagePath){
    file3=File(imagePath);
    if(file3!=null){
      base643=base64Encode(file3!.readAsBytesSync());
      imagePath3=file3!.path.split('/').last;
      emit(ChangeImage3());
    }

  }






}