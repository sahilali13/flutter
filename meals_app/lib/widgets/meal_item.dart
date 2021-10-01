import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../pages/meal_detail_page.dart';

class MealItem extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;
  final int _duration;
  final Complexity _complexity;
  final Affordability _affordability;
  final Function _removeItem;

  // ignore: use_key_in_widget_constructors
  const MealItem({
    required id,
    required affordability,
    required complexity,
    required duration,
    required imageUrl,
    required title,
    required removeItem,
  })  : _title = title,
        _imageUrl = imageUrl,
        _duration = duration,
        _complexity = complexity,
        _affordability = affordability,
        _id = id,
        _removeItem = removeItem;

  String get _complexityText {
    switch (_complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'hard';
      default:
        return 'Unknown';
    }
  }

  String get _affordabilityText {
    switch (_affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.luxurious:
        return 'Luxurious';
      case Affordability.pricey:
        return 'Pricey';
      default:
        return 'Unknown';
    }
  }

  void _selectMeal(BuildContext _ctx) {
    Navigator.of(_ctx)
        .pushNamed(
      MealDetailPage.routeName,
      arguments: _id,
    )
        .then((_result) {
      if (_result != null) {
        _removeItem(_result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _stackImage = ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Image.network(
        _imageUrl,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );

    var _stackText = Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        width: 220,
        color: Colors.black54,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(
          _title,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.white,
          ),
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
    );

    var _cardImage = Stack(
      children: <Widget>[
        _stackImage,
        _stackText,
      ],
    );

    var _cardTextDuration = Row(
      children: [
        const Icon(
          Icons.schedule,
        ),
        const SizedBox(
          width: 6,
        ),
        Text('$_duration min'),
      ],
    );

    var _cardTextComplexity = Row(
      children: [
        const Icon(
          Icons.work,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(_complexityText),
      ],
    );

    var _cardTextAddordability = Row(
      children: [
        const Icon(
          Icons.account_balance_wallet,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(_affordabilityText),
      ],
    );

    var _cardText = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _cardTextDuration,
          _cardTextComplexity,
          _cardTextAddordability,
        ],
      ),
    );

    return InkWell(
      onTap: () => _selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _cardImage,
            _cardText,
          ],
        ),
      ),
    );
  }
}
