import 'dart:math';

import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low)
          .timeout(const Duration(seconds: 5));
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      throw '$e';
    }
  }
}
