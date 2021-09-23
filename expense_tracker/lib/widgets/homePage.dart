import 'package:expense_tracker/widgets/newTransaction.dart';
import 'package:flutter/material.dart';

import '../widgets/chart.dart';
import './transactionList.dart';
import '../models/transaction.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((_element) {
      return _element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String _title, double _amount, DateTime _chosenDate) {
    final _newTx = Transaction(
      id: DateTime.now().toString(),
      title: _title,
      amount: _amount,
      date: _chosenDate,
    );

    setState(() {
      _userTransactions.add(_newTx);
    });
  }

  void _startAddNewTransaction(BuildContext _ctx) {
    showModalBottomSheet(
      context: _ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            addTx: _addNewTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransactions(String _id) {
    setState(() {
      _userTransactions.removeWhere(
        (_tx) => _tx.id == _id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Expense Tracker',
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(
            Icons.add,
            size: 33,
          ),
        )
      ],
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                  value: _showChart,
                  onChanged: (_val) {
                    setState(() {
                      _showChart = _val;
                    });
                  },
                ),
              ],
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransactions),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: TransactionList(
                      _userTransactions,
                      _deleteTransactions,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
