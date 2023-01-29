import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/screen/login.dart';
import 'package:sahem/shared/compont.dart';


class EmployeeProfile extends StatelessWidget {
  const EmployeeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state){
          var cubit=AppCubit.get(context);
          cubit.getDateProfile();
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                elevation: 0.0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 80),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const CircleAvatar(
                                    backgroundImage: AssetImage("assets/images/profile.png"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(cubit.userDate==null?'':cubit.userDate!.name,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Saudi Arabia",
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.location_on_sharp,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                //Text(cubit.userDate!.number),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(cubit.userDate==null?'':cubit.userDate!.identityNumber),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                 // height: 130,
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            spreadRadius: 0.3,
                                            offset: Offset(1, 1))
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: const [
                                          Text(
                                            "تعديل الصفحه الشخصيه",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.my_library_books_sharp,
                                            size: 26,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              FlutterSwitch(
                                                  width: 60,
                                                  height: 35,
                                                  toggleSize: 20,
                                                  activeColor:
                                                  const Color.fromARGB(255, 164, 210, 168),
                                                  toggleColor: Colors.white,
                                                  borderRadius: 30,
                                                  padding: 8,
                                                  onToggle: (val) {

                                                  },
                                                  value: false

                                                //  onChanged: (value){},
                                              )
                                            ],
                                          ),
                                          Row(children: const [
                                            Text(
                                              "الاشعارات",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              Icons.notifications_none_rounded,
                                              size: 28,
                                            ),
                                          ])
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  padding:
                                  const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            spreadRadius: 0.3,
                                            offset: Offset(1, 1))
                                      ]),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  title: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: const [
                                                      Padding(
                                                        padding:  EdgeInsets.all(8.0),
                                                        child: Text('تسجيل الخروج'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.logout),
                                                      ),
                                                    ],
                                                  ),
                                                  content: const Text('هل تريد تسجيل الخروج',
                                                  textAlign: TextAlign.end),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('لا')),
                                                    TextButton(
                                                        onPressed: (){
                                                          cubit.signOut();
                                                        },
                                                        child: const Text(
                                                          'نعم',
                                                          style: TextStyle(color: Colors.red),
                                                        ))
                                                  ],
                                                );
                                              });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: const [
                                            Text("تسجيل الخروج",
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              Icons.logout_rounded,
                                              size: 28,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])),
              ),
            ),
          );
        },
        listener: (context, state){
          if(state is SignOutState){
            navigatorOff(context: context, widget: LoginScreen());
          }

        });
  }
}
