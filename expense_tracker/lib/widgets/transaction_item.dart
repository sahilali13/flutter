import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required transaction,
    required deleteTx,
  })  : _transaction = transaction,
        _deleteTx = deleteTx,
        super(key: key);

  final Transaction _transaction;
  final Function _deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgColor = null;

  @override
  void initState() {
    const _availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = _availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30.0,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget._transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget._transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget._transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => widget._deleteTx(widget._transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color?>(
                    Theme.of(context).errorColor,
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget._deleteTx(widget._transaction.id),
              ),
      ),
    );
  }
}
