import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/utils/loader/loading_widget.dart';
import 'package:sandbox/utils/permission_handler/permission_manager.dart';

mixin CameraImageFormatProvider {
  ImageFormatGroup? get platformFormat {
    if (Platform.isAndroid) return ImageFormatGroup.nv21;
    if (Platform.isIOS) return ImageFormatGroup.bgra8888;
    return null;
  }
}

class CameraViewportWidget extends ConsumerStatefulWidget {
  const CameraViewportWidget({
    required this.resolution,
    required this.camera,
    required this.overlayBuilder,
    required this.onPermissionDenied,
    super.key,
    this.onImageProcessed,
  });
  final ResolutionPreset resolution;
  final CameraDescription camera;
  final Widget Function(CameraController controller) overlayBuilder;
  final void Function() onPermissionDenied;
  final Future<void> Function(
    CameraController controller,
    CameraImage image,
  )? onImageProcessed;

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
    final permissionManager = ref.read(permissionManagerProvider);
    final hasCameraAccess = await permissionManager.askForCameraAccess();
    if (!hasCameraAccess) return widget.onPermissionDenied();
    final hasMicrophoneAccess = await permissionManager.askForMicrophoneAccess();
    if (!hasMicrophoneAccess) return widget.onPermissionDenied();
    controller = CameraController(
      widget.camera,
      widget.resolution,
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
      return const LoadingWidget();
    }
    return _FullscreenViewportScaler(
      cameraAspectRatio: controller!.value.aspectRatio,
      overlayWidget: widget.overlayBuilder(controller!),
      child: CameraPreview(controller!),
    );
  }
}

class _FullscreenViewportScaler extends StatelessWidget {
  const _FullscreenViewportScaler({
    required this.child,
    required this.cameraAspectRatio,
    required this.overlayWidget,
  });
  final Widget child;
  final double cameraAspectRatio;
  final Widget overlayWidget;

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
  const _FullscreenViewportSizeClipper(this.mediaSize);
  final Size mediaSize;
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
