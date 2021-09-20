import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  late final Function _addTx;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  NewTransaction({required addTx}) : _addTx = addTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autofocus: true,
              autocorrect: true,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
            ),
            TextField(
              autofocus: true,
              autocorrect: true,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
            ),
            TextButton(
              onPressed: () {
                _addTx(
                  _titleController.text,
                  double.parse(
                    _amountController.text,
                  ),
                );
              },
              child: Text(
                'Add Expanse',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
