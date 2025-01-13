// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'children_info_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChildrenInfoEditState {
  bool get haveRegistration => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChildrenInfoEditStateCopyWith<ChildrenInfoEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildrenInfoEditStateCopyWith<$Res> {
  factory $ChildrenInfoEditStateCopyWith(ChildrenInfoEditState value,
          $Res Function(ChildrenInfoEditState) then) =
      _$ChildrenInfoEditStateCopyWithImpl<$Res, ChildrenInfoEditState>;
  @useResult
  $Res call({bool haveRegistration, String? name, int? gender, int? age});
}

/// @nodoc
class _$ChildrenInfoEditStateCopyWithImpl<$Res,
        $Val extends ChildrenInfoEditState>
    implements $ChildrenInfoEditStateCopyWith<$Res> {
  _$ChildrenInfoEditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? haveRegistration = null,
    Object? name = freezed,
    Object? gender = freezed,
    Object? age = freezed,
  }) {
    return _then(_value.copyWith(
      haveRegistration: null == haveRegistration
          ? _value.haveRegistration
          : haveRegistration // ignore: cast_nullable_to_non_nullable
              as bool,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildrenInfoEditStateImplCopyWith<$Res>
    implements $ChildrenInfoEditStateCopyWith<$Res> {
  factory _$$ChildrenInfoEditStateImplCopyWith(
          _$ChildrenInfoEditStateImpl value,
          $Res Function(_$ChildrenInfoEditStateImpl) then) =
      __$$ChildrenInfoEditStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool haveRegistration, String? name, int? gender, int? age});
}

/// @nodoc
class __$$ChildrenInfoEditStateImplCopyWithImpl<$Res>
    extends _$ChildrenInfoEditStateCopyWithImpl<$Res,
        _$ChildrenInfoEditStateImpl>
    implements _$$ChildrenInfoEditStateImplCopyWith<$Res> {
  __$$ChildrenInfoEditStateImplCopyWithImpl(_$ChildrenInfoEditStateImpl _value,
      $Res Function(_$ChildrenInfoEditStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? haveRegistration = null,
    Object? name = freezed,
    Object? gender = freezed,
    Object? age = freezed,
  }) {
    return _then(_$ChildrenInfoEditStateImpl(
      haveRegistration: null == haveRegistration
          ? _value.haveRegistration
          : haveRegistration // ignore: cast_nullable_to_non_nullable
              as bool,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ChildrenInfoEditStateImpl extends _ChildrenInfoEditState {
  const _$ChildrenInfoEditStateImpl(
      {this.haveRegistration = false, this.name, this.gender, this.age})
      : super._();

  @override
  @JsonKey()
  final bool haveRegistration;
  @override
  final String? name;
  @override
  final int? gender;
  @override
  final int? age;

  @override
  String toString() {
    return 'ChildrenInfoEditState(haveRegistration: $haveRegistration, name: $name, gender: $gender, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildrenInfoEditStateImpl &&
            (identical(other.haveRegistration, haveRegistration) ||
                other.haveRegistration == haveRegistration) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, haveRegistration, name, gender, age);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildrenInfoEditStateImplCopyWith<_$ChildrenInfoEditStateImpl>
      get copyWith => __$$ChildrenInfoEditStateImplCopyWithImpl<
          _$ChildrenInfoEditStateImpl>(this, _$identity);
}

abstract class _ChildrenInfoEditState extends ChildrenInfoEditState {
  const factory _ChildrenInfoEditState(
      {final bool haveRegistration,
      final String? name,
      final int? gender,
      final int? age}) = _$ChildrenInfoEditStateImpl;
  const _ChildrenInfoEditState._() : super._();

  @override
  bool get haveRegistration;
  @override
  String? get name;
  @override
  int? get gender;
  @override
  int? get age;
  @override
  @JsonKey(ignore: true)
  _$$ChildrenInfoEditStateImplCopyWith<_$ChildrenInfoEditStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
