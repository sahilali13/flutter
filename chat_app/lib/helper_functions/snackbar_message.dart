import 'package:flutter/material.dart';

void showError({
  required String errorMessage,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      backgroundColor: Theme.of(context).errorColor,
      duration: const Duration(seconds: 1),
    ),
  );
}

void showSuccess({
  required String message,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      duration: const Duration(seconds: 1),
    ),
  );
}
