
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/modal/report_model.dart';
import 'package:sahem/screen/navbar.dart';
import 'package:sahem/shared/compont.dart';

class PreviewReport extends StatelessWidget {
  final String lat;
  final String lng;
  final String address;
  final String createdAt;
  final String selectedIltazam;
  final String selectedAlqarah;
  final String selectedKhateebIltazam;
  final String oratorString;
  final String selectedExternalAmplifiers;
  final String selectedInternalAmplifiers;
  final String selectedmustawa;
  final String othersController;
  final String publisherName;
  final String publisherPhone;
  final String nameReport;
  final MosqueDate mosqueDate;
  final String subject;
  String? imageOne;//base 64
  String? imageTwo;
  String? imageThree;
  String? imageOneName;//name
  String? imageTwoName;
  String? imageThreeName;

  PreviewReport({super.key,
  this.imageOne,this.imageTwo,this.imageThree,
  this.imageOneName,this.imageTwoName,this.imageThreeName,
  required this.lat, required this.lng,
  required this.subject,
  required this.address, required this.createdAt,
  required this.mosqueDate, required this.selectedIltazam,
  required this.selectedAlqarah, required this.selectedKhateebIltazam,
  required this.oratorString, required this.selectedExternalAmplifiers,required this.selectedInternalAmplifiers, required this.selectedmustawa, required this.othersController, required this.publisherName, required this.publisherPhone, required this.nameReport, });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state){
          var cubit=AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  title: const Text(" تقاريري",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  centerTitle: true,
                  elevation: 1,
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text("زيــــــارة تـــــفــــقـــديـة ",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.green.shade900,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        showDate(name: 'اسم التقرير',date:nameReport ),
                        showDate(name: 'الموقع الحالي',date:address ),
                        showDate(name: 'التاريخ و الوقت',date:createdAt ),
                        showDate(name: 'اســـم المــسجد / الجامع',date: mosqueDate.mosque_name ),
                        showDate(name: 'الــمــؤذن',date:mosqueDate.moazin ),
                        showDate(name: 'رقـــم الــجــوال الــمــؤذن',date:mosqueDate.moazin_phone ),
                        showDate(name: 'الإمـــام',date:mosqueDate.imam),
                        showDate(name: 'رقـــم الــجــوال الإمـــام',date:mosqueDate.imam_phone),
                        showDate(name: 'الـــخــطـيـب',date:mosqueDate.kahteeb),
                        showDate(name: 'رقـــم الــجــوال الـــخــطـيـب',date:mosqueDate.kahteeb_phone),
                        showDate(name: 'الـــخادم',date:mosqueDate.servant_name),
                        showDate(name: 'رقـــم الــجــوال الـــخادم',date:mosqueDate.servant_number ),
                        showDate(name: 'التواجد',date:selectedIltazam ),
                        showDate(name: 'القراءة النجدية',date:selectedAlqarah ),
                  showDate(name: 'الـخـطـيـب  الإنـضباط / القراءة النجدية',date:selectedKhateebIltazam ),
                        showDate(name: 'الخطيب/ملتزم بموضوع الخطبة',date:oratorString ),
                        showDate(name: 'موضوع الخطبه',date:subject ),

                  showDate(name: 'الــمكبرات الدخليه',date:selectedInternalAmplifiers ),
                  showDate(name: 'الــمكبرات الخارجيه',date:selectedExternalAmplifiers ),
                  showDate(name: 'مستوى النظافة',date:selectedmustawa ),
                        showDate(name: 'أخـــرى',date:othersController ),

                        showDate(name: 'اســــم المــراقب  / الجهة',date:publisherName ),
                        showDate(name: 'رقم الــجوال',date:publisherPhone ),
                        const SizedBox(height: 10,),

                        (state is LoadingPostReport)?
                            const Center(child: CircularProgressIndicator(),):
                        InkWell(
                          onTap: ()  {
                            cubit.postReport(
                              hijri_date: '',
                              khotba: subject,
                              lat: lat.toString(),
                              lng: lng.toString(),
                              mosque_id: mosqueDate.id.toString(),
                              nameReport: nameReport.toString(),
                              address: address.toString(),
                              createdAt: createdAt.toString(),
                              name: mosqueDate.mosque_name.toString(),
                              muezzinName: mosqueDate.moazin.toString(),
                              muezzinPhone: mosqueDate.moazin_phone.toString(),
                              imamName: mosqueDate.imam.toString(),
                              imamPhone: mosqueDate.imam_phone.toString(),
                              oratorName: mosqueDate.kahteeb.toString(),
                              oratorPhone: mosqueDate.kahteeb_phone.toString(),
                              servantName:mosqueDate.servant_name.toString(),
                              servantPhone: mosqueDate.servant_number.toString(),
                              neighborhood: mosqueDate.neighborhood_name.toString(),
                              presence: selectedIltazam.toString(),
                              najdReading: selectedAlqarah.toString(),
                              oratorPresence: oratorString.toString(),
                              oratorCommitment: selectedKhateebIltazam.toString(),
                              internalAmplifiers: selectedInternalAmplifiers.toString(),
                              externalAmplifiers: selectedExternalAmplifiers.toString(),
                              levelOfCleanliness: selectedmustawa.toString(),
                              otherNodes: othersController.toString(),
                              publisherName:publisherName.toString(),
                              publisherPhone:publisherPhone.toString(),
                              imageOne: imageOne,
                              imageTwo: imageTwo,
                              imageThree: imageThree,
                              imageOneName: imageOneName,
                              imageTwoName: imageTwoName,
                              imageThreeName: imageThreeName
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(maxHeight: 50,),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFC4D35F),
                                      Color(0xFF578B37),
                                    ])),
                            child: const Text(
                              "الارسال",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap: ()  {
                            navigatorOff(context: context, widget:  NavBar(isSuper: false,));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(maxHeight: 50,),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFC4D35F),
                                      Color(0xFF578B37),
                                    ])),
                            child: const Text(
                              "انهاء",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                      ]),
                ),
              ),
            ),
          );
        },
        listener: (context, state){
          if(state is SuccessPostReport){

            showHandlingData(context: context,imagePath: 'checkCircle.png',
            msg: 'تــم الإرســال بــنــجاح',
            fct: (){
              navigatorOff(context: context, widget:  NavBar(isSuper: false,));
            });
            BlocProvider.of<AppCubit>(context).base641=null;
            BlocProvider.of<AppCubit>(context).base642=null;
            BlocProvider.of<AppCubit>(context).base643=null;
            BlocProvider.of<AppCubit>(context).imagePath1=null;
            BlocProvider.of<AppCubit>(context).imagePath2=null;
            BlocProvider.of<AppCubit>(context).imagePath3=null;
            BlocProvider.of<AppCubit>(context).file1=null;
            BlocProvider.of<AppCubit>(context).file2=null;
            BlocProvider.of<AppCubit>(context).file3=null;
            BlocProvider.of<AppCubit>(context).mosqueDate=null;
            BlocProvider.of<AppCubit>(context).getReports();
          }
          else if(state is ErrorPostReport){
            showHandlingData(context: context,imagePath: 'error.png',
                msg: 'تاكد من البانات المدخله حاول مره اخرى ',
                fct: (){
                  Navigator.pop(context);
                });
          }
          else if(state is ErrorPostReportState){
            showHandlingData(context: context,imagePath: 'error.png',
                msg: 'الموقع الحالي\n ليس متوافق مع موقع المسجد',
                fct: (){
                  Navigator.pop(context);
                });
          }
        });
  }


}
