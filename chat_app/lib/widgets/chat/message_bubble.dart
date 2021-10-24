import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final bool _isMe;

  const MessageBubble({Key? key, required message, required isMe})
      : _message = message,
        _isMe = isMe,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);
    return Row(
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: _isMe
                  ? Colors.grey[300]
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12.0),
                topRight: const Radius.circular(12.0),
                bottomLeft: _isMe
                    ? const Radius.circular(12.0)
                    : const Radius.circular(0),
                bottomRight: _isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12.0),
              )),
          width: 140,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          child: Text(
            _message,
            style: _themeContext.textTheme.headline6!.copyWith(
              color: _isMe
                  ? Colors.black87
                  : _themeContext.colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
