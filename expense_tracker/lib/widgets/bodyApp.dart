import 'package:expense_tracker/widgets/userTransaction.dart';
import 'package:flutter/material.dart';

import './chart.dart';

class BodyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Chart(),
      UserTransaction(),
    ]);
  }
}
