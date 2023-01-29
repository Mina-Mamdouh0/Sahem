import 'package:flutter/material.dart';


class SuperContact extends StatefulWidget {
  const SuperContact({super.key});

  @override
  State<SuperContact> createState() => _SuperContactState();
}

class _SuperContactState extends State<SuperContact> {
  List<String> items = ["Mohammed Ali", "Khalid Naseer", "Saad Ahmed"];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("الارقام",style: TextStyle(
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
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return buildListTile(item);
          },
        ),
      ),
    );
  }

  Widget buildListTile(String item) => Column(
        children: [
          ListTile(
            trailing: const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 20,
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            onTap: () {},
          ),
          const Divider()
        ],
      );
}
