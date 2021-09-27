import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/newTransaction.dart';
import '../widgets/chart.dart';
import '../widgets/transactionList.dart';
import '../models/transaction.dart';

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
            _addNewTransaction,
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

  Column _buildLandscape(
    ThemeData _themeContext,
    PreferredSizeWidget _appBar,
    Container _listOfTransactions,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Show Chart',
              style: _themeContext.textTheme.headline6,
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
    );
  }

  Column _buildPortrait(
    PreferredSizeWidget _appBar,
    Container _listOfTransactions,
  ) {
    return Column(
      children: [
        Container(
          height: (_mediaContext.size.height -
                  _appBar.preferredSize.height -
                  _mediaContext.padding.top) *
              0.3,
          child: Chart(_recentTransactions),
        ),
        _listOfTransactions
      ],
    );
  }

  AppBar _buildMaterialNavBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Expense Tracker',
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(
            Icons.add,
            size: 33,
          ),
        )
      ],
    );
  }

  CupertinoNavigationBar _buildCupertinoNavBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: const Text(
        'Expense Tracker',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: const Icon(
              CupertinoIcons.add,
            ),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape = _mediaContext.orientation == Orientation.landscape;
    final PreferredSizeWidget _appBar = Platform.isIOS
        ? _buildCupertinoNavBar(context)
        : _buildMaterialNavBar(context) as PreferredSizeWidget;
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
            if (_isLandscape)
              _buildLandscape(
                _themeContext,
                _appBar,
                _listOfTransactions,
              ),
            if (!_isLandscape)
              _buildPortrait(
                _appBar,
                _listOfTransactions,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: _appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
            appBar: _appBar,
            body: _pageBody,
          );
  }
}
