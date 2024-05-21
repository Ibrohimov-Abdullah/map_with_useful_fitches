import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_map_learning/pages/flutter_map_page.dart';
import 'package:yandex_map_learning/pages/yandex_map_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Widget> list = const[FlutterMapPage(), CustomYandexPage()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          list[index]
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          index = value;
          setState(() {});
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: ""
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded),label: ""),

        ],
      ),
    );
  }
}
