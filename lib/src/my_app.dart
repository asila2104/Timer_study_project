import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer/src/bloc_widget/bloc_timer_page.dart';
import 'package:timer/constants.dart';
import 'package:timer/src/inheritedWidget/inherited_widget.dart';
import 'package:timer/src/stateful_widget/state_timer_page.dart';

import 'cubit_widget/cubit_timer_page.dart';
import 'provider_widget/provider_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Best Timer',
      theme: ThemeData(scaffoldBackgroundColor: mainColor),
      home: const MyHomePage(title: 'Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  late Widget _bodyWidget;

  // static List<Widget> listTimerWidget = <Widget>[
  //   const StateTimerPage(waitTimeInSec: waitTime),
  //   const BLoCTimerPage(waitTimeInSec: waitTime),
  //   GetXTimerPage(
  //     waitTimeInSec: waitTime,
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    onItemTepped(selectedIndex);
  }

  Widget _buildCurrentWidget(int type) {
    switch (type) {
      case 0:
        return ProviderTimerPage(waitTimeInSec: waitTime);
      case 1:
        return InheritedTimerPage();
      case 2:
        return const CubitTimerPage(waitTimeInSec: waitTime);
      default:
        throw ArgumentError();
    }
  }

  void onItemTepped(int index) {
    setState(() {
      selectedIndex = index;
      _bodyWidget = _buildCurrentWidget(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: _bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red,
        onTap: onItemTepped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.youtube_searched_for), label: 'Stateful'),
          BottomNavigationBarItem(
              icon: Icon(Icons.tab_rounded), label: 'InheritedWidget'),
          BottomNavigationBarItem(icon: Icon(Icons.cut), label: 'Cubit'),
        ],
      ),
    );
  }
}
