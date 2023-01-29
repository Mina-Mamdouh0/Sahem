
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/modal/report_model.dart';
import 'package:sahem/screen/empoly/report/report_screen_three.dart';
import 'package:sahem/shared/compont.dart';

class ReportScreenTwo extends StatelessWidget {
  final String lat;
  final String lng;
  final String address;
  final String createdAt;
  ReportScreenTwo(
      {super.key,
      required this.createdAt,
      required this.address,
      required this.lat,
      required this.lng});

  String? mosque;


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
                    leading:IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded))
                ),
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.green,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 50,),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                                children: [
                              steps(true, true, false),
                              const SizedBox(
                                height: 10,
                              ),
                              (state is LoadingGetMosques && cubit.mosquesName.isEmpty)?
                            const CircularProgressIndicator():
                            DropdownButtonFormField(
                              isExpanded: true,
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                ),
                                enabledBorder:OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                ) ,

                              ),
                              items: [
                                ...cubit.mosquesName.map((e) {
                                  return DropdownMenuItem(
                                    onTap: (){
                                    },
                                    value: e,
                                    child: Text(e,
                                      style:  const TextStyle(fontWeight: FontWeight.bold),),
                                  );
                                }),
                              ],
                              value: mosque,
                              onChanged: (val){
                                mosque=val.toString();
                                cubit.getDateMosque(mosqueName: mosque!);
                              }
                            ),
                              (state is LoadingGetDataMosque)?
                              const CircularProgressIndicator():
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  showDate(name: 'الــمــؤذن', date: cubit.mosqueDate==null?'':cubit.mosqueDate!.moazin),
                                  showDate(name: 'رقـــم الــجــوال الــمــؤذن',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.moazin_phone),
                                  showDate(name: 'الإمـــام',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.imam),
                                  showDate(name: 'رقـــم الــجــوال الإمـــام',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.imam_phone),
                                  showDate(name: 'الـــخــطـيـب',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.kahteeb),
                                  showDate(name: 'رقـــم الــجــوال الـــخــطـيـب',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.kahteeb_phone),
                                  showDate(name: 'الـــخادم',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.servant_name),
                                  showDate(name: 'رقـــم الــجــوال الـــخادم',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.servant_number),
                                  showDate(name: 'الحي',date:cubit.mosqueDate==null?'':cubit.mosqueDate!.neighborhood_name),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  if (cubit.mosqueDate!=null&&mosque!=null) {
                                    navigatorTo(context: context, widget: ReportScreenThree(
                                      address: address,
                                      createdAt: createdAt,
                                      lat: lat,
                                      lng: lng,
                                      mosqueDate: cubit.mosqueDate!,
                                    ));
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: const BoxConstraints(maxHeight: 50, maxWidth: 320),
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
                                    "الـــتــــالي ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
          );
        },
        listener: (context, state){});
  }

}
