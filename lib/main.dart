import 'package:flutter/material.dart';
import 'package:yandex_map_learning/pages/main_page.dart';

void main()async{
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapScreen(),
//     );
//   }
// }
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late YandexMapController _controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Yandex Map with Route'),
//       ),
//       body: YandexMap(
//         onMapCreated: (YandexMapController controller) {
//           _controller = controller;
//           _addRoute();
//         },
//       ),
//     );
//   }
//
//   Future<void> _addRoute() async {
//     // Define your waypoints
//     final Point startPoint = Point(latitude: 55.76, longitude: 37.64);
//     final Point endPoint = Point(latitude: 55.75, longitude: 37.68);
//
//     // Add the route to the map
//     final result = await _controller.requestMasstransitRoute(
//       points: [
//         RequestPoint(point: startPoint, requestPointType: RequestPointType.wayPoint),
//         RequestPoint(point: endPoint, requestPointType: RequestPointType.wayPoint)
//       ],
//       masstransitOptions: MasstransitOptions(),
//     );
//
//     if (result.routes.isNotEmpty) {
//       _controller.addPolyline(
//         Polyline(
//           coordinates: result.routes.first.geometry,
//           strokeColor: Colors.blue,
//           strokeWidth: 5.0,
//         ),
//       );
//     } else {
//       print('No routes found');
//     }
//   }
// }
