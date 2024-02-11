import 'package:flutter/material.dart';

class DeviceLayoutDelegate extends StatelessWidget {
  const DeviceLayoutDelegate({required this.onMobile, this.onDesktop, this.onTablet, super.key});
  final Widget Function(BuildContext context)? onDesktop;
  final Widget Function(BuildContext context)? onTablet;
  final Widget Function(BuildContext context) onMobile;

  static const double mobileThreshold = 600;
  static const double tabletThreshold = 860;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileThreshold) {
      return onMobile(context);
    } else if (width <= tabletThreshold) {
      if (onTablet != null) onTablet?.call(context);
      return onMobile(context);
    } else if (width > tabletThreshold && onDesktop != null) {
      return onDesktop!(context);
    }
    return onMobile(context);
  }
}

class DesktopSizeWrapper extends StatelessWidget {
  const DesktopSizeWrapper({
    required this.child,
    this.alignment = Alignment.center,
    this.customThreshold = DeviceLayoutDelegate.tabletThreshold,
    super.key,
  });
  final Widget child;
  final Alignment alignment;
  final double customThreshold;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        constraints: BoxConstraints(maxWidth: customThreshold),
        child: Align(alignment: alignment, child: child),
      ),
    );
  }
}

extension DeviceLayoutExtension on MediaQueryData {
  T onLayout<T>({required T defaultValue, T? onMobile, T? onTablet, T? onDesktop}) {
    final width = size.width;
    if (width <= DeviceLayoutDelegate.mobileThreshold && onMobile != null) {
      return onMobile;
    } else if (width <= DeviceLayoutDelegate.tabletThreshold && onTablet != null) {
      return onTablet;
    } else if (width > DeviceLayoutDelegate.tabletThreshold && onDesktop != null) {
      return onDesktop;
    }
    return defaultValue;
  }
}
