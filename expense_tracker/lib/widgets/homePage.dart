import 'package:expense_tracker/widgets/newTransaction.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/chart.dart';
import './transactionList.dart';
import '../models/transaction.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  late final _mediaContext = MediaQuery.of(context);

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
    final _isLandscape = _mediaContext.orientation == Orientation.landscape;
    final ObstructingPreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expense Tracker',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                  ),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
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
          ) as ObstructingPreferredSizeWidget;
    final _listOfTransactions = Container(
      height: (_mediaContext.size.height -
              _appBar.preferredSize.height -
              _mediaContext.padding.top) *
          0.7,
      child: TransactionList(
        _userTransactions,
        _deleteTransactions,
      ),
    );
    final _themeContext = Theme.of(context);
    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (!_isLandscape)
              Container(
                height: (_mediaContext.size.height -
                        _appBar.preferredSize.height -
                        _mediaContext.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandscape) _listOfTransactions,
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    activeColor: _themeContext.colorScheme.secondary,
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
                    height: (_mediaContext.size.height -
                            _appBar.preferredSize.height -
                            _mediaContext.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                : _listOfTransactions,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: _appBar,
          )
        : Scaffold(
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(
                      Icons.add,
                    ),
                  ),
            appBar: _appBar,
            body: _pageBody,
          );
  }
}
