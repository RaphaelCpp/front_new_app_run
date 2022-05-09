import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:running_app/main.dart';
import 'package:running_app/services/geolocator_service.dart';
import 'package:dio/dio.dart';
import 'package:running_app/view/view_list_run.dart';

class OpenMap extends StatefulWidget{
  List<LatLng> latlong = []; 
  OpenMap({Key? key, required this.latlong}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OpenMapState();
}

class _OpenMapState extends State<OpenMap>
{
  final Completer<GoogleMapController> _controller = Completer();
  Set<Polyline> polylineCoordinates = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Position? _position;
  final GeolocatorService geoService = GeolocatorService();

  getLocation() async {
    Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState((){
      _position = position;
    });
  }
    static const _initialPositionCamera = CameraPosition(target: LatLng(43.604, 1.44305 ),
     zoom: 16.5,
  );

  @override
  void initState(){
  super.initState();
  getLocation();
  //polylineCoordinates.add(Polyline(polylineId: const PolylineId("test"), points: this.latlong, width: 3, color: (Color.fromARGB(255, 192, 132, 245))));
 }
  @override
  Widget build(BuildContext context){
    final args = ModalRoute.of(context)!.settings.arguments as ListRun;
    print(args.toString());
    return Scaffold(
      body:GoogleMap(
          initialCameraPosition: _initialPositionCamera, 
          myLocationEnabled: true, 
          mapType: MapType.normal,  
          zoomControlsEnabled: false, 
          zoomGesturesEnabled: true,
          polylines: polylineCoordinates,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
      ),
      );
   
  }}
