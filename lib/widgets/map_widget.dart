import 'dart:math';

import 'package:earth_quick_damage_prediction_frontend/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EarthquakeMap extends StatefulWidget {
  List<LatLng> buildings;
  List<int> damageLevels;

  EarthquakeMap({Key? key, required this.buildings, required this.damageLevels})
      : super(key: key);

  @override
  _EarthquakeMapState createState() => _EarthquakeMapState();
}

class _EarthquakeMapState extends State<EarthquakeMap> {
  LatLng epicenter = LatLng(36.3655, 6.6140); // Epicenter near the buildings
  double effectRadiusKm = 2.0; // Desired real-world radius in kilometers
  double adjustedRadius = 0.0; // Radius in pixels (will be calculated)
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    _calculateAdjustedRadius(13.0);
    mapController = MapController();
  }

  void _calculateAdjustedRadius(double zoomLevel) {
    final double metersPerPixel =
        _metersPerPixel(zoomLevel, epicenter.latitude);
    final double radiusInMeters = effectRadiusKm * 1000; // Convert km to meters

    setState(() {
      adjustedRadius = radiusInMeters / metersPerPixel; // Radius in pixels
    });
  }

  double _metersPerPixel(double zoomLevel, double latitude) {
    return 156543.03392 * cos(latitude * pi / 180) / pow(2, zoomLevel);
  }

  Color colorFromDamageLevel(int damageLevel) {
    switch (damageLevel) {
      case 5:
        return Colors.red;
      case 4:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 2:
        return Colors.lightGreen;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            onPositionChanged: (position, hasGesture) {
              _calculateAdjustedRadius(position.zoom);
            },
            onTap: (tapPosition, point) {
              setState(() {
                epicenter = point;
              });
            },
            initialCenter: LatLng(36.365, 6.6147),
            initialZoom: 13.0,
            minZoom: 13.0,
            maxZoom: 18.0,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              tileSize: 256,
              additionalOptions: {'backgroundColor': 'black'},
            ),
            CircleLayer(
              circles: [
                CircleMarker(
                  point: epicenter,
                  color: Colors.white.withOpacity(0.8),
                  borderStrokeWidth: 1,
                  borderColor: Colors.white,
                  radius: 2,
                ),
                CircleMarker(
                  point: epicenter,
                  color: Colors.yellow.withOpacity(0.05),
                  borderStrokeWidth: 2,
                  borderColor: Colors.yellow.withOpacity(0.5),
                  radius: 16,
                ),
                CircleMarker(
                  point: epicenter,
                  color: Colors.yellow.withOpacity(0.05),
                  borderStrokeWidth: 1,
                  borderColor: Colors.yellow.withOpacity(0.5),
                  radius: adjustedRadius,
                ),
              ],
            ),
            MarkerLayer(
              markers: List.generate(widget.buildings.length, (index) {
                int damageLevel = widget.damageLevels[index];
                Color markerColor = colorFromDamageLevel(damageLevel);

                return Marker(
                  point: widget.buildings[index],
                  width: 10,
                  height: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: markerColor,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 10,
          width: 200,
          child: Opacity(
            opacity: 0.6,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Earthquake Intensity',
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      intensity = double.tryParse(value) ?? intensity;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Effect Radius (km)',
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      effectRadiusKm = double.tryParse(value) ?? effectRadiusKm;
                      _calculateAdjustedRadius(mapController.camera.zoom);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
