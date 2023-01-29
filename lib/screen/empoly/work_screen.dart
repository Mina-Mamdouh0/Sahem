
import 'package:flutter/material.dart';
import 'package:sahem/screen/reports_screen.dart';
import 'package:sahem/screen/task_screen.dart';

class WorkScreen extends StatelessWidget {
  final bool isNavBar;
  const WorkScreen({super.key, required this.isNavBar});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("الــمهـــام",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              elevation: 1,
              leading: isNavBar?null:IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              bottom: const TabBar(
                  indicatorColor: Color.fromARGB(213, 72, 153, 69),
                  indicatorWeight: 5,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text(
                        " المهام  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                    Tab(
                        child: Text(
                          "تقاريري ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ))
                  ]),
            ),
            body: const TabBarView(
              children: [
                TaskScreen(),
                ReportsScreen(isMohref: false),
              ],
            ),
          ),
        ));
  }
}


