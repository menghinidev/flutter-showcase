import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_viewport_overlay.dart';

class CameraViewportWidget extends ConsumerStatefulWidget {
  final CameraDescription camera;
  final Function(CameraController controller, CameraImage image) onImageProcessed;

  const CameraViewportWidget({
    super.key,
    required this.camera,
    required this.onImageProcessed,
  });

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
      controller = CameraController(
        widget.camera,
        resolutionPreset,
        imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
      );
      _initializeCamera();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null) return;
    if (!controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    _disposeCamera();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      await controller!.initialize();
      if (!mounted) return;
    } catch (e) {
      if (e is CameraException) log(e.code);
      return Future.value();
    }
    setState(() {});
    controller!.addListener(() => setState(() {}));
    controller!.startImageStream((image) => widget.onImageProcessed(controller!, image));
    return Future.value();
  }

  Future<void> _disposeCamera() async {
    if (controller != null) {
      await controller!.stopImageStream();
      controller!.dispose();
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) return Container();
    final mediaSize = MediaQuery.of(context).size;
    final scale = 1 / (controller!.value.aspectRatio * mediaSize.aspectRatio);
    return ClipRect(
      clipper: _MediaSizeClipper(mediaSize),
      child: Stack(
        children: [
          Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: CameraPreview(controller!),
          ),
          CameraViewportOverlay(
            flashMode: controller!.value.flashMode,
            onFlashChanged: (mode) => controller!.setFlashMode(mode),
            currentCamera: controller!.description,
            onCameraChanged: (value) => controller!.setDescription(value),
          ),
        ],
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
