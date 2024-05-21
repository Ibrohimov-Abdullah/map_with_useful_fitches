import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class CustomYandexPage extends StatefulWidget {
  const CustomYandexPage({super.key});

  @override
  State<CustomYandexPage> createState() => _CustomYandexPageState();
}

class _CustomYandexPageState extends State<CustomYandexPage> {
  late YandexMapController yandexMapController;
  late Position position;
  bool loading = false;
  List _placemarks = [];

  /// giving agree to location and getting my position
  Future<Position> _findPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Service enable denied");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permission denied forever");
    }

    position = await Geolocator.getCurrentPosition();
    loading = true;
    setState(() {});
    return position;
  }

  /// this function is working for making an animation when we press find me
  void onMapCreated(YandexMapController controller) {
    yandexMapController = controller ;
    yandexMapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
                latitude: position.latitude, longitude: position.longitude),
            zoom: 14,
            azimuth: 180,
            tilt: 900
          )
        )
    );
  }

  void findMe(){
    yandexMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(longitude: position.longitude,latitude: position.latitude),
          zoom: 18,
          tilt: 90,
          azimuth: 180,
        )
      ),
      animation: const MapAnimation(duration: 3, type: MapAnimationType.smooth)
    );
  }

  @override
  void initState() {
    _findPosition();
    super.initState();
  }
  // void _onMapTap(Point point) {
  //   // Adding a new placemark to the list when the map is tapped
  //   setState(() {
  //     _placemarks.add(
  //       (
  //         point: point,
  //         style: PlacemarkStyle(
  //           iconName: 'assets/icons/placeholder.png', // Specify your icon here
  //           opacity: 1.0,
  //         ),
  //       ),
  //     );
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading ? YandexMap(
        onMapCreated: onMapCreated,
        onMapTap:(Point point) {
          const Icon(Icons.gps_fixed_rounded);
        },
        nightModeEnabled: true,
      ) : const Center(child: CircularProgressIndicator(),),
      floatingActionButton: FloatingActionButton(
        onPressed: findMe,
        child: const Icon(Icons.gps_fixed_rounded),
      ),
    );
  }
}
