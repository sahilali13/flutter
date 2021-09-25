import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  late final List<Transaction> _userTransactions;
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
                  SizedBox(
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
                            style: _themeContext.textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransactions[_index].title,
                      style: _themeContext.textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('dd-MM-yyyy').format(
                        _userTransactions[_index].date,
                      ),
                    ),
                    trailing: _mediaQuery.size.width > 400
                        ? TextButton.icon(
                            onPressed: () =>
                                _deleteTx(_userTransactions[_index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  _themeContext.errorColor),
                              textStyle: MaterialStateProperty.all<TextStyle?>(
                                _themeContext.textTheme.headline6,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () =>
                                _deleteTx(_userTransactions[_index].id),
                            icon: Icon(Icons.delete),
                            color: _themeContext.errorColor,
                          ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
