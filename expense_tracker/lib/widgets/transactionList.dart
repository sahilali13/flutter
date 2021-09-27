import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/list_item.dart';

// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  late Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _themeContext = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      child: _userTransactions.isEmpty
          ? LayoutBuilder(builder: (_ctx, _constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions Yet!!!',
                    style: _themeContext.textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: _constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView(
              children: _userTransactions
                  .map(
                    (_tx) => ListItem(
                      key: ValueKey(_tx.id),
                      transaction: _tx,
                      themeContext: _themeContext,
                      mediaQuery: _mediaQuery,
                      deleteTx: _deleteTx,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
