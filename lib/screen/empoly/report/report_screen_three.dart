import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahem/bloc/app_cubit.dart';
import 'package:sahem/bloc/app_state.dart';
import 'package:sahem/modal/report_model.dart';
import 'package:sahem/screen/empoly/report/preview_report.dart';
import 'package:sahem/shared/compont.dart';

class ReportScreenThree extends StatelessWidget {
  final String lat;
  final String lng;
  final String address;
  final String createdAt;
  final MosqueDate mosqueDate;
  ReportScreenThree({super.key, required this.lat, required this.lng, required this.address, required this.createdAt,required this.mosqueDate,});

  List<String> selectedIltazam = [];
  List<String> iltazam = [
    "١ / الإمام - متواجد . ",
    "٢/ المؤذن - متواجد. ",
    "٣ / الخادم - متواجد . ",
    "٤/ الإمام - غير متواجد . ",
    "٥ / المؤذن - غير متواجد . ",
    "٦/ الخادم - غير متواجد . ",
  ];
  //Khateeb Iltazam
  List<String> selectedKhateebIltazam = [];
  List<String> khateebIltazam = [
    "١ / متواجد - ملتزم بالقراءه النجديه.",
    "٢/ متواجد - غير ملتزم بالقراءه النجديه.",
    "٣/ غير متواجد.",
  ];

  List<String> selectedAlqarah = [];
  List<String> alqarah = [
    "١/ الإمام - ملتزم.",
    "٢/ المؤذن - ملتزم.",
    "٣/ الإمام - غير ملتزم.",
    "٤/ المؤذن - غير ملتزم.",
  ];


