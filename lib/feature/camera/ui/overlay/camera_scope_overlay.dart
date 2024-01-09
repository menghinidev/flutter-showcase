import 'package:flutter/material.dart';

class ScannerScope extends StatelessWidget {
  const ScannerScope.dataMatrix({super.key})
      : alignment = const Alignment(0, -0.25),
        aspectRatio = 16 / 9,
        color = const Color.fromRGBO(173, 216, 230, 0.5);

  const ScannerScope.qrCode({super.key})
      : alignment = Alignment.center,
        aspectRatio = 1,
        color = const Color.fromRGBO(173, 216, 230, 0.5);
  final Color color;
  final Alignment alignment;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color.withOpacity(0.8), BlendMode.srcOut), // This one will create the magic
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              backgroundBlendMode: BlendMode.dstOut,
            ), // This one will handle background + difference out
          ),
          Align(
            alignment: alignment,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
