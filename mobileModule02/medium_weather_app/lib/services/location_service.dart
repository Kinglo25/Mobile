import "package:geolocator/geolocator.dart";

/// Service for getting the user's current location as a string label.
class LocationService {
  /// Returns a string describing the current location or an error message.
  Future<String> getLocationLabel() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return "Geolocalisation is disabled";
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return "Geolocalisation permission denied";
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return "Geolocalisation permission denied forever";
      }

      final position = await Geolocator.getCurrentPosition();
      return "${position.latitude}, ${position.longitude}";
    } catch (_) {
      return "Location unavailable";
    }
  }
}
