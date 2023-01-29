
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sahem/screen/empoly/report/report_screen_one.dart';
import 'package:sahem/screen/empoly/report/test.dart';
import 'package:sahem/screen/reports_screen.dart';
import 'package:sahem/shared/compont.dart';

class ReportsDrafts extends StatelessWidget {
  const ReportsDrafts({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
       textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text(" تقاريري",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
            elevation: 0,
            leading:IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded))
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  if(Platform.isIOS){
                    navigatorTo(context: context, widget: const ReportScreenOneIOS());
                  }else{
                    navigatorTo(context: context, widget: const ReportScreenOne());
                  }

                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF229867).withOpacity(0.13),
                          const Color(0xFF229867).withOpacity(0.13),
                          const Color(0xFF229867).withOpacity(0.19),
                        ]),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 70,
                          width: 70,
                          child: Icon(Icons.add_circle_outline,
                            color: Colors.green,size: 80,)),
                    ),
                  ),
                ),
              ),
              const Divider(),
              const  Expanded(child: ReportsScreen(isMohref: false,)),
            ],
          ),
        ),
      ),
    );
  }
}
