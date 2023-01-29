import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sahem/screen/empoly/report/report_screen_two.dart';
import 'package:sahem/shared/compont.dart';
import 'package:intl/intl.dart' as intl;

class ReportScreenOneIOS extends StatefulWidget {
  const ReportScreenOneIOS({super.key});

  @override
  State<ReportScreenOneIOS> createState() => _ReportScreenOneIOSState();
}

class _ReportScreenOneIOSState extends State<ReportScreenOneIOS> {
  final TextEditingController addressController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool isLoading = false;
  double? lat;
  double? lng;
  DateTime? timeNow;

  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    timeNow = DateTime.now();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: lat == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  SizedBox(
                    height: 300,
                    width: size.width,
                    child: SizedBox(
                      height: 300,
                      width: size.width,
                      child: lat == null
                          ? Container()
                          : GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat!, lng!),
                                zoom: 14.4746,
                              ),
                              markers: Set<Marker>.of(_markers),
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              compassEnabled: true,
                              onMapCreated: (GoogleMapController controller) {},
                            ),
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
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "*",
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "الموقع الحالي :",
                              style: TextStyle(
                                  color: Colors.green.shade900,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        Text(addressController.text),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "*",
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "التاريخ و الوقت:",
                              style: TextStyle(
                                  color: Colors.green.shade900,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 20),
                            Text(intl.DateFormat("yyyy-MM-dd")
                                .format(DateTime.now())
                                .toString()),
                            const SizedBox(width: 10),
                            Text('${timeNow!.hour}:${timeNow!.minute}'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            if (addressController.text.isNotEmpty) {
                              navigatorTo(
                                  context: context,
                                  widget: ReportScreenTwo(
                                    createdAt: intl.DateFormat("yyyy-MM-dd")
                                        .format(DateTime.now())
                                        .toString(),
                                    address: addressController.text,
                                    lat: lat.toString(),
                                    lng: lng.toString(),
                                  ));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                maxHeight: 50, maxWidth: 320),
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
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lng = position.longitude;
      lat = position.latitude;
    });
    getNameAdree();
  }

  getNameAdree() async {
    try {
      if (lat != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        Placemark first = placemarks.first;
        String palcename =
            " ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea}, ${first.street}, ${first.name}, ${first.thoroughfare}, ${first.subThoroughfare}'";

        setState(() {
          addressController.text = palcename;
        });

        print('============================');
        print(addressController.text);
      }
    } catch (e) {
      print('error');
    }
  }

  // update test
}
