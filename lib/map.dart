import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  String locationMessage = "Current location of the user";
  String? lat;
  String? long;

  // ✅ Fix: Make this function return Position
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
          await Geolocator.openLocationSettings();
      return Future.error("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    // ✅ Return the current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  
  }

Future<void> _openInGoogleMaps () async {

    Position value = await getCurrentLocation();

    final latitude = value.latitude;
    final longitude = value.longitude;
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
 
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not open the map.';
    }
}


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              locationMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  Position value = await getCurrentLocation();
                  setState(() {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    locationMessage = "Latitude: $lat\nLongitude: $long";
                  });
                } catch (e) {
                  setState(() {
                    locationMessage = "Error: $e";
                  });
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Get Current Location",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openInGoogleMaps,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Open in Google Maps",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
