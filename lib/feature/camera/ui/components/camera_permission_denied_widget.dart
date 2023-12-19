import 'package:flutter/material.dart';

class CameraPermissionDeniedWidget extends StatelessWidget {
  const CameraPermissionDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Enable camera access to proceed'));
  }
}
