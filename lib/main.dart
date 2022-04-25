// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
// import 'package:running_app/services/auth.dart';
// import 'package:running_app/services/geolocator_service.dart';
// import 'package:running_app/view/view_home.dart';
// import 'package:running_app/view/map.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// void main() {
//   runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (context) => Auth()),
//         ],
//         child: MyApp(),
//       ));
// }

// class MyApp extends StatelessWidget {
//   final geoService = GeolocatorService();
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final items = <Widget>[
//       const ImageIcon(
//      AssetImage("images/runner.png"),
//      size: 30,
//     ),
//           const ImageIcon(
//      AssetImage("images/accueil.png"),
//      size: 30,
//     ),
//           const ImageIcon(
//      AssetImage("images/fonctionnement.png"),
//      size: 30,
//     ),
//     ];

//     return FutureProvider(
//       create: (context) => geoService.getInitialialLocation(),
//       initialData: null,
//       child: MaterialApp(
//         title: 'Flutter Demo',
//        home: Consumer<Position>(
//          builder: (context,position,widget){
//           return (position != null)
//            ? Maps(position) 
//            : Center(child: CircularProgressIndicator());
//         },
//        ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:running_app/view/view_home.dart';
import 'package:running_app/view/view_login.dart';
import 'package:running_app/view/view_mapping.dart';

void main() => runApp(MaterialApp(home: BottomNavBar(),
    )
  );

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 2;
  final screens = [ 
    LoginView(),
    Mapping(),
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    final  items = <Widget>[
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
          buttonBackgroundColor: Color.fromARGB(255, 29, 239, 186),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) => setState(() => this.index = index),
        ),
    );
  }
}