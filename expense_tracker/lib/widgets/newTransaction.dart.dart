import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  late final Function _addTx;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  NewTransaction({required addTx}) : _addTx = addTx;

  // void submitData() {
  //   final _enteredTitle = _titleController.text;
  //   final _enteredAmount = double.parse(_amountController.text);

  //   if (_enteredTitle.isEmpty || _enteredAmount <= 0) {
  //     print('Nope');
  //     return;
  //   }

  //   _addTx(
  //     _enteredTitle,
  //     _enteredAmount,
  //   );
  // }

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
              //onSubmitted: (_) => submitData(),
            ),
            TextField(
              autofocus: true,
              autocorrect: true,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              // keyboardType: TextInputType.numberWithOptions(
              //   decimal: true,
              // ),
              // onSubmitted: (_) => submitData(),
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
