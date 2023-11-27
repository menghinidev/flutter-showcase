import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'loader/loading_widget.dart';

extension AsyncValueExtension<T> on AsyncValue<T> {
  Widget loadUntil({required Widget Function(T value) data}) => when(
        data: data,
        error: (_, __) => const Text('Error'),
        loading: () => const LoadingWidget(),
      );
}
