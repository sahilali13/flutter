import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  late final List<Transaction> _userTransactions;

  TransactionList(this._userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 500,
      child: _userTransactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions Yet!!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 450,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, _index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            '\$${_userTransactions[_index].amount}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransactions[_index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('dd-MM-yyyy').format(
                        _userTransactions[_index].date,
                      ),
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
