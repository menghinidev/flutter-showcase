import 'package:flutter/material.dart';

class AcquireImageButton extends StatelessWidget {
  const AcquireImageButton({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.camera),
      label: const Text('Scatta una foto'),
    );
  }
}
