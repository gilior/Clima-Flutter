import 'package:geolocator/geolocator.dart';

class Location {
  double lng, ltd;

  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lng = position.longitude;
      ltd = position.altitude;
      print(position);
    } catch (e) {
      print(e);
    }
  }
}
