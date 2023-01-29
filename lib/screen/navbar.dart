import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/screen/profile_screen.dart';
import 'package:sahem/screen/empoly/emp_home_screen.dart';
import 'package:sahem/screen/empoly/work_screen.dart';
import 'package:sahem/screen/supervisor/super_home.dart';
import 'package:sahem/screen/supervisor/super_work.dart';

class NavBar extends StatelessWidget {
  final bool isSuper;
   NavBar({super.key, required this.isSuper,});



  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens=isSuper?const [
      SuperHome(),
      SuperWork(),
      EmployeeProfile(),
    ]:const [
      EmployeeHome(),
      WorkScreen(isNavBar: true),
      EmployeeProfile(),

    ];
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state){
          var cubit=AppCubit.get(context);
          //cubit.getDateProfile();
          return Scaffold(
            backgroundColor: Colors.white,
            body: buildScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: const Color.fromARGB(255, 21, 126, 25),
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.currentIndex,
              onTap: (val){
                cubit.changeScreen(val);
              },
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon:  Icon(Icons.home),
                  label:'الرئسيه' ,),
                BottomNavigationBarItem(
                  icon:  Icon(CupertinoIcons.briefcase),
                  label:'الاعمال' ,),
                BottomNavigationBarItem(
                  icon:  Icon(CupertinoIcons.person),
                  label:'الحساب' ,),

              ],
            ),
          );
        },
        listener: (context,state){

        });
  }
}


