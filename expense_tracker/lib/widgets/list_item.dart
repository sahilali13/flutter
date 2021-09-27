import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    required Transaction transaction,
    required ThemeData themeContext,
    required MediaQueryData mediaQuery,
    required Function deleteTx,
  })  : _transaction = transaction,
        _themeContext = themeContext,
        _mediaQuery = mediaQuery,
        _deleteTx = deleteTx,
        super(key: key);

  final Transaction _transaction;
  final ThemeData _themeContext;
  final MediaQueryData _mediaQuery;
  final Function _deleteTx;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  var _bgColor;

  @override
  void initState() {
    const _availableColors = [
      Colors.red,
      Colors.orange,
      Colors.brown,
      Colors.blueGrey,
      Colors.cyan,
    ];
    _bgColor = _availableColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$${widget._transaction.amount}',
                style: widget._themeContext.textTheme.headline6,
              ),
            ),
          ),
        ),
        title: Text(
          widget._transaction.title,
          style: widget._themeContext.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd-MM-yyyy').format(
            widget._transaction.date,
          ),
        ),
        trailing: widget._mediaQuery.size.width > 400
            ? TextButton.icon(
                onPressed: () => widget._deleteTx(widget._transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      widget._themeContext.errorColor),
                  textStyle: MaterialStateProperty.all<TextStyle?>(
                    widget._themeContext.textTheme.headline6,
                  ),
                ),
              )
            : IconButton(
                onPressed: () => widget._deleteTx(widget._transaction.id),
                icon: const Icon(Icons.delete),
                color: widget._themeContext.errorColor,
              ),
      ),
    );
  }
}
