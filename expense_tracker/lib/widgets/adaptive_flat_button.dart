import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _text;
  final void Function()? _handler;

  AdaptiveFlatButton({
    required text,
    required handler,
  })  : _text = text,
        _handler = handler;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: _handler,
          )
        : TextButton(
            onPressed: _handler,
            child: Text(
              _text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color?>(
                Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}
