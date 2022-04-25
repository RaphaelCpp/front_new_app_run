import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:running_app/services/geolocator_service.dart';
import 'dart:math';

class Mapping extends StatefulWidget{
  const Mapping({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MappingState();
}

class _MappingState extends State<Mapping>
{
  double distance = 0.0;
  double speedInMps = 0;
  double totalDistance = 0.0;
  bool startCapture = true;
  static const countDuration = Duration();
  Duration duration = Duration();
  Timer? timer;
  bool countDown = true;
  Position? _position;
  final GeolocatorService geoService = GeolocatorService();
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> routeCoords = []; 
  Set<Polyline> polylineCoordinates = {};
  PolylinePoints polylinePoints = PolylinePoints();

  static const _initialPositionCamera = CameraPosition(target: LatLng(43.604, 1.44305 ),
     zoom: 16.5,
  );

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  getLocation() async {
    Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState((){
      _position = position;
    });
  }
  Widget buildTime(){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours =twoDigits(duration.inHours);
    final minutes =twoDigits(duration.inMinutes.remainder(60));
    final seconds =twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'H'),
        SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'Min'),
        SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'Sec'),
      ]
    );
}

Widget buildButtons(){
  final isRunning = timer == null? false: timer!.isActive;
  final isCompleted = duration.inSeconds == 1;
   return 
   isRunning || isCompleted ?
   Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       ButtonWidget(
           text:'PAUSE',
           onClicked: (){
             if (isRunning){
               stopTimer(resets: false);
             }
           }),
       SizedBox(width: 2),
       ButtonWidget(
           text: "TERMINER",
           onClicked: stopTimer
       ),
     ],
   )
       : ButtonWidget(
       text: "START",
       color: Colors.black,
       backgroundColor: Colors.white,
       onClicked: (){
         startTimer();
       });
}
    void reset(){
      if (countDown){
        setState(() =>
          duration = countDuration);
      } else{
        setState(() =>
          duration = Duration());
      }
    }
    void startTimer(){
      if(startCapture){
      timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
        Timer.periodic(const Duration(seconds: 1), (timer) {
        geoService.getCurrentLocation().listen((position) {
        centerScreen(position);
        for(var i = 0; i < routeCoords.length-1; i++){
        totalDistance += calculateDistance(
          routeCoords[i].latitude, 
          routeCoords[i].longitude, 
          routeCoords[i+1].latitude, 
          routeCoords[i+1].longitude);
        }
        setState(() {
          speedInMps = position.speed * 3.6;
          routeCoords.add(LatLng(position.latitude, position.longitude));
          distance = totalDistance;
        });
    });
  });
      polylineCoordinates.add(Polyline(polylineId: const PolylineId("test"), points: routeCoords, width: 3, color: (Color.fromARGB(255, 192, 132, 245))));
    }else{
      print("stop");
    }
  }
    void addTime(){
      final addSeconds = 1;
      setState(() {
        final seconds = duration.inSeconds + addSeconds;
          duration = Duration(seconds: seconds);
      });
    }
    void stopTimer({bool resets = true}){
      if (resets){
        reset();
      }
      setState(() {
        startCapture = false;
      });

      setState(() => timer?.cancel());
    }

  @override
  void initState(){
  super.initState();
  reset();
  getLocation();
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
          SizedBox(height: 2),
          buildTime(),
          SizedBox(height: 2),
          buildButtons(),
          SizedBox(height: 3),
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
                  child: Text(distance.toStringAsFixed(2) + " km", 
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
                child: Text(speedInMps.toStringAsFixed(2) + " km/h", 
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
    Future<void> centerScreen(Position position) async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 16.5)));
  }
}

Widget buildTimeCard({required String time, required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
          time, style: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.black,fontSize: 30),),
        ),
        Text(header,style: TextStyle(color: Colors.black45)),
      ],
    );

  class ButtonWidget extends StatelessWidget {
    final String text;
    final Color color;
    final Color backgroundColor;
    final VoidCallback onClicked;

    const ButtonWidget({Key? key, required this.text, required this.onClicked,
      this.color = Colors.white, this.backgroundColor = Colors.black}) : super(key: key);
    @override
    Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5)
      ),
        onPressed: onClicked,
        child: Text(text,style: TextStyle(fontSize: 18,color: color))
    );

  }