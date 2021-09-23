import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late final String _label;
  late final double _spendingAmount;
  late final double _spendingPctOfTotal;

  ChartBar(this._label, this._spendingAmount, this._spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_ctx, _constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: _constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$${_spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: _constraints.maxHeight * 0.05,
            ),
            Container(
              height: _constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: _spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _constraints.maxHeight * 0.05,
            ),
            Container(
              height: _constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  _label,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
