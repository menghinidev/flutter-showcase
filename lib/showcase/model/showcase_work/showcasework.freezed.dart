// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'showcasework.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShowcaseWork {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  List<ShowcaseWorkBadge> get badges => throw _privateConstructorUsedError;
  String? get detailsUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShowcaseWorkCopyWith<ShowcaseWork> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowcaseWorkCopyWith<$Res> {
  factory $ShowcaseWorkCopyWith(
          ShowcaseWork value, $Res Function(ShowcaseWork) then) =
      _$ShowcaseWorkCopyWithImpl<$Res, ShowcaseWork>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String imagePath,
      List<ShowcaseWorkBadge> badges,
      String? detailsUrl});
}

/// @nodoc
class _$ShowcaseWorkCopyWithImpl<$Res, $Val extends ShowcaseWork>
    implements $ShowcaseWorkCopyWith<$Res> {
  _$ShowcaseWorkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imagePath = null,
    Object? badges = null,
    Object? detailsUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<ShowcaseWorkBadge>,
      detailsUrl: freezed == detailsUrl
          ? _value.detailsUrl
          : detailsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShowcaseWorkImplCopyWith<$Res>
    implements $ShowcaseWorkCopyWith<$Res> {
  factory _$$ShowcaseWorkImplCopyWith(
          _$ShowcaseWorkImpl value, $Res Function(_$ShowcaseWorkImpl) then) =
      __$$ShowcaseWorkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String imagePath,
      List<ShowcaseWorkBadge> badges,
      String? detailsUrl});
}

/// @nodoc
class __$$ShowcaseWorkImplCopyWithImpl<$Res>
    extends _$ShowcaseWorkCopyWithImpl<$Res, _$ShowcaseWorkImpl>
    implements _$$ShowcaseWorkImplCopyWith<$Res> {
  __$$ShowcaseWorkImplCopyWithImpl(
      _$ShowcaseWorkImpl _value, $Res Function(_$ShowcaseWorkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imagePath = null,
    Object? badges = null,
    Object? detailsUrl = freezed,
  }) {
    return _then(_$ShowcaseWorkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      badges: null == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<ShowcaseWorkBadge>,
      detailsUrl: freezed == detailsUrl
          ? _value.detailsUrl
          : detailsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ShowcaseWorkImpl implements _ShowcaseWork {
  _$ShowcaseWorkImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.imagePath,
      required final List<ShowcaseWorkBadge> badges,
      this.detailsUrl})
      : _badges = badges;

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String imagePath;
  final List<ShowcaseWorkBadge> _badges;
  @override
  List<ShowcaseWorkBadge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  @override
  final String? detailsUrl;

  @override
  String toString() {
    return 'ShowcaseWork(id: $id, title: $title, description: $description, imagePath: $imagePath, badges: $badges, detailsUrl: $detailsUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowcaseWorkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.detailsUrl, detailsUrl) ||
                other.detailsUrl == detailsUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      imagePath, const DeepCollectionEquality().hash(_badges), detailsUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowcaseWorkImplCopyWith<_$ShowcaseWorkImpl> get copyWith =>
      __$$ShowcaseWorkImplCopyWithImpl<_$ShowcaseWorkImpl>(this, _$identity);
}

abstract class _ShowcaseWork implements ShowcaseWork {
  factory _ShowcaseWork(
      {required final String id,
      required final String title,
      required final String description,
      required final String imagePath,
      required final List<ShowcaseWorkBadge> badges,
      final String? detailsUrl}) = _$ShowcaseWorkImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get imagePath;
  @override
  List<ShowcaseWorkBadge> get badges;
  @override
  String? get detailsUrl;
  @override
  @JsonKey(ignore: true)
  _$$ShowcaseWorkImplCopyWith<_$ShowcaseWorkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ShowcaseWorkBadge {
  String get label => throw _privateConstructorUsedError;
  String? get navigateToUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShowcaseWorkBadgeCopyWith<ShowcaseWorkBadge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowcaseWorkBadgeCopyWith<$Res> {
  factory $ShowcaseWorkBadgeCopyWith(
          ShowcaseWorkBadge value, $Res Function(ShowcaseWorkBadge) then) =
      _$ShowcaseWorkBadgeCopyWithImpl<$Res, ShowcaseWorkBadge>;
  @useResult
  $Res call({String label, String? navigateToUrl});
}

/// @nodoc
class _$ShowcaseWorkBadgeCopyWithImpl<$Res, $Val extends ShowcaseWorkBadge>
    implements $ShowcaseWorkBadgeCopyWith<$Res> {
  _$ShowcaseWorkBadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? navigateToUrl = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      navigateToUrl: freezed == navigateToUrl
          ? _value.navigateToUrl
          : navigateToUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShowcaseWorkBadgeImplCopyWith<$Res>
    implements $ShowcaseWorkBadgeCopyWith<$Res> {
  factory _$$ShowcaseWorkBadgeImplCopyWith(_$ShowcaseWorkBadgeImpl value,
          $Res Function(_$ShowcaseWorkBadgeImpl) then) =
      __$$ShowcaseWorkBadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String? navigateToUrl});
}

/// @nodoc
class __$$ShowcaseWorkBadgeImplCopyWithImpl<$Res>
    extends _$ShowcaseWorkBadgeCopyWithImpl<$Res, _$ShowcaseWorkBadgeImpl>
    implements _$$ShowcaseWorkBadgeImplCopyWith<$Res> {
  __$$ShowcaseWorkBadgeImplCopyWithImpl(_$ShowcaseWorkBadgeImpl _value,
      $Res Function(_$ShowcaseWorkBadgeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? navigateToUrl = freezed,
  }) {
    return _then(_$ShowcaseWorkBadgeImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      navigateToUrl: freezed == navigateToUrl
          ? _value.navigateToUrl
          : navigateToUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ShowcaseWorkBadgeImpl implements _ShowcaseWorkBadge {
  _$ShowcaseWorkBadgeImpl({required this.label, this.navigateToUrl});

  @override
  final String label;
  @override
  final String? navigateToUrl;

  @override
  String toString() {
    return 'ShowcaseWorkBadge(label: $label, navigateToUrl: $navigateToUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowcaseWorkBadgeImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.navigateToUrl, navigateToUrl) ||
                other.navigateToUrl == navigateToUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, navigateToUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowcaseWorkBadgeImplCopyWith<_$ShowcaseWorkBadgeImpl> get copyWith =>
      __$$ShowcaseWorkBadgeImplCopyWithImpl<_$ShowcaseWorkBadgeImpl>(
          this, _$identity);
}

abstract class _ShowcaseWorkBadge implements ShowcaseWorkBadge {
  factory _ShowcaseWorkBadge(
      {required final String label,
      final String? navigateToUrl}) = _$ShowcaseWorkBadgeImpl;

  @override
  String get label;
  @override
  String? get navigateToUrl;
  @override
  @JsonKey(ignore: true)
  _$$ShowcaseWorkBadgeImplCopyWith<_$ShowcaseWorkBadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
