import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveTextButton extends StatelessWidget {
  late final _title;
  late final _handler;

  AdaptiveTextButton(
    this._title,
    this._handler,
  );

  @override
  Widget build(BuildContext context) {
    final _themeContext = Theme.of(context);
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: _handler,
            child: Text(
              _title,
              style: TextStyle(
                color: _themeContext.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            onPressed: _handler,
            child: Text(
              _title,
              style: TextStyle(
                color: _themeContext.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
