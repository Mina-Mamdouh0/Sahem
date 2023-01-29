import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/screen/supervisor/super_create.dart';
import 'package:sahem/shared/compont.dart';

class SuperHome extends StatelessWidget {
  const SuperHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "الــرئـسيـة",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const Text(
                  "مـرحـباً بك في الدخول المــوحد لـساهم ",
                textAlign: TextAlign.center,
                  style:  TextStyle(color: Color(0XFFAC7532), fontSize: 20,fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showBox(
                      context: context,
                        icon: Icons.add_circle,
                        title: "جـــديــد",
                        onTap: () {
                          navigatorTo(context: context, widget: CreateTask());
                        },
                        color: const Color(0xffBCBCBC)),
                    SizedBox(
                      width:size.width * 0.09,
                    ),
                    showBox(
                      context: context,
                      icon: Icons.list_alt,
                      title: "الإسنادات",
                      onTap: () {
                        //BlocProvider.of<AppCubit>(context).currentIndex=1;
                        //navigatorOff(context: context, widget: const NavBar(isSuper: true));
                      },
                      color: const Color(0xffBCBCBC),
                    ),
                  ],
                ),
                SizedBox(
                  height:size.width * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showBox(
                      context: context,
                      icon: Icons.star_rate_rounded,
                      title: "مـــهـــم",
                      onTap: () {},
                      color: const Color(0xffF8B400),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showBox({required IconData icon, required String title, required Function() onTap,
      required Color color, required BuildContext context}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.39,
        width: MediaQuery.of(context).size.width * 0.39,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 242, 241, 241),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(4, 4))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: MediaQuery.of(context).size.width * 0.21,
              color: color,
              shadows: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(4, 4))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
