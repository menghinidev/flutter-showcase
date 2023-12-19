import 'package:flutter/material.dart';

mixin DialogManager {
  Future<T?> showSuccessDialog<T>(
    BuildContext context, {
    required String text,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Operazione completata'),
          content: Text(text),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),
            ),
          ],
        ),
      );

  Future<T?> showWarningDialog<T>(
    BuildContext context, {
    required String text,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Attenzione'),
          content: Text(text),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),
            ),
          ],
        ),
      );
}
