import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';

import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function _onSelectPlace;

  const LocationInput({Key? key, onSelectPlace})
      : _onSelectPlace = onSelectPlace,
        super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // ignore: avoid_init_to_null
  String? _previewImageUrl;

  void _showPreview({
    required double? lat,
    required double? lng,
  }) {
    final _staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = _staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final _locData = await Location().getLocation();
      _showPreview(
        lat: _locData.latitude,
        lng: _locData.longitude,
      );
      widget._onSelectPlace(
        lat: _locData.latitude,
        lng: _locData.longitude,
      );
    } catch (_error) {
      rethrow;
    }
  }

  Future<void> _selectOnMap() async {
    final _selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_ctx) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (_selectedLocation == null) {
      return;
    }
    _showPreview(
      lat: _selectedLocation.latitude,
      lng: _selectedLocation.longitude,
    );
    widget._onSelectPlace(
      lat: _selectedLocation.latitude,
      lng: _selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text(
                'Current Location',
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color?>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text(
                'Select on Map',
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color?>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
