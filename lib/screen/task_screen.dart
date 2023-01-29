
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/shared/compont.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.ltr,
            child: (state is LoadingGetTask)?
            const Center(child: CircularProgressIndicator(),):
            (cubit.tasksList.isEmpty)?const Center(
              child: Text('لا يوجد بيانات متوفره',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25
                  )),
            ):ListView.builder(
              physics: const BouncingScrollPhysics(),
              primary: false,
              itemCount: cubit.tasksList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  navigatorTo(context: context,widget: ShowResultTask(
                    by: cubit.tasksList[index].from,
                    subject: cubit.tasksList[index].subject,
                    time: cubit.tasksList[index].date,
                    to: cubit.tasksList[index].to,
                  ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      margin: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(cubit.tasksList[index].nameSubject),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(cubit.tasksList[index].date,
                                style: const TextStyle(
                                    color: Colors.black38, fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.picture_as_pdf_rounded,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                    const Divider()
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){});
  }
}

class ShowResultTask extends StatelessWidget {
  final String to;
  final String by;
  final String time;
  final String subject;
  const ShowResultTask({Key? key, required this.to, required this.by, required this.time, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("المهام",style: TextStyle(
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
              icon: const Icon(Icons.arrow_back))
      ),
      body: Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Table(
                    border: TableBorder.all(color: Colors.black,width: 1),
                    columnWidths: const {
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),

                    },
                    children:  [
                      TableRow(
                          children: [
                            SizedBox(
                              height: 60,
                              child: Center(
                                child: Text(by,
                                    style: const TextStyle(fontSize: 16,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                              child: Center(
                                child: Text('بواسطه',
                                    style: TextStyle(fontSize: 18,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            SizedBox(
                              height: 60,
                              child: Center(
                                child: Text(time,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                              child: Center(
                                child: Text('الوقت',

                                    style: TextStyle(fontSize: 18,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            SizedBox(
                              height: 60,
                              child: Center(
                                child: Text(to,
                                    style: const TextStyle(fontSize: 16,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                              child: Center(
                                child: Text('الي',
                                    style: TextStyle(fontSize: 18,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                  showTheDate(name: 'الموضوع',date: subject)
                ]),
          )),
    );
  }

}