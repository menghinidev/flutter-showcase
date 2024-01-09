// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocrscannerstate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OcrScannerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cameraAquisition,
    required TResult Function(File image) cropping,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cameraAquisition,
    TResult? Function(File image)? cropping,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cameraAquisition,
    TResult Function(File image)? cropping,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) cameraAquisition,
    required TResult Function(Cropping value) cropping,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? cameraAquisition,
    TResult? Function(Cropping value)? cropping,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? cameraAquisition,
    TResult Function(Cropping value)? cropping,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OcrScannerStateCopyWith<$Res> {
  factory $OcrScannerStateCopyWith(
          OcrScannerState value, $Res Function(OcrScannerState) then) =
      _$OcrScannerStateCopyWithImpl<$Res, OcrScannerState>;
}

/// @nodoc
class _$OcrScannerStateCopyWithImpl<$Res, $Val extends OcrScannerState>
    implements $OcrScannerStateCopyWith<$Res> {
  _$OcrScannerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OcrScannerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements Initial {
  _$InitialImpl();

  @override
  String toString() {
    return 'OcrScannerState.cameraAquisition()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cameraAquisition,
    required TResult Function(File image) cropping,
  }) {
    return cameraAquisition();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cameraAquisition,
    TResult? Function(File image)? cropping,
  }) {
    return cameraAquisition?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cameraAquisition,
    TResult Function(File image)? cropping,
    required TResult orElse(),
  }) {
    if (cameraAquisition != null) {
      return cameraAquisition();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) cameraAquisition,
    required TResult Function(Cropping value) cropping,
  }) {
    return cameraAquisition(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? cameraAquisition,
    TResult? Function(Cropping value)? cropping,
  }) {
    return cameraAquisition?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? cameraAquisition,
    TResult Function(Cropping value)? cropping,
    required TResult orElse(),
  }) {
    if (cameraAquisition != null) {
      return cameraAquisition(this);
    }
    return orElse();
  }
}

abstract class Initial implements OcrScannerState {
  factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$CroppingImplCopyWith<$Res> {
  factory _$$CroppingImplCopyWith(
          _$CroppingImpl value, $Res Function(_$CroppingImpl) then) =
      __$$CroppingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({File image});
}

/// @nodoc
class __$$CroppingImplCopyWithImpl<$Res>
    extends _$OcrScannerStateCopyWithImpl<$Res, _$CroppingImpl>
    implements _$$CroppingImplCopyWith<$Res> {
  __$$CroppingImplCopyWithImpl(
      _$CroppingImpl _value, $Res Function(_$CroppingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
  }) {
    return _then(_$CroppingImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$CroppingImpl implements Cropping {
  _$CroppingImpl({required this.image});

  @override
  final File image;

  @override
  String toString() {
    return 'OcrScannerState.cropping(image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CroppingImpl &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CroppingImplCopyWith<_$CroppingImpl> get copyWith =>
      __$$CroppingImplCopyWithImpl<_$CroppingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cameraAquisition,
    required TResult Function(File image) cropping,
  }) {
    return cropping(image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cameraAquisition,
    TResult? Function(File image)? cropping,
  }) {
    return cropping?.call(image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cameraAquisition,
    TResult Function(File image)? cropping,
    required TResult orElse(),
  }) {
    if (cropping != null) {
      return cropping(image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) cameraAquisition,
    required TResult Function(Cropping value) cropping,
  }) {
    return cropping(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? cameraAquisition,
    TResult? Function(Cropping value)? cropping,
  }) {
    return cropping?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? cameraAquisition,
    TResult Function(Cropping value)? cropping,
    required TResult orElse(),
  }) {
    if (cropping != null) {
      return cropping(this);
    }
    return orElse();
  }
}

abstract class Cropping implements OcrScannerState {
  factory Cropping({required final File image}) = _$CroppingImpl;

  File get image;
  @JsonKey(ignore: true)
  _$$CroppingImplCopyWith<_$CroppingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
