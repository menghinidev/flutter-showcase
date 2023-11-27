import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_viewport_overlay.dart';

class CameraViewportWidget extends ConsumerStatefulWidget {
  final CameraDescription camera;
  const CameraViewportWidget({super.key, required this.camera});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraViewportWidgetState();
}

class _CameraViewportWidgetState extends ConsumerState<CameraViewportWidget> with WidgetsBindingObserver {
  CameraController? controller;
  final resolutionPreset = ResolutionPreset.medium;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller = CameraController(widget.camera, resolutionPreset);
      _initializeCamera();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null) return;
    if (!controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    if (controller != null) controller!.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      await controller!.initialize();
      if (!mounted) return;
      setState(() {});
      controller!.addListener(() {
        setState(() {});
      });
    } catch (e) {
      if (e is CameraException) {
        print(e.code);
      }
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) return Container();
    return CameraPreview(
      controller!,
      child: CameraViewportOverlay(
        currentCamera: controller!.description,
        onCameraChanged: (value) => controller!.setDescription(value),
      ),
    );
  }
}
