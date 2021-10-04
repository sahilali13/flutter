import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductItem({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            color: _themeContext.colorScheme.primary,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: _themeContext.errorColor,
          )
        ],
      ),
    );
  }
}
