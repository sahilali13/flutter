import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

import '../screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context)!.settings.arguments;
    final _selectedPlaces = Provider.of<GreatPlaces>(context, listen: false)
        .findById(id: _id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPlaces.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              _selectedPlaces.image as File,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _selectedPlaces.location!.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_ctx) => MapScreen(
                    initialLocation: _selectedPlaces.location,
                  ),
                ),
              );
            },
            child: const Text('View on Map'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color?>(
                Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
