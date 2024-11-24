import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final String memberName;
  final List<LatLng> coordinates;
  final LatLng currentLocation;
  final bool
      isRoute; // Flag to check if we are showing route or current location

  const MapScreen({
    super.key,
    required this.memberName,
    required this.coordinates,
    required this.currentLocation,
    required this.isRoute, // Pass the flag
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${memberName}\'s ${isRoute ? "Route" : "Location"}',
          style: const TextStyle(
              color: Colors.white), // Set title text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 76, 69, 170),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Set back icon color to white
          onPressed: () {
            Navigator.pop(context); // Handle back navigation
          },
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: currentLocation,
          zoom: 14.5,
        ),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: isRoute
                ? _createRouteMarkers() // Show route markers
                : [
                    Marker(
                      point: currentLocation,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 220, 7, 7),
                        size: 30,
                      ),
                    ),
                  ],
          ),
          if (isRoute)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: coordinates,
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
              ],
            ),
        ],
      ),
    );
  }

  // Create route markers for each point
  List<Marker> _createRouteMarkers() {
    return coordinates
        .map((point) => Marker(
              point: point,
              builder: (ctx) => const Icon(
                Icons.pin_drop,
                color: Colors.red,
                size: 30,
              ),
            ))
        .toList();
  }
}
