import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/services/auth.dart';
import 'package:running_app/view/view_home.dart';

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeView(),
    );
  }
}
