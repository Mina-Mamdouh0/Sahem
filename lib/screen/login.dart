
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/screen/navbar.dart';
import 'package:sahem/shared/compont.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  TextEditingController identityNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state){
          var cubit=AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: fKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Image.asset('assets/images/logo.png',
                          fit: BoxFit.fill,),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "تـــســجـــيل الــدخـــول",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Color.fromARGB(255, 121, 76, 73),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (state is ErrorLoginState)?
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0XFF9E2626).withOpacity(0.35),
                             border: Border.all(
                                 color: const Color(0XFF9E2626)
                             )
                          ),
                          child: const Text('عذراً! اسم المستخدم أو كلمة المرور غير صحيحة.\nفضلاً تأكد من صحة المعلومات المدخلة.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          )),
                        ):Container(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text("اسم المــستخدم رقـــم الــهــوية ",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text("*",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TextFormField(
                          controller: identityNumberController ,
                          style: const TextStyle(color: Colors.grey),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الحقل مطلوب *";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintTextDirection: TextDirection.rtl,
                            fillColor: const Color.fromARGB(255, 236, 234, 234),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text("كلمه المرور",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text("*",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TextFormField(
                          controller: passwordController,
                          style: const TextStyle(color: Colors.grey),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الحقل مطلوب *";
                            }
                            return null;
                          },
                            obscureText: cubit.obscureText,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintTextDirection: TextDirection.ltr,
                            fillColor: const Color.fromARGB(255, 236, 234, 234),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: ()=>cubit.visiblePassword(),
                              icon: Icon(cubit.obscureText?Icons.visibility:Icons.visibility_off),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (state is ErrorLoginState)?
                           const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 10.0),
                                child:  Text('''
كلمة المرور لابد أن تحتوي على:
١/ حرف كبير واحد .
٢/ أحرف صغيرة.
٣/تحتوي على رموز مثل ( @ ، #  ،  ...).'''),
                              ),
                            ):Container(),
                        const SizedBox(
                          height: 30,
                        ),
                        (state is LoadingLoginState)?
                        const CircularProgressIndicator()
                        :GestureDetector(
                          onTap: () async {
                            if (fKey.currentState!.validate()) {
                              cubit.login(
                                  identityNumber: identityNumberController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            constraints:
                            const BoxConstraints(maxHeight: 40, maxWidth: 230),
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
                              "تـــســجـــيــل الـدخــول ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Image.asset('assets/images/frame.png')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state){
          if(state is SuccessLoginState){
            BlocProvider.of<AppCubit>(context).getDateProfile();
            BlocProvider.of<AppCubit>(context).getReports();
            BlocProvider.of<AppCubit>(context).getTasks();
            if(BlocProvider.of<AppCubit>(context).userModel!.accountType=='moshrif'){
              navigatorOff(context: context,widget:  NavBar(isSuper: true));
              BlocProvider.of<AppCubit>(context).getEmpTasks();
            }else{
              navigatorOff(context: context,widget:  NavBar(isSuper: false));
              BlocProvider.of<AppCubit>(context).getMosques();
            }


          }else if(state is ErrorLoginState){
            Fluttertoast.showToast(msg: 'تاكد من البيانات المدخله');
          }
        });
  }

}
