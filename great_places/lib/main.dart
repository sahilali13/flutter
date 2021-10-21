import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

import '../screens/place_detail_screen.dart';
import '../screens/places_list_screen.dart';
import '../screens/add_place_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Great Places',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            appBarTheme: const AppBarTheme(
              color: Colors.indigo,
            ),
          ).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  secondary: Colors.amber,
                ),
          ),
          home: const PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (_ctx) => const AddPlaceScreen(),
            PlaceDetailScreen.routeName: (_ctx) => const PlaceDetailScreen(),
          }),
    );
  }
}
