import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _collectionPath = 'chats/uBs60T8xO7ITHaBF271y/messages';

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
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(_collectionPath).snapshots(),
        builder: (_ctx, _snapshot) {
          if (_snapshot.hasError) {
            return const Text('Something went wrong');
          }
          var _document = _snapshot.data!.docs;
          return _snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView.builder(
                  itemCount: _document.length,
                  itemBuilder: (_ctx, _index) => Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_document[_index]['text']),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection(_collectionPath).add(
            {'text': 'Add Button'},
          );
        },
      ),
    );
  }
}
