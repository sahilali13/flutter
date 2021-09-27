import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTx;

  const NewTransaction(this._addTx);

  @override
  State<NewTransaction> createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late final _themeContext = Theme.of(context);
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

  late final _mediaQueryContext = MediaQuery.of(context);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: _mediaQueryContext.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autofocus: true,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                autofocus: true,
                autocorrect: true,
                decoration: const InputDecoration(
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
                  AdaptiveTextButton('Choose Date', _datePicker),
                ],
              ),
              ElevatedButton(
                onPressed: () => _submitData,
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: _themeContext.textTheme.button!.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
