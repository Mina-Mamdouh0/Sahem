
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahem/screen/login.dart';
import 'package:sahem/shared/compont.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreens extends StatefulWidget {
   const IntroductionScreens({super.key});

  @override
  State<IntroductionScreens> createState() => _IntroductionScreensState();
}

class _IntroductionScreensState extends State<IntroductionScreens> {
  final PageController controller = PageController();
  bool isLast=false;

  List<String> modelOnBoarding=[
    'assets/images/introscreen/image1.jpeg',
    'assets/images/introscreen/image2.jpg',
  ];
  void goNextScreen()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    navigatorOff(context: context,widget:  LoginScreen());
    preferences.setBool('showIntro', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView.builder(
          controller: controller,
          onPageChanged:(index){
            if(index==modelOnBoarding.length-1){
              setState(() {
                isLast=true;
              });
            }else{
              setState(() {
                isLast=false;
              });
            }
          },
          itemCount: 2,
          itemBuilder: (context,index){
            return IntroShowScreen(index: index,);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.only(bottom: 90),
            child: SmoothPageIndicator(
              controller: controller,
              count: 2,
              effect: const WormEffect(
                spacing: 8.0,
                radius: 10.0,
                dotColor: Color(0XFFAACC77),
                activeDotColor: Color(0xFF229867),
              ),
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 25,
          child: TextButton(
            onPressed: (){
              goNextScreen();
            },
            child: const Text(
              "تخطي",
              style: TextStyle(
                  color: Color(0XFFAACC77),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: ElevatedButton(
                  onPressed: () {
    if(isLast){
      goNextScreen();
    }
    else{
    controller.nextPage(
    duration:const  Duration(milliseconds: 500),
    curve:Curves.easeInToLinear);
    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                    primary: Colors.transparent,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(maxHeight: 40, maxWidth: 200),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFC4D35F),
                              Color(0xFF578B37),
                              Color.fromARGB(255, 53, 109, 4),
                            ])),
                    child:  const Text(
                      "التالي",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )),
        Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/introscreen/right.png')),
        Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset('assets/images/introscreen/left.png')),
        Positioned(
            top: 50,
            left: 20,
            child: Image.asset('assets/images/sigel.png')),
      ],
    ));
  }
}
class IntroShowScreen extends StatelessWidget {
  final int index;
  const IntroShowScreen({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return (index==0)?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
             Text(
              "اهلا وسهلا بك \nفي ســــاهــم",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0XFFAC7532),
                  fontWeight: FontWeight.w900,
                  fontSize: 40),
            ),
            SizedBox(height: 20,),
            Text(
              "لـنـجــعلــهــا أفــضــل",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0XFFAC7532),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ):Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Image.asset(
          'assets/images/logo.png',

          fit: BoxFit.fill,
        ),
        const SizedBox(height: 10,),
        const Text(
          "لحماية بيوت اللَّه",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0XFFAC7532),
              fontWeight: FontWeight.w800,
              fontSize: 30),
        ),
        const SizedBox(height: 150,),
      ],
    );
  }
}
