



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sahem/shared/compont.dart';
import 'package:sahem/screen/empoly/report/report_screen_two.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportScreenOne extends StatefulWidget {
  const ReportScreenOne({super.key});

  @override
  State<ReportScreenOne> createState() => _ReportScreenOneState();
}

class _ReportScreenOneState extends State<ReportScreenOne> {

  final TextEditingController addressController = TextEditingController();
  late double lat;
  late double lng;
  bool isLoading = false;
  final Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    map();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {});
    });

    super.initState();
  }
  static CameraPosition? _kGoogle;
  final List<Marker> _markers = <Marker>[];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
            children: [
          SizedBox(
            height: 300,
            width: size.width,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                  height: 300,
                  width:size.width,
                  child: _kGoogle == null
                      ? Container()
                      : GoogleMap(
                    initialCameraPosition: _kGoogle!,
                    markers: Set<Marker>.of(_markers),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {},
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                     onTap: (){
                       Navigator.pop(context);
                     },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.arrow_back_ios_rounded,color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset('assets/images/Home Indicator.png'),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: Center(
                child: steps(true, false, false),
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: Text("الموقع الحالي ",
                        style: TextStyle(
                            color: Colors.green.shade900,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text("*",
                      style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Text(addressController.text),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 180),
                    child: Text("التاريخ و الوقت",
                        //  textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.green.shade900,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text("*",
                      style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Text(DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if(addressController.text.isNotEmpty ){
                navigatorTo(context: context, widget: ReportScreenTwo(
                  createdAt: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
                  address: addressController.text,
                  lat: lat.toString(),
                  lng: lng.toString(),
                ));
              }
            },
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxHeight: 50, maxWidth: 320),
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
                "الـــتــــالي ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
      )),
    );
  }



  map() async {
    try {
      if ((await Permission.location.request()).isGranted) {
        await getUserCurrentLocation().then((value) async {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {});
          });
          List<Placemark> placemarks =
              await placemarkFromCoordinates(value.latitude, value.longitude);
          Placemark first = placemarks.first;
          String palcename =
              " ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea}, ${first.street}, ${first.name}, ${first.thoroughfare}, ${first.subThoroughfare}'";
          addressController.text = palcename;
          lat = value.latitude;
          lng = value.longitude;
          _markers.add(Marker(
            markerId: const MarkerId("2"),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
              title: 'My Current Location',
            ),
          ));

          _kGoogle = CameraPosition(
              target: LatLng(value.latitude, value.longitude), zoom: 11);

          final GoogleMapController controller = await _controller.future;
          await controller
              .animateCamera(CameraUpdate.newCameraPosition(_kGoogle!));

          setState(() {});
        });
      }
    } catch (e) {
      await getUserCurrentLocation().then((value) async {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {});
        });
        List<Placemark> placemarks =
            await placemarkFromCoordinates(value.latitude, value.longitude);
        Placemark first = placemarks.first;
        String palcename =
            " ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea}, ${first.street}, ${first.name}, ${first.thoroughfare}, ${first.subThoroughfare}'";
        addressController.text = palcename;
        lat = value.latitude;
        lng = value.longitude;
        setState(() {});
      });
    }
  }
}
