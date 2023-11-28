import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_permission_denied_widget.dart';

class CameraViewportWidget extends ConsumerStatefulWidget {
  final CameraDescription camera;
  final Widget Function(CameraController controller) overlayBuilder;
  final Function(CameraException error)? onPermissionDenied;
  final Function(CameraController controller, CameraImage image) onImageProcessed;

  const CameraViewportWidget({
    super.key,
    required this.camera,
    required this.overlayBuilder,
    required this.onImageProcessed,
    this.onPermissionDenied,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraViewportWidgetState();
}

class _CameraViewportWidgetState extends ConsumerState<CameraViewportWidget> with WidgetsBindingObserver {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller = CameraController(
        widget.camera,
        ResolutionPreset.medium,
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
    if (controller == null) return Future.value();
    try {
      await controller!.initialize();
      if (!mounted) return;
    } catch (e) {
      _disposeCamera();
      if (e is CameraException) {
        if (widget.onPermissionDenied != null) widget.onPermissionDenied!(e);
      }
      return Future.value();
    }
    _setState();
    controller!.addListener(_setState);
    controller!.startImageStream((image) => widget.onImageProcessed(controller!, image));
    return Future.value();
  }

  _setState() => setState(() {});

  Future<void> _disposeCamera() async {
    if (controller == null) return Future.value();
    if (controller!.value.isInitialized) {
      controller!.removeListener(_setState);
      await controller!.stopImageStream();
    }
    controller!.dispose();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) return const CameraPermissionDeniedWidget();
    return _FullscreenViewportScaler(
      cameraAspectRatio: controller!.value.aspectRatio,
      overlayWidget: widget.overlayBuilder(controller!),
      child: CameraPreview(controller!),
    );
  }
}

class _FullscreenViewportScaler extends StatelessWidget {
  final Widget child;
  final double cameraAspectRatio;
  final Widget overlayWidget;

  const _FullscreenViewportScaler({
    required this.child,
    required this.cameraAspectRatio,
    required this.overlayWidget,
  });

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    final scale = 1 / (cameraAspectRatio * mediaSize.aspectRatio);
    return ClipRect(
      clipper: _FullscreenViewportSizeClipper(mediaSize),
      child: Stack(
        children: [
          Transform.scale(scale: scale, alignment: Alignment.topCenter, child: child),
          overlayWidget,
        ],
      ),
    );
  }
}

class _FullscreenViewportSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _FullscreenViewportSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
