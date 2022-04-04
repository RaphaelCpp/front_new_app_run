import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:running_app/services/geolocator_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget{
  late final Position initialPosition;

  Map(this.initialPosition);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<Map>{
  final GeolocatorService geoService = GeolocatorService();
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialPosition.latitude, 
                widget.initialPosition.longitude),
            zoom: 18),
          mapType: MapType.satellite,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller){

          },
          
          ),
      )
    );
  }
}