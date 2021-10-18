import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation _initialLocation;
  final bool _isSelecting;

  const MapScreen({
    Key? key,
    initialLocation = const PlaceLocation(
      latitude: 23.2525,
      longitude: 87.00555556,
    ),
    isSelecting = false,
  })  : _initialLocation = initialLocation,
        _isSelecting = isSelecting,
        super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: avoid_init_to_null
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Map',
        ),
        actions: <Widget>[
          if (widget._isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget._initialLocation.latitude as double,
            widget._initialLocation.longitude as double,
          ),
          zoom: 16,
        ),
        onTap: widget._isSelecting ? _selectLocation : null,
        // ignore: unnecessary_null_comparison
        markers: (_pickedLocation == null && widget._isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation == null
                      ? LatLng(
                          widget._initialLocation.latitude as double,
                          widget._initialLocation.longitude as double,
                        )
                      : _pickedLocation as LatLng,
                ),
              },
      ),
    );
  }
}
