import 'package:flutter/material.dart';

mixin UiUtility {
  Widget get mediumSliverDivider => SliverToBoxAdapter(child: mediumDivider);
  Widget get mediumDivider => const SizedBox.square(dimension: UiDimension.mediumSize);
  Widget get smallSliverDivider => SliverToBoxAdapter(child: smallDivider);
  Widget get smallDivider => const SizedBox.square(dimension: UiDimension.smallSize);
  double get elevation => 10;
  double get smallElevation => elevation / 2;
}

mixin UiDimension {
  static const mediumSize = 16.0;
  static const largeSize = 32.0;
  static const smallSize = 8.0;
  static const extraSmallSize = 4.0;

  EdgeInsets get extraSmallPadding => const EdgeInsets.all(extraSmallSize);
  EdgeInsets get smallPadding => const EdgeInsets.all(smallSize);
  EdgeInsets get smallHorizontalPadding => const EdgeInsets.symmetric(horizontal: smallSize);
  EdgeInsets get smallVerticalPadding => const EdgeInsets.symmetric(vertical: smallSize);
  EdgeInsets get mediumPadding => const EdgeInsets.all(mediumSize);
  EdgeInsets get mediumHorizontalPadding => const EdgeInsets.symmetric(horizontal: mediumSize);
  EdgeInsets get mediumVerticalPadding => const EdgeInsets.symmetric(vertical: mediumSize);
}

mixin UiShape {
  RoundedRectangleBorder get topRounded => const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(UiDimension.mediumSize)),
      );

  RoundedRectangleBorder get bottomRounded => const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(UiDimension.mediumSize)),
      );

  RoundedRectangleBorder get roundedShape => RoundedRectangleBorder(
        borderRadius: roundedBorderRadius,
      );

  BorderRadius get roundedBorderRadius => const BorderRadius.all(Radius.circular(UiDimension.mediumSize));
}

extension TextThemeProvider on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension TextStyleModifier on TextStyle? {
  TextStyle? get withGrayColor => this?.copyWith(color: Colors.grey);
  TextStyle? get withLightBlack => this?.copyWith(color: Colors.black54);
}
