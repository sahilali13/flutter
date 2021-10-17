import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart({required recentTransactions})
      : _recentTransactions = recentTransactions {}

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (_index) {
      final _weekDay = DateTime.now().subtract(
        Duration(days: _index),
      );
      var _totalSum = 0.0;

      for (var _index = 0; _index < _recentTransactions.length; _index++) {
        if (_recentTransactions[_index].date.day == _weekDay.day &&
            _recentTransactions[_index].date.month == _weekDay.month &&
            _recentTransactions[_index].date.year == _weekDay.year) {
          _totalSum += _recentTransactions[_index].amount;
        }
      }

      return {
        'day': DateFormat.E().format(_weekDay).substring(0, 1),
        'amount': _totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (_sum, _item) {
      return _sum + _item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((_data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: _data['day'],
                spendingAmount: _data['amount'],
                spendingPctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (_data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
