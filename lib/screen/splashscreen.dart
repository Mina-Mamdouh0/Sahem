
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sahem/screen/login.dart';
import 'package:sahem/screen/navbar.dart';
import 'package:sahem/shared/compont.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'introduction_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
            () async{
          SharedPreferences preferences=await SharedPreferences.getInstance();
          if(preferences.getBool('showIntro')??false){
            print(preferences.getString('token').toString());
            if(preferences.getString('token')==null || preferences.getString('typeAccount')==null) {
              navigatorOff(context: context, widget: LoginScreen());
            }else if(preferences.getString('typeAccount')=='moshrif'){
                navigatorOff(context: context, widget:  NavBar(isSuper: true));
              }else if(preferences.getString('typeAccount')=='moraqib'){
                navigatorOff(context: context, widget:  NavBar(isSuper: false));
              }else{
                navigatorOff(context: context, widget: LoginScreen());
              }
          }else{
            navigatorOff(context: context, widget: const IntroductionScreens());
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/images/logo.png',

                   fit: BoxFit.fill,
                ),
              ),
            ),
            const Spacer(flex: 3),
            const SizedBox(
              width: 300,
              child: Text(
                "﴿ إِنَّمَا يَعْمُرُ مَسَاجِدَ اللَّهِ مَنْ آمَنَ بِاللَّهِ وَالْيَوْمِ الْآخِرِ وَأَقَامَ الصَّلَاةَ وَآتَى الزَّكَاةَ وَلَمْ يَخْشَ إِلَّا اللَّهَ فَعَسَى أُولَئِكَ أَنْ يَكُونُوا مِنَ الْمُهْتَدِينَ ﴾",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0XFF3A652C),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 20,),
            Image.asset(
              'assets/images/otp.png',
              height: 100,
              width: 250,
            ),
            const Text(
              "وزارة الشؤون الإسلامية \nوالدعوة والإرشاد",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 35,)
          ],
        ),
      ),
          Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/introscreen/left.png')),
        ],
      ),
    );
  }
}
