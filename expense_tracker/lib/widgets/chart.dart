import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransaction;

  const Chart(this._recentTransaction);

  List<Map<String, dynamic>> get _groupedTransactions {
    return List.generate(7, (_index) {
      final _weekDay = DateTime.now().subtract(
        Duration(days: _index),
      );
      var _totalSum = 0.0;
      for (var i = 0; i < _recentTransaction.length; i++) {
        if (_recentTransaction[i].date.day == _weekDay.day &&
            _recentTransaction[i].date.month == _weekDay.month &&
            _recentTransaction[i].date.year == _weekDay.year) {
          _totalSum += _recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(_weekDay).substring(0, 1),
        'amount': _totalSum,
      };
    }).reversed.toList();
  }

  double get _totalSpending {
    return _groupedTransactions.fold(0.0, (_sum, _item) {
      return _sum + _item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.map((_data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                _data['day'],
                _data['amount'],
                _totalSpending == 0.0 ? 0.0 : _data['amount'] / _totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
