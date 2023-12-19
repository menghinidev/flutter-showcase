import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/utils/permission_handler/permission_manager.dart';

import '../../application/camera_image_format.dart';
import 'camera_permission_denied_widget.dart';

class CameraViewportWidget extends ConsumerStatefulWidget {
  final CameraDescription camera;
  final Widget Function(CameraController controller) overlayBuilder;
  final Function() onPermissionDenied;
  final Future Function(
    CameraController controller,
    CameraImage image,
  )? onImageProcessed;

  const CameraViewportWidget({
    super.key,
    required this.camera,
    required this.overlayBuilder,
    required this.onPermissionDenied,
    this.onImageProcessed,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraViewportWidgetState();
}

class _CameraViewportWidgetState extends ConsumerState<CameraViewportWidget>
    with WidgetsBindingObserver, CameraImageFormatProvider {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initializeCameraController();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null) return;
    if (!controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController();
    }
  }

  Future<void> _initializeCameraController() async {
    var permissionManager = ref.read(permissionManagerProvider);
    var hasCameraAccess = await permissionManager.askForCameraAccess();
    if (!hasCameraAccess) return widget.onPermissionDenied();
    var hasMicrophoneAccess = await permissionManager.askForMicrophoneAccess();
    if (!hasMicrophoneAccess) return widget.onPermissionDenied();
    controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      imageFormatGroup: platformFormat,
    );
    controller!.addListener(_setState);
    try {
      await controller!.initialize();
      await controller!.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      _logCameraExpection(e);
    }
    try {
      await _startImageStream();
    } on CameraException catch (e) {
      _logCameraExpection(e);
      await _stopImageStream();
      await _startImageStream();
    }
    _setState();
  }

  Future<void> _stopImageStream() {
    if (widget.onImageProcessed != null) return controller!.stopImageStream();
    return Future.value();
  }

  Future<void> _startImageStream() {
    return controller!.startImageStream(
      (image) {
        if (mounted && widget.onImageProcessed != null) {
          widget.onImageProcessed!(controller!, image);
        }
      },
    );
  }

  void _setState() {
    if (!mounted) return;
    setState(() {});
  }

  void _logCameraExpection(CameraException exception) {
    switch (exception.code) {
      case 'CameraAccessDenied':
        log('You have denied camera access.');
        widget.onPermissionDenied();
        break;
      case 'CameraAccessDeniedWithoutPrompt':
        // iOS only
        log('Please go to Settings app to enable camera access.');
        break;
      case 'CameraAccessRestricted':
        // iOS only
        log('Camera access is restricted.');
        break;
      case 'AudioAccessDenied':
        log('You have denied audio access.');
        break;
      case 'AudioAccessDeniedWithoutPrompt':
        // iOS only
        log('Please go to Settings app to enable audio access.');
        break;
      case 'AudioAccessRestricted':
        // iOS only
        log('Audio access is restricted.');
        break;
      default:
        log(exception.toString());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) {
      return const CameraPermissionDeniedWidget();
    }
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
          Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: child,
          ),
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
