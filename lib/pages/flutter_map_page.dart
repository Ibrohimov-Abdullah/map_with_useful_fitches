import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapPage extends StatefulWidget {
  const FlutterMapPage({super.key});

  @override
  State<FlutterMapPage> createState() => _FlutterMapPageState();
}

class _FlutterMapPageState extends State<FlutterMapPage> {

  late Position myPosition;
  bool loading = false;

  @override
  void initState() {
    _location();
    super.initState();
  }


  Future<Position> _location() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      log("Denied");
      return Future.error("Location service are disabled.");
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission =  await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        log("Denied");
        return Future.error("Location Permission is denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      log("Denied");
      return Future.error("Location permissions are permanently denied, we cannot request permissions.");
    }
    myPosition = await Geolocator.getCurrentPosition();
    loading = true;
    setState(() {});
    return myPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          loading ?  FlutterMap(options: MapOptions(
              initialCenter: LatLng(myPosition.latitude, myPosition.longitude),
            ), children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            PolygonLayer(polygons: [
                Polygon(points: [
                  LatLng(myPosition.latitude, myPosition.latitude)
                ],color: Colors.blue,borderStrokeWidth: 2,
                  borderColor: Colors.blue,
                  isFilled: true,)
              ]
            ),
            MarkerLayer(markers: [
              Marker(point: LatLng(myPosition.latitude,myPosition.longitude), child: const Icon(Icons.location_pin))
            ]),
            // CircleLayer(circles: [
            //   CircleMarker(point: LatLng(myPosition.latitude, myPosition.longitude), radius: 10,color: Colors.blue)
            // ])
          ]): const Center(child: CircularProgressIndicator(color: Colors.red,),)
        ]
      ),
    );
  }
}


// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
//
// class FlutterMapPage extends StatefulWidget {
//   const FlutterMapPage({Key? key}) : super(key: key);
//
//   @override
//   State<FlutterMapPage> createState() => _FlutterMapPageState();
// }
//
// class _FlutterMapPageState extends State<FlutterMapPage> {
//   late Position myPosition;
//   bool loading = false;
//   List<Marker> markers = [];
//
//   @override
//   void initState() {
//     _getLocation();
//     super.initState();
//   }
//
//   Future<void> _getLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       log("Location services are disabled.");
//       return;
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         log("Location permissions are denied.");
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       log("Location permissions are permanently denied.");
//       return;
//     }
//
//     myPosition = await Geolocator.getCurrentPosition();
//     setState(() {
//       loading = true;
//     });
//   }
//
//   void _onTap(LatLng point) {
//     setState(() {
//       markers = [
//         Marker(
//           width: 80.0,
//           height: 80.0,
//           point: point,
//           builder: (ctx) => const Icon(Icons.location_pin), child: null,
//         ),
//       ];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           loading
//               ? FlutterMap(
//             options: MapOptions(
//               center: LatLng(myPosition.latitude, myPosition.longitude),
//               zoom: 13.0,
//               onTap: _onTap,
//             ),
//             layers: [
//               TileLayerOptions(
//                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: ['a', 'b', 'c'],
//               ),
//               MarkerLayerOptions(markers: markers),
//             ],
//           )
//               : const Center(child: CircularProgressIndicator(color: Colors.red)),
//         ],
//       ),
//     );
//   }
// }

