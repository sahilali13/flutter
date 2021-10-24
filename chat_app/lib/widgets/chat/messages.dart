import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/helpers/snackbar_message.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'creationTime',
            descending: true,
          )
          .snapshots(),
      builder: (_ctx, _chatSnapshot) {
        if (_chatSnapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (_chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: AdaptiveCircularProgressIndicator(),
          );
        }
        final _chatDocs = _chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: _chatDocs.length,
          itemBuilder: (_ctx, _index) => MessageBubble(
            message: _chatDocs[_index]['text'],
            isMe: FirebaseAuth.instance.currentUser!.uid ==
                _chatDocs[_index]['userId'],
            key: ValueKey(
              _chatDocs[_index].id,
            ),
          ),
        );
      },
    );
  }
}
