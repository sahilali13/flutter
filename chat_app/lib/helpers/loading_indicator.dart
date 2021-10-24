import 'package:flutter/material.dart';

class AdaptiveCircularProgressIndicator extends StatelessWidget {
  const AdaptiveCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
