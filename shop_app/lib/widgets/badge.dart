import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Badge({
    required child,
    required value,
    required color,
  })  : _child = child,
        _value = value,
        _color = color;

  final Widget _child;
  final String _value;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // ignore: prefer_if_null_operators, unnecessary_null_comparison
              color: _color != null
                  ? _color
                  : Theme.of(context).colorScheme.secondary,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              _value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
