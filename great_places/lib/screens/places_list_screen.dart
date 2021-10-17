import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddPlaceScreen.routeName,
              );
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: const Center(
          child: Text(
            'Got no places yet, start adding some!',
          ),
        ),
        builder: (_ctx, _greatPlaces, _child) => _greatPlaces.items.isEmpty
            ? _child as Widget
            : ListView.builder(
                itemCount: _greatPlaces.items.length,
                itemBuilder: (_ctx, _index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      _greatPlaces.items[_index].image,
                    ),
                  ),
                  title: Text(_greatPlaces.items[_index].title),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}
