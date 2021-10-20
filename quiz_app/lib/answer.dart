import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final void Function()? _selectHandler;
  final String _answerText;

  const Answer({
    Key? key,
    selectHandler,
    answerText,
  })  : _answerText = answerText,
        _selectHandler = selectHandler,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _selectHandler,
        child: Text(_answerText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(
            Colors.blue,
          ),
          foregroundColor: MaterialStateProperty.all<Color?>(
            Colors.white,
          ),
        ),
      ),
    );
  }
}
