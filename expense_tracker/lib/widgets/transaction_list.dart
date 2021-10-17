import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTx;

  const TransactionList({required transactions, required deleteTx})
      : _transactions = transactions,
        _deleteTx = deleteTx;

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'lib/assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView(
            children: _transactions
                .map((_tx) => TransactionItem(
                      key: ValueKey(_tx.id),
                      transaction: _tx,
                      deleteTx: _deleteTx,
                    ))
                .toList(),
          );
  }
}
