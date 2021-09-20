import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  late final Function _addTx;

  NewTransaction({required addTx}) : _addTx = addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submitData() {
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(
      _amountController.text,
    );

    if (_enteredTitle.isEmpty || _enteredAmount <= 0) {
      return;
    }

    widget._addTx(
      _enteredTitle,
      _enteredAmount,
    );

    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              autofocus: true,
              autocorrect: true,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              onPressed: () => submitData,
              child: Text(
                'Done',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
