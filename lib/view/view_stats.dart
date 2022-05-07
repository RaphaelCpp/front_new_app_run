import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/services/auth.dart';
import 'package:running_app/view/view_register.dart';
import 'package:running_app/main.dart';

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {

  @override
  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) {
      return Scaffold(
      body:Stack(
        alignment: Alignment.center,
        children: [       
       Positioned(
      bottom: 70,
      height: 220,
      width: 300,
      child: Card(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
          Row (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              const ImageIcon(
              AssetImage("images/kilometre.png"),
              size: 35,
              ),
              SizedBox(width: 8),
                Expanded(
                  child: Text(" km", 
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17)),
                ),
            ],
          ),
          SizedBox(height: 8),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              const ImageIcon(
              AssetImage("images/vitesse.png"),
              size: 35,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(" km/h", 
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17)),
              ),
            ],
          ),
          ]
        ),  
      )
    )
        ]
    ));
        
  }

}
