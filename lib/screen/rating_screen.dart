
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/screen/navbar.dart';
import 'package:sahem/shared/compont.dart';

class RatingScreen extends StatelessWidget {
  final String reportId;
   RatingScreen({Key? key, required this.reportId}) : super(key: key);
   TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          print(reportId);
          var cubit=AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("التقيم",style: TextStyle(
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
                    icon: const Icon(Icons.arrow_back_ios_rounded)),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30,),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          cubit.addRate(rating);
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        maxLines: 6,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الحقل مطلوب';
                          } else {
                            return null;
                          }
                        },
                        controller: msgController,
                        style: const TextStyle(color: Colors.grey, fontSize: 18),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintTextDirection: TextDirection.rtl,
                          fillColor: const Color.fromARGB(255, 236, 234, 234),
                          filled: true,
                          hintText: 'اكتب رسالتك',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      (state is LoadingPostRate)?
                      const Center(child: CircularProgressIndicator(),):
                      InkWell(
                        onTap: ()  {
                          if(msgController.text.isNotEmpty){
                            cubit.postRate(
                                reportId: reportId,
                                message: msgController.text,
                                rating: cubit.rate.toString());
                          }else{
                            Fluttertoast.showToast(msg: 'ادخل الرساله');
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              maxHeight: 50, maxWidth: double.infinity),
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
                            "انشاء التقيم ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener:  (context,state){
          if(state is SuccessPostRate){
            showHandlingData(context: context,imagePath: 'checkCircle.png',
                msg: 'تــم الإرســال بــنــجاح',
                fct: (){
                  navigatorOff(context: context, widget:  NavBar(isSuper: true,));
                });
            BlocProvider.of<AppCubit>(context).rate=0.0;
            BlocProvider.of<AppCubit>(context).getReports();

          }else if(state is ErrorPostRate){
            showHandlingData(context: context,imagePath: 'error.png',
                msg: 'حاول مره اخري ',
                fct: (){
                  Navigator.pop(context);
                });
            BlocProvider.of<AppCubit>(context).rate=0.0;
          }
        });
  }
}
