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

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'creationTime': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
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
