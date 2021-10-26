import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:chat_app/widgets/chat/messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void _handleMessage(RemoteMessage _message) {}

  Future<void> _setupInteractedMessage() async {
    RemoteMessage? _initialMessage = await _messaging.getInitialMessage();
    if (_initialMessage != null) {
      _handleMessage(_initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  @override
  void initState() {
    super.initState();
    _setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baatein Karo'),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
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
