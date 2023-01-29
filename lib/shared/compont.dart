
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mutli_dropdown.dart';

navigatorTo( {required BuildContext context,required Widget widget}){
  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>widget));
}

navigatorRemove({required BuildContext context,required Widget widget}){
  Navigator.of(context).pushAndRemoveUntil
    (MaterialPageRoute(builder: (_)=>widget),(route) => false);
}

navigatorOff({required BuildContext context,required Widget widget}){
  Navigator.of(context).pushReplacement
    (MaterialPageRoute(builder: (_)=>widget),);
}

steps(bool one, bool two, bool three) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Container(
        height: 30,
        width: 30,
        decoration: one ?
        BoxDecoration(
            color: const Color(0XFFC4BF4C), borderRadius: BorderRadius.circular(50))
            :BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            '1',
            style: TextStyle(color: one?Colors.white:Colors.grey),
          ),
        ),
      ),
      Container(
        color: const Color(0XFFC4BF4C),
        height: 1,
        width: 70,
      ),
          Container(
            height: 30,
            width: 30,
            decoration: two ?
            BoxDecoration(
                color: const Color(0XFFC4BF4C), borderRadius: BorderRadius.circular(50))
                :BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                '2',
                style: TextStyle(color: two?Colors.white:Colors.grey),
              ),
            ),
          ),
      Container(
        color: two?const Color(0XFFC4BF4C):Colors.grey,
        height: 1,
        width: 70,
      ),
          Container(
            height: 30,
            width: 30,
            decoration: three ?
            BoxDecoration(
                color: const Color(0XFFC4BF4C), borderRadius: BorderRadius.circular(50))
                :BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(color: three?Colors.white:Colors.grey),
              ),
            ),
          ),
    ]),
  );
}

showTheDate({required String name,String? date,List<String>? values}){
  String value = '';
  if(values !=null){
    for (var e in values) {
      value = "$value$e\n";
    }
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black,width: 1)
        ),
        child: Center(
          child: Text(name,style: const TextStyle(fontSize: 18,color: Colors.black,
              fontFamily: 'arabicJana')),
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black,width: 1)
        ),
        child: Text('${values!=null?value:date}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16,color: Colors.black,
                fontFamily: 'arabicJana')),
      ),
    ],
  );
}

Widget showDate({required String name,required String date}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(name,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.green.shade900,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Text("*",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.red.shade900,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
      Text(date),
      const SizedBox(
        height: 8,
      ),
    ],
  );
}

simpleTextFiled(String txt, TextEditingController controller,
    [bool required = true]) {
  return Column(children: [
    Row(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(txt,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            Text("*",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    ),
    TextFormField(
      validator: required
          ? (val) {
        if (val!.isEmpty) {
          return 'الحقل مطلوب';
        } else {
          return null;
        }
      }
          : null,
      controller: controller,
      // validator: validator,
      style: const TextStyle(color: Colors.grey, fontSize: 12),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: "",
        hintTextDirection: TextDirection.rtl,
        fillColor: const Color.fromARGB(255, 236, 234, 234),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  ]);
}

iconTextFiled(
    String txt1,
    TextEditingController controller,
    ) {
  return Column(
    children: [
      Row(
        //  mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(txt1,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
              Text("*",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      TextFormField(
        controller: controller,
        validator: (val) {
          if (val!.isEmpty) {
            return 'الحقل مطلوب';
          } else {
            return null;
          }
        },
        style: const TextStyle(color: Colors.grey, fontSize: 12),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          suffixIcon: const Icon(CupertinoIcons.phone),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: "+966",
          hintTextDirection: TextDirection.ltr,
          fillColor: const Color.fromARGB(255, 236, 234, 234),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      )
    ],
  );
}

iconTextFiledSelected(String txt1, List<String> list, Function(List<String>) onChange,
    [bool mandatory = true]) {
  return Column(
    children: [
      Row(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(txt1,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
              Text(mandatory ? "*" : " ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      CustomMultiselectDropDown(
        selectedList: onChange,
        listOFStrings: list,
      ),
    ],
  );
}



showHandlingData({required BuildContext context,
  required String imagePath,required String msg,required Function() fct
}){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: MediaQuery.of(context).size.width * 0.83,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(
                  20)),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/$imagePath',
                width: 90,
              ),
              const SizedBox(
                height: 20,
              ),
               Text(msg,
               textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              InkWell(
                onTap:fct,
                child: Container(
                    margin: const EdgeInsets
                        .only(
                        left: 20,
                        right: 20),
                    alignment:
                    Alignment.center,
                    constraints:
                    const BoxConstraints(
                        maxHeight: 50,
                        maxWidth: 320),
                    decoration:
                    BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            15),
                        gradient: const LinearGradient(
                            begin: Alignment
                                .topCenter,
                            end: Alignment
                                .bottomCenter,
                            colors: [
                              Color(
                                  0xFFC4D35F),
                              Color(
                                  0xFF578B37),
                            ])),
                    child: const Text('انهاء',
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontWeight:
                          FontWeight
                              .bold,
                        ))),
              ),
            ],
          ),
        ),
      ));
}