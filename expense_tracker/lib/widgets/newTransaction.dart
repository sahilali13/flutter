import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  late final Function _addTx;

  NewTransaction({required addTx}) : _addTx = addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _chosenDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(
      _amountController.text,
    );

    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _chosenDate == null) {
      return;
    }

    widget._addTx(
      _enteredTitle,
      _enteredAmount,
      _chosenDate,
    );

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((_pickedDate) {
      if (_pickedDate == null) {
        return;
      }
      setState(() {
        _chosenDate = _pickedDate;
      });
    });
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
              onSubmitted: (_) => _submitData(),
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
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _chosenDate == null
                        ? 'No Date Chosen'
                        : 'Date Chosen: ${DateFormat('dd-MM-yyyy').format(_chosenDate!)}',
                  ),
                ),
                TextButton(
                  onPressed: _datePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () => _submitData,
              child: Text(
                'Done',
                style: TextStyle(
                  color: Theme.of(context).textTheme.button!.color,
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
