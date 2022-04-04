import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:running_app/services/auth.dart';
import 'package:running_app/services/geolocator_service.dart';
import 'package:running_app/view/view_home.dart';
import 'package:running_app/view/map.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth()),
        ],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  final geoService = GeolocatorService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => geoService.getInitialialLocation(),
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Demo',
       // home: HomeView(),
       home: Consumer<Position>(
         builder: (context,position,widget){
          return (position != null)
           ? Map(position) 
           : Center(child: CircularProgressIndicator());
        },
       ),
      ),
    );
  }
}
