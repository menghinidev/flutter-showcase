import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/utils/loader/loading_widget.dart';

extension AsyncValueExtension<T> on AsyncValue<T> {
  Widget loadUntil({required Widget Function(T value) data}) => when(
        data: data,
        error: (_, __) => const Text('Error'),
        loading: () => const LoadingWidget(),
      );
}
