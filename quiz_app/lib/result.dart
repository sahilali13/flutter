import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _resultScore;
  final void Function()? _resetHandler;

  const Result({Key? key, resultScore, resetHandler})
      : _resultScore = resultScore,
        _resetHandler = resetHandler,
        super(key: key);

  String get resultPhrase {
    String _resultText;
    if (_resultScore <= 8) {
      _resultText = 'You are awesome and innocent!';
    } else if (_resultScore <= 12) {
      _resultText = 'Pretty likeable!';
    } else if (_resultScore <= 16) {
      _resultText = 'You are ... strange?!';
    } else {
      _resultText = 'You are so bad!';
    }
    return _resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: _resetHandler,
            child: const Text('Restart Quiz!'),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color?>(
              Colors.blue,
            )),
          ),
        ],
      ),
    );
  }
}