  List<String> selectedExternalAmplifiers = [];
  List<String> externalAmplifiers = [
    "١ / مشغلة لغير الأذان و الإقامة",
    "٢ / مغلقة.",
  ];
  List<String> selectedInternalAmplifiers = [];
  List<String> internalAmplifiers = [
    "١ / نظامية.",
    "٢ / مرتفعة. ",
  ];
  List<String> selectedmustawa=[];
  List<String> mustawa = [
    "١/ جيد",
    "٢ / ضعيف",
    "٣/ تكدس اجهزه و كتب",
    "٤ / عدم اغلاق دوراه المياه و اطفاء الاجهزه بعد الانتهاء من الصلاوات .",
  ];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController othersController = TextEditingController();
  TextEditingController nameReportController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  List<String> oratorPresence=[
    'نعم',
    'لا'
  ];
  String? oratorString;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state){
          var cubit=AppCubit.get(context);
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
                    elevation: 1,
                    leading:IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded))
                ),
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.green,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 50,),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                steps(true, true, true),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "زيــــــارة تـــــفــــقـــديـة",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: nameReportController,
                                  keyboardType: TextInputType.text,
                                  validator: (val){
                                    if(val!.isEmpty){
                                      return 'الحقل مطلوب';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'ادخل اسم التقرير',
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                    border: const OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                    ) ,

                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                iconTextFiledSelected('التواجد', iltazam, (l) {selectedIltazam = l;}, true),
                                const SizedBox(
                                  height: 10,
                                ),
                                iconTextFiledSelected("القرآءة النجدية", alqarah, (l) {selectedAlqarah = l;}),
                                const SizedBox(height: 10,),
                                iconTextFiledSelected("الـخـطـيـب  الإلتــزام  / القراءة النجدية ", khateebIltazam, (l) {selectedKhateebIltazam = l;}, false),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  " الخطيب/ملتزم بموضوع الخطبة ( المبلغ بها )-( المرسل له ) ",
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField(
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black
                                    ),
                                    dropdownColor: Colors.white,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                      ),
                                      enabledBorder:OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade200
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                      ) ,

                                    ),
                                    items: [
                                      ...oratorPresence.map((e) {
                                        return DropdownMenuItem(
                                          onTap: (){
                                          },
                                          value: e,
                                          child: Text(e,
                                            style:  const TextStyle(fontWeight: FontWeight.bold),),
                                        );
                                      }),
                                    ],
                                    value: oratorString,
                                    onChanged: (val){
                                      oratorString=val.toString();
                                    }
                                ),
                                const SizedBox(height: 10,),
                                    Text(
                                      "موضوع الخطبه",
                                      style: TextStyle(
                                          color: Colors.green.shade900,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: subjectController,
                                      keyboardType: TextInputType.text,
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return 'الحقل مطلوب';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'ادخل موضوع الخطبه',
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                        ),
                                        enabledBorder:OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                        ) ,

                                      ),
                                    ),
                                const SizedBox(height: 10,),
                                    Text(
                                      "المكبرات الداخليه والخارجيه",
                                      style: TextStyle(
                                          color: Colors.green.shade900,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                iconTextFiledSelected("الــمكبرات الداخليه", internalAmplifiers, (l) {selectedInternalAmplifiers = l;}),
                                iconTextFiledSelected("الــمكبرات الخارجيه", externalAmplifiers, (l) {selectedExternalAmplifiers = l;}),
                                const SizedBox(height: 10,),
                                iconTextFiledSelected("مستوى النظافة ", mustawa, (l) {selectedmustawa = l;}),
                                const SizedBox(
                                  height: 10,
                                ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        "مرفقات",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.green.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            margin:const  EdgeInsets.all(10),
                                            height: MediaQuery.of(context).size.width*0.2,
                                            width: MediaQuery.of(context).size.width*0.2,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: cubit.file1==null?Image.asset('assets/images/logo.png',
                                                fit: BoxFit.fill,):Image.file(cubit.file1!,
                                                fit: BoxFit.fill,),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              showDialog(context: context,
                                                  builder: (context){
                                                    return show(context: context,
                                                        camera: ()async{
                                                          Navigator.pop(context);
                                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                                          if(picked !=null){
                                                            cubit.changeImage1(picked.path);
                                                          }
                                                        },
                                                        gallery: ()async{
                                                          Navigator.pop(context);
                                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                                          if(picked !=null){
                                                            cubit.changeImage1(picked.path);
                                                          }
                                                        });
                                                  });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(width: 2,
                                                      color: Colors.white),
                                                  color: Colors.pink
                                              ),
                                              child: Icon(cubit.file1==null?Icons.camera_alt:Icons.edit,
                                                color: Colors.white,
                                                size: 20,),

                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            margin:const  EdgeInsets.all(10),
                                            height: MediaQuery.of(context).size.width*0.2,
                                            width: MediaQuery.of(context).size.width*0.2,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: cubit.file2==null?Image.asset('assets/images/logo.png',
                                                fit: BoxFit.fill,):Image.file(cubit.file2!,
                                                fit: BoxFit.fill,),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              showDialog(context: context,
                                                  builder: (context){
                                                    return show(context: context,
                                                        camera: ()async{
                                                          Navigator.pop(context);
                                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                                          if(picked !=null){
                                                            cubit.changeImage2(picked.path);
                                                          }
                                                        },
                                                        gallery: ()async{
                                                          Navigator.pop(context);
                                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                                          if(picked !=null){
                                                            cubit.changeImage2(picked.path);
                                                          }
                                                        });
                                                  });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(width: 2,
                                                      color: Colors.white),
                                                  color: Colors.pink
                                              ),
                                              child: Icon(cubit.file2==null?Icons.camera_alt:Icons.edit,
                                                color: Colors.white,
                                                size: 20,),

                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            margin:const  EdgeInsets.all(10),
                                            height: MediaQuery.of(context).size.width*0.2,
                                            width: MediaQuery.of(context).size.width*0.2,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: cubit.file3==null?Image.asset('assets/images/logo.png',
                                                fit: BoxFit.fill,):Image.file(cubit.file3!,
                                                fit: BoxFit.fill,),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              showDialog(context: context,
                                                  builder: (context){
                                                    return show(context: context,
                                                        camera: ()async{
                                                          Navigator.pop(context);
                                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                                          if(picked !=null){
                                                            cubit.changeImage3(picked.path);
                                                          }
                                                        },
                                                        gallery: ()async{
                                                          Navigator.pop(context);
                                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                                          if(picked !=null){
                                                            cubit.changeImage3(picked.path);
                                                          }
                                                        });
                                                  });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(width: 2,
                                                      color: Colors.white),
                                                  color: Colors.pink
                                              ),
                                              child: Icon(cubit.file3==null?Icons.camera_alt:Icons.edit,
                                                color: Colors.white,
                                                size: 20,),

                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "أخـــرى",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLines: 6,
                                  maxLength: 150,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'الحقل مطلوب';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: othersController,
                                  style: const TextStyle(color: Colors.grey, fontSize: 18),
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
                                /*const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "150 كلمه",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),*/
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if(formKey.currentState!.validate()&&oratorString!=null){
                                      navigatorTo(context: context,widget: PreviewReport(
                                        lng: lng,
                                        lat: lat,
                                        createdAt: createdAt,
                                        address: address,
                                        mosqueDate:mosqueDate,
                                        publisherName: cubit.userDate==null?'':cubit.userDate!.name,
                                        publisherPhone: cubit.userDate==null?'':cubit.userDate!.number,
                                        othersController: othersController.text,
                                        oratorString: oratorString!,
                                        subject: subjectController.text,

                                        selectedExternalAmplifiers: selectedExternalAmplifiers.toString(),
                                        selectedInternalAmplifiers: selectedInternalAmplifiers.toString(),

                                        selectedAlqarah: selectedAlqarah.toString(),
                                        selectedIltazam: selectedIltazam.toString(),
                                        selectedKhateebIltazam: selectedIltazam.toString(),
                                        selectedmustawa: selectedmustawa.toString(),
                                        nameReport: nameReportController.text,

                                        imageOne: null,//cubit.base641,
                                        imageOneName: null,//cubit.imagePath1,
                                        imageTwo: null,//cubit.base642,
                                        imageTwoName: null,//cubit.imagePath2,
                                        imageThree: null,//cubit.base643,
                                        imageThreeName: null,// cubit.imagePath3,

                                      ));
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    constraints: const BoxConstraints(
                                        maxHeight: 50, maxWidth: double.infinity),
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
                                      "عرض ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        },
        listener: (context, state){});
  }
  Widget show({required BuildContext context,
  required Function() camera,
  required Function() gallery,}){
    return AlertDialog(
      title:const  Text(
        'اختار صوره',
        style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: camera,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(Icons.photo,color: Colors.green,),
                  SizedBox(width: 10,),
                  Text('كاميرا',
                    style: TextStyle(
                        color: Colors.green,fontSize: 20
                    ),)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: gallery,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(Icons.camera,color: Colors.green,),
                  SizedBox(width: 10,),
                  Text('معرض',
                    style: TextStyle(
                        color: Colors.green,fontSize: 20
                    ),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
