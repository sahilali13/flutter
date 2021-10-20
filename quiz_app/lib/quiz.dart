import 'package:flutter/material.dart';

import '../question.dart';
import '../answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> _questions;
  final int _questionIndex;
  final Function _answerQuestion;

  const Quiz({
    Key? key,
    required questions,
    required answerQuestion,
    required questionIndex,
  })  : _questions = questions,
        _answerQuestion = answerQuestion,
        _questionIndex = questionIndex,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questionText: _questions[_questionIndex]['questionText'],
        ),
        ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            selectHandler: () => _answerQuestion(score: answer['score']),
            answerText: answer['text'],
          );
        }).toList()
      ],
    );
  }
}
