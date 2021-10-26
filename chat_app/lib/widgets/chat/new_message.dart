import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    final _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      final _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser.uid)
          .get();
      FirebaseFirestore.instance.collection('chat').add({
        'text': _enteredMessage,
        'creationTime': Timestamp.now(),
        'userId': _currentUser.uid,
        'username': _userData['username'],
        'profile_image_url': _userData['profile_image_url']
      });
    }
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Send a message...',
              ),
              onChanged: (_value) {
                setState(() {
                  _enteredMessage = _value;
                });
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
