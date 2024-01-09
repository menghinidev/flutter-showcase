// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slivershowcasestate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SliverShowcaseState {
  List<String> get items => throw _privateConstructorUsedError;
  SliverShowcaseView get view => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SliverShowcaseStateCopyWith<SliverShowcaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliverShowcaseStateCopyWith<$Res> {
  factory $SliverShowcaseStateCopyWith(
          SliverShowcaseState value, $Res Function(SliverShowcaseState) then) =
      _$SliverShowcaseStateCopyWithImpl<$Res, SliverShowcaseState>;
  @useResult
  $Res call({List<String> items, SliverShowcaseView view});
}

/// @nodoc
class _$SliverShowcaseStateCopyWithImpl<$Res, $Val extends SliverShowcaseState>
    implements $SliverShowcaseStateCopyWith<$Res> {
  _$SliverShowcaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? view = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as SliverShowcaseView,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SliverShowcaseStateImplCopyWith<$Res>
    implements $SliverShowcaseStateCopyWith<$Res> {
  factory _$$SliverShowcaseStateImplCopyWith(_$SliverShowcaseStateImpl value,
          $Res Function(_$SliverShowcaseStateImpl) then) =
      __$$SliverShowcaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> items, SliverShowcaseView view});
}

/// @nodoc
class __$$SliverShowcaseStateImplCopyWithImpl<$Res>
    extends _$SliverShowcaseStateCopyWithImpl<$Res, _$SliverShowcaseStateImpl>
    implements _$$SliverShowcaseStateImplCopyWith<$Res> {
  __$$SliverShowcaseStateImplCopyWithImpl(_$SliverShowcaseStateImpl _value,
      $Res Function(_$SliverShowcaseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? view = null,
  }) {
    return _then(_$SliverShowcaseStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as SliverShowcaseView,
    ));
  }
}

/// @nodoc

class _$SliverShowcaseStateImpl implements _SliverShowcaseState {
  _$SliverShowcaseStateImpl(
      {required final List<String> items, required this.view})
      : _items = items;

  final List<String> _items;
  @override
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final SliverShowcaseView view;

  @override
  String toString() {
    return 'SliverShowcaseState(items: $items, view: $view)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SliverShowcaseStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.view, view) || other.view == view));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), view);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SliverShowcaseStateImplCopyWith<_$SliverShowcaseStateImpl> get copyWith =>
      __$$SliverShowcaseStateImplCopyWithImpl<_$SliverShowcaseStateImpl>(
          this, _$identity);
}

abstract class _SliverShowcaseState implements SliverShowcaseState {
  factory _SliverShowcaseState(
      {required final List<String> items,
      required final SliverShowcaseView view}) = _$SliverShowcaseStateImpl;

  @override
  List<String> get items;
  @override
  SliverShowcaseView get view;
  @override
  @JsonKey(ignore: true)
  _$$SliverShowcaseStateImplCopyWith<_$SliverShowcaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
