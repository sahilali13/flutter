import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/location_helper.dart';
import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById({required String id}) {
    return _items.firstWhere((_place) => _place.id == id);
  }

  Future<void> addPlace({
    required String pickedTitle,
    required File? pickedImage,
    required PlaceLocation? pickedLocation,
  }) async {
    final _address = await LocationHelper.getPlaceAddress(
      lat: pickedLocation!.latitude,
      lng: pickedLocation.longitude,
    );
    final _updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: _address,
    );
    final _newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: _updatedLocation,
    );
    _items.add(_newPlace);
    notifyListeners();
    DBHelper.insert(
      table: 'user_places',
      data: {
        'id': _newPlace.id,
        'title': _newPlace.title,
        'image': _newPlace.image!.path,
        'loc_lat': _newPlace.location!.latitude as Object,
        'loc_lng': _newPlace.location!.longitude as Object,
        'address': _newPlace.location!.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(
      table: 'user_places',
    );
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
