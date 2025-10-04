import 'package:flutter/material.dart';
import 'package:medical_app/pages/AddPage.dart';
import 'package:medical_app/pages/historyPage.dart';
import 'package:medical_app/pages/homePage.dart';

class Widgetpage extends StatefulWidget {
  const Widgetpage({super.key});

  @override
  State<Widgetpage> createState() => _WidgetpageState();
}

class _WidgetpageState extends State<Widgetpage> {
  int select_index = 0;

  final List<Widget> pages = [Homepage(), AddPage(), Historypage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Medicine Tracker"), centerTitle: true),

      body: pages[select_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: select_index,
        onDestinationSelected: (int value) {
          setState(() {
            select_index = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.add), label: "Add"),
          NavigationDestination(
            icon: Icon(Icons.work_history_outlined),
            label: "history",
          ),
        ],
      ),
    );
  }
}
