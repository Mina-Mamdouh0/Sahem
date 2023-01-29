
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/screen/navbar.dart';
import 'package:sahem/shared/compont.dart';

class CreateTask extends StatelessWidget {
  CreateTask({super.key});
  TextEditingController nameSubjectController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  String? to;

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
                  title: const Text(" انشاء",style: TextStyle(
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
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: fKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: const [
                              Icon(
                                Icons.close,
                                size: 30,
                              ),
                            ]),
                            Row(
                              children: [
                                (state is LoadingPostTask)?const Center(child: CircularProgressIndicator(),):Row(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          if(fKey.currentState!.validate()){
                                            if (to==null) {
                                              Fluttertoast.showToast(msg: 'تاكد من اكمال الحقول');
                                            }else{
                                              cubit.postTasks(to: to!,
                                                  subject: '',
                                                  nameSubject: nameSubjectController.text,
                                                  date: DateTime.now().toString(),
                                                  massage: msgController.text
                                              );
                                            }
                                          }
                                        },
                                        child: const RotatedBox(
                                            quarterTurns: 4, child: Icon(Icons.send))),
                                  ],
                                ),
                                const SizedBox(width: 5,),
                                InkWell(
                                  onTap: (){},
                                    child: Image.asset('assets/images/mail.png',))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (state is LoadingGetEmpDate && cubit.empName.isEmpty)?
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
                              ...cubit.empName.map((e) {
                                return DropdownMenuItem(
                                  onTap: (){
                                  },
                                  value: e,
                                  child: Text(e,
                                    style:  const TextStyle(fontWeight: FontWeight.bold),),
                                );
                              }),
                            ],
                            value: to,
                            onChanged: (val){
                              to=val.toString();
                            }
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        TextFormField(
                          controller: nameSubjectController,
                          decoration: const InputDecoration(
                            hintText: "اسم الموضوع",
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                        ),
                        TextFormField(
                          controller: msgController,
                          maxLines: 9,
                          decoration: const InputDecoration(
                            hintText: "اكتب رسالة",
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state){
          if(state is SuccessPostTask){
            showHandlingData(context: context,imagePath: 'checkCircle.png',
                msg: 'تــم الإرســال بــنــجاح',
                fct: (){
                  navigatorOff(context: context, widget:  NavBar(isSuper: true,));
                });
            BlocProvider.of<AppCubit>(context).getTasks();
          }else if(state is ErrorPostTask){
            Fluttertoast.showToast(msg: 'حاول في وقت لاحق');
            Navigator.pop(context);
          }
        });
  }


}
