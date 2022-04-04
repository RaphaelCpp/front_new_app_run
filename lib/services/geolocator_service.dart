import 'package:geolocator/geolocator.dart';

class GeolocatorService{
 
  Stream<Position> getCurrentLocation(){
    var locationOptions = AndroidSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
    return Geolocator.getPositionStream(locationSettings: locationOptions);
  }

  Future<Position> getInitialialLocation() async{
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  
}