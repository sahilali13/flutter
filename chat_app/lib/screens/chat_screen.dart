import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:chat_app/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baatein Karo'),
        actions: <Widget>[
          DropdownButton(
            borderRadius: BorderRadius.circular(8.0),
            icon: Icon(
              Icons.more_vert_rounded,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'Logout',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const Text('Logout'),
                  ],
                ),
              ),
            ],
            onChanged: (_itemIdentifier) async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: Messages(),
          ),
          NewMessage()
        ],
      ),
    );
  }
}
