// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalendarDetailState {
  bool get isAuth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarDetailStateCopyWith<CalendarDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarDetailStateCopyWith<$Res> {
  factory $CalendarDetailStateCopyWith(
          CalendarDetailState value, $Res Function(CalendarDetailState) then) =
      _$CalendarDetailStateCopyWithImpl<$Res, CalendarDetailState>;
  @useResult
  $Res call({bool isAuth});
}

/// @nodoc
class _$CalendarDetailStateCopyWithImpl<$Res, $Val extends CalendarDetailState>
    implements $CalendarDetailStateCopyWith<$Res> {
  _$CalendarDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuth = null,
  }) {
    return _then(_value.copyWith(
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarDetailStateImplCopyWith<$Res>
    implements $CalendarDetailStateCopyWith<$Res> {
  factory _$$CalendarDetailStateImplCopyWith(_$CalendarDetailStateImpl value,
          $Res Function(_$CalendarDetailStateImpl) then) =
      __$$CalendarDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isAuth});
}

/// @nodoc
class __$$CalendarDetailStateImplCopyWithImpl<$Res>
    extends _$CalendarDetailStateCopyWithImpl<$Res, _$CalendarDetailStateImpl>
    implements _$$CalendarDetailStateImplCopyWith<$Res> {
  __$$CalendarDetailStateImplCopyWithImpl(_$CalendarDetailStateImpl _value,
      $Res Function(_$CalendarDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuth = null,
  }) {
    return _then(_$CalendarDetailStateImpl(
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CalendarDetailStateImpl extends _CalendarDetailState {
  const _$CalendarDetailStateImpl({this.isAuth = false}) : super._();

  @override
  @JsonKey()
  final bool isAuth;

  @override
  String toString() {
    return 'CalendarDetailState(isAuth: $isAuth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarDetailStateImpl &&
            (identical(other.isAuth, isAuth) || other.isAuth == isAuth));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAuth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarDetailStateImplCopyWith<_$CalendarDetailStateImpl> get copyWith =>
      __$$CalendarDetailStateImplCopyWithImpl<_$CalendarDetailStateImpl>(
          this, _$identity);
}

abstract class _CalendarDetailState extends CalendarDetailState {
  const factory _CalendarDetailState({final bool isAuth}) =
      _$CalendarDetailStateImpl;
  const _CalendarDetailState._() : super._();

  @override
  bool get isAuth;
  @override
  @JsonKey(ignore: true)
  _$$CalendarDetailStateImplCopyWith<_$CalendarDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
