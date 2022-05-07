import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:running_app/services/geolocator_service.dart';

class TestMapping extends StatefulWidget{
  const TestMapping({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestMappingState();
}

class _TestMappingState extends State<TestMapping>
{
  final GeolocatorService geoService = GeolocatorService();
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> routeCoords = []; 
  Set<Polyline> polylineCoordinates = {};
  PolylinePoints polylinePoints = PolylinePoints();

  static const _initialPositionCamera = CameraPosition(target: LatLng(43.604, 1.44305 ),
     zoom: 16.5,
  );

  @override
  void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Stack(
        alignment: Alignment.center,
        children: [       
          GoogleMap(
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


            ],
          ),
    );
  }
}

