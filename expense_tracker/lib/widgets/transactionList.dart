import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  late final List<Transaction> _userTransactions;

  TransactionList({required userTransactions})
      : _userTransactions = userTransactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _userTransactions.map((tx) {
        return Card(
          elevation: 10,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.deepOrange,
                  ),
                ),
                child: Text(
                  '₹ ${tx.amount}',
                  style: TextStyle(
                    color: Colors.deepOrange[900],
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(tx.date),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
