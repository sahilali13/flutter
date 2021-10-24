import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const GOOGLE_API_KEY = '';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double? latitude,
    required double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress({double? lat, double? lng}) async {
    final _url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final _response = await http.get(_url);
    return json.decode(_response.body)['results'][0]['formatted_address'];
  }
}
