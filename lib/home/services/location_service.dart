import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class LocationService {
  final Location _location = Location();

  Future<bool> checkForServiceAvailability() async {
    bool isEnabled = await _location.serviceEnabled();
    if (isEnabled) {
      return Future.value(true);
    }

    isEnabled = await _location.requestService();

    if (isEnabled) {
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<bool> checkForPermission() async {
    PermissionStatus status = await _location.hasPermission();

    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
      if (status == PermissionStatus.granted) {
        return true;
      }
      return false;
    }
    if (status == PermissionStatus.deniedForever) {
      Get.snackbar("Permission Needed",
          "We use permission to get your location in order to give your service",
          onTap: (snack) async {
        await handler.openAppSettings();
      }).show();
      return false;
    }

    return Future.value(true);
  }

  Future<LocationData?> getUserLocation() async {
    if (!(await checkForServiceAvailability())) {
      print("Service not enabled");

      return null;
    }
    if (!(await checkForPermission())) {
      print("Permission not given");
      return null;
    }

    final LocationData data = await _location.getLocation();
    return data;
  }
}
