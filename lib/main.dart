import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:running_app/services/auth.dart';
import 'package:running_app/view/view_home.dart';
import 'package:running_app/view/view_list_run.dart';
import 'package:running_app/view/view_login.dart';
import 'package:running_app/view/view_mapping.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth()),
        ],
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: LoginView()));
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 2;
  final screens = [
    HomeView(),
    Mapping(),
    ListRun(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const ImageIcon(
        AssetImage("images/accueil.png"),
        size: 30,
      ),
      const ImageIcon(
        AssetImage("images/runner.png"),
        size: 30,
      ),
      const ImageIcon(
        AssetImage("images/fonctionnement.png"),
        size: 30,
      ),
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        height: 60,
        color: Colors.white,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color.fromRGBO(231, 76, 60, 1),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
