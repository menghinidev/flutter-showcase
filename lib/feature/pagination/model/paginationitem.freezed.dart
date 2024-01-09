// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginationitem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PaginationItem {
  int get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginationItemCopyWith<PaginationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationItemCopyWith<$Res> {
  factory $PaginationItemCopyWith(
          PaginationItem value, $Res Function(PaginationItem) then) =
      _$PaginationItemCopyWithImpl<$Res, PaginationItem>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$PaginationItemCopyWithImpl<$Res, $Val extends PaginationItem>
    implements $PaginationItemCopyWith<$Res> {
  _$PaginationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationItemImplCopyWith<$Res>
    implements $PaginationItemCopyWith<$Res> {
  factory _$$PaginationItemImplCopyWith(_$PaginationItemImpl value,
          $Res Function(_$PaginationItemImpl) then) =
      __$$PaginationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$PaginationItemImplCopyWithImpl<$Res>
    extends _$PaginationItemCopyWithImpl<$Res, _$PaginationItemImpl>
    implements _$$PaginationItemImplCopyWith<$Res> {
  __$$PaginationItemImplCopyWithImpl(
      _$PaginationItemImpl _value, $Res Function(_$PaginationItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$PaginationItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PaginationItemImpl implements _PaginationItem {
  _$PaginationItemImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'PaginationItem(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationItemImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationItemImplCopyWith<_$PaginationItemImpl> get copyWith =>
      __$$PaginationItemImplCopyWithImpl<_$PaginationItemImpl>(
          this, _$identity);
}

abstract class _PaginationItem implements PaginationItem {
  factory _PaginationItem({required final int id}) = _$PaginationItemImpl;

  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$PaginationItemImplCopyWith<_$PaginationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
