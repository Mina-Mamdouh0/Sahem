
import 'package:flutter/material.dart';
import 'package:sahem/screen/reports_screen.dart';
import 'package:sahem/screen/task_screen.dart';

class SuperWork extends StatefulWidget {
  const SuperWork({super.key});

  @override
  State<SuperWork> createState() => _SuperWorkState();
}

class _SuperWorkState extends State<SuperWork> {
  @override
  Widget build(BuildContext context){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("مشرف",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              elevation: 1,
              bottom: const TabBar(
                  indicatorColor: Color.fromARGB(213, 72, 153, 69),
                  indicatorWeight: 5,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text(
                        "الـــجديد",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                    Tab(
                        child: Text(
                          "المرسل",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ))
                  ]),
            ),
            body: const TabBarView(children: [
              ReportsScreen(isMohref: true),
              TaskScreen(),
            ]),
          )),
    );
  }

}

