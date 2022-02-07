// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../2.1_conversas/1_conversas/conversas.dart';
import '../2.2_camera/presentation/camera_widget.dart';
import 'appbar/appbar_widget.dart';

class Home extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Home(
    this.cameras, {
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<TabData> myTabs = [
      TabData(
        myTab: const Tab(
          text: 'CONVERSAS',
        ),
        myWidget: Conversas(),
      ),
      TabData(
        myTab: const Tab(
          text: 'STATUS',
        ),
        myWidget: Scaffold(
          body: Center(child: Text(":)")),
        ),
      ),
      TabData(
        myTab: const Tab(
          text: '📷︎',
        ),
        myWidget: CameraApp(
          cameras: widget.cameras,
        ),
      ),
    ];
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(myTabs),
        body: TabBarView(
          physics: const ClampingScrollPhysics(),
          children: [
            for (var tab in myTabs) tab.myWidget
          ],
        ),
      ),
      length: myTabs.length,
    );
  }
}

class TabData {
  final Tab myTab;
  final Widget myWidget;
  TabData({
    required this.myTab,
    required this.myWidget,
  });
}
