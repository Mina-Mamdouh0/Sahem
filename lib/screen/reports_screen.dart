
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/screen/rating_screen.dart';
import 'package:sahem/shared/compont.dart';

class ReportsScreen extends StatelessWidget {
  final bool isMohref;
  const ReportsScreen({Key? key, required this.isMohref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state){
          var cubit=AppCubit.get(context);
          print(cubit.reportsList.length);
          return Directionality(
            textDirection: TextDirection.ltr,
            child: (state is LoadingGetReport)?
            const Center(child: CircularProgressIndicator(),):
            (cubit.reportsList.isEmpty)?const Center(
              child: Text('لا يوجد بيانات متوفره',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25
                  )),
            ):ListView.builder(
              physics: const BouncingScrollPhysics(),
              primary: false,
              itemCount: cubit.reportsList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  navigatorTo(context: context,widget: ShowResultReport(
                    isMohref: isMohref,
                    address: cubit.reportsList[index].address,
                    createdAt: cubit.reportsList[index].createdAt,
                    imamName: cubit.reportsList[index].imamName,
                    imamPhone: cubit.reportsList[index].imamPhone,
                    name: cubit.reportsList[index].nameReport,
                    oratorString: cubit.reportsList[index].oratorPresence,
                    iltazam: cubit.reportsList[index].presence,
                    alQarah: cubit.reportsList[index].najdReading,
                    khadimName: cubit.reportsList[index].servantName,
                    khadimPhone: cubit.reportsList[index].servantPhone,
                    khateebIltazam: cubit.reportsList[index].oratorCommitment,
                    khateebName: cubit.reportsList[index].oratorName,
                    khateebPhone: cubit.reportsList[index].oratorPhone,
                    moazinName: cubit.reportsList[index].muezzinName,
                    moazinPhone: cubit.reportsList[index].muezzinPhone,
                    publisherName: cubit.reportsList[index].publisherName,
                    publisherContact: cubit.reportsList[index].publisherName,
                    akhar: cubit.reportsList[index].otherNodes,
                    mustwe: cubit.reportsList[index].levelOfCleanliness,
                    internalAmplifiers: cubit.reportsList[index].internal_amplifiers,
                    externalAmplifiers: cubit.reportsList[index].external_amplifiers,
                    mosque_name: cubit.reportsList[index].mosque_name,
                    reportID: cubit.reportsList[index].id,
                    msgRate: cubit.reportsList[index].rating_messge??'لا يوجد',
                    rate: (double.tryParse(cubit.reportsList[index].rating))??0.0,
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
                              Text(cubit.reportsList[index].nameReport),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(cubit.reportsList[index].publishedDate,
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
        listener: (context, state){});
  }
}

class ShowResultReport extends StatelessWidget {
  final String address;
  final String createdAt;
  final String name;
  final String reportID;
  final String moazinPhone;
  final String moazinName;
  final String imamPhone;
  final String imamName;
  final String khateebPhone;
  final String khateebName;
  final String khadimPhone;
  final String khadimName;
  final String iltazam;
  final String khateebIltazam;
  final String alQarah;
  final String oratorString;
  final String externalAmplifiers;
  final String internalAmplifiers;
  final String mustwe;
  final String akhar;
  final String publisherName;
  final String publisherContact;
  final String mosque_name;
  final bool isMohref;
  final double rate;
  final String msgRate;

   ShowResultReport({Key? key,  required this.address, required this.createdAt, required this.name, required this.moazinPhone, required this.moazinName, required this.imamPhone, required this.imamName, required this.khateebPhone, required this.khateebName, required this.khadimPhone, required this.khadimName, required this.iltazam, required this.khateebIltazam, required this.alQarah, required this.oratorString, required this.mustwe, required this.akhar, required this.publisherName, required this.publisherContact, required this.mosque_name, required this.isMohref, required this.reportID, required this.rate, required this.msgRate, required this.externalAmplifiers, required this.internalAmplifiers}) : super(key: key);

 /* */
  List<Map<String,dynamic>> list=
  [
    {
      'name':'إسناد مسجد لموظف',
      'route':'ليس متوفره الان',
    },
    {
      'name':'تحميل الملف',
      'route':'ليس متوفره الان',
    },
    {
      'name':'طلب إعادة إرسال تقرير',
      'route':'ليس متوفره الان',
    },
    {
      'name':'تقييم',
      'route':'',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("التقارير",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          elevation: 1,
          leading:isMohref?PopupMenuButton(
            itemBuilder: (context){
              return list.map((e){
                return PopupMenuItem(
                    value: e,
                    child: Text(e['name']));
              }).toList();
            },
            onSelected: (dynamic value){
              if(value.isNotEmpty){
                if(value['name']=='تقييم'){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> RatingScreen(
                    reportId: reportID,
                  )));
                }else{
                  Fluttertoast.showToast(msg: value['route']);
                }
              }
            },
          ):Container(),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward_ios)),

        ],
      ),
      body: Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                        Align(
                           alignment: Alignment.topRight,
                         child: Image.asset('assets/images/otp.png')),
                      const SizedBox(height: 10,),
                      const Align(
                        alignment: Alignment.center,
                        child: Text('زيــــــارة تـــــفــــقـــديـة',
                            style: TextStyle(
                                fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black,
                                fontFamily: 'arabicJana'
                            )),
                      ),
                      const SizedBox(height: 10,),
                      showTheDate(name: 'الموقع الحالي',date:address),
                      Table(
                        border: TableBorder.all(color: Colors.black,width: 1),
                        columnWidths: const {
                          0: FixedColumnWidth(125),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children:  [
                          TableRow(
                              children: [
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('رقم الجوال',style: TextStyle(fontSize: 18,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(createdAt,
                                        style: const TextStyle(fontSize: 14,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('التاريخ و الوقت',style: TextStyle(fontSize: 18,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                                  ),
                                ),

                              ]
                          ),
                          TableRow(
                              children: [
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('',style: TextStyle(fontSize: 18,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(mosque_name,
                                        style: const TextStyle(fontSize: 14,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('اسم المسجد',style: TextStyle(fontSize: 18,color: Colors.black,
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
                                    child: Text(moazinPhone,
                                        style: const TextStyle(fontSize: 12,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(moazinName,
                                        style: const TextStyle(fontSize: 14,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('الموذن',style: TextStyle(fontSize: 18,color: Colors.black,
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
                                    child: Text(imamPhone,
                                        style: const TextStyle(fontSize: 12,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(imamName,
                                        style: const TextStyle(fontSize: 14,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('الامام',style: TextStyle(fontSize: 18,color: Colors.black,
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
                                    child: Text(khateebPhone,
                                        style: const TextStyle(fontSize: 12,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(khateebName,
                                        style: const TextStyle(fontSize: 14,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('الخطيب',style: TextStyle(fontSize: 18,color: Colors.black,
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
                                    child: Text(khadimPhone,
                                        style: const TextStyle(fontSize: 12,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(khadimName,
                                        style: const TextStyle(fontSize: 14,color: Colors.black,
                                            fontFamily: 'arabicJana')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text('الخادم',style: TextStyle(fontSize: 18,color: Colors.black,
                                        fontFamily: 'arabicJana')),
                                  ),
                                ),
                              ]
                          ),
                        ],
                      ),
                      showTheDate(name: 'التواجد',date: iltazam),
                      showTheDate(name: 'الـخـطـيـب  الإنـضباط / القراءة النجدية',date: khateebIltazam),
                      showTheDate(name: 'الخطيب/ملتزم بموضوع الخطبة ( المبلغ بها )-( المرسل له )', date: oratorString),
                      showTheDate(name: 'القرآءة النجدية',date: alQarah),
                      showTheDate(name: 'الــمكبرات الداخليه',date: internalAmplifiers),
                      showTheDate(name: 'الــمكبرات الخارجيه',date: externalAmplifiers),
                      showTheDate(name: 'مستوى النظافة',date: mustwe),
                      showTheDate(name: 'أخـــرى',date: akhar),
                      showTheDate(name: 'اســــم المــراقب  / الجهة',date: publisherName),
                      showTheDate(name: 'رقم الــجوال',date: publisherContact),
                      /*Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1)
                        ),
                        child: Center(
                          child: RatingBarIndicator(
                            rating: rate,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 50.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                      ),
                      showTheDate(name: 'رساله التقيم',date: msgRate),*/

                    ]),
              )
          )),
    );
  }

}
