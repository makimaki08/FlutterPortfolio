// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChildInfoState {
  String? get docId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  bool get isEditable => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChildInfoStateCopyWith<ChildInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildInfoStateCopyWith<$Res> {
  factory $ChildInfoStateCopyWith(
          ChildInfoState value, $Res Function(ChildInfoState) then) =
      _$ChildInfoStateCopyWithImpl<$Res, ChildInfoState>;
  @useResult
  $Res call(
      {String? docId, String? name, int? gender, int? age, bool isEditable});
}

/// @nodoc
class _$ChildInfoStateCopyWithImpl<$Res, $Val extends ChildInfoState>
    implements $ChildInfoStateCopyWith<$Res> {
  _$ChildInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = freezed,
    Object? name = freezed,
    Object? gender = freezed,
    Object? age = freezed,
    Object? isEditable = null,
  }) {
    return _then(_value.copyWith(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isEditable: null == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildInfoStateImplCopyWith<$Res>
    implements $ChildInfoStateCopyWith<$Res> {
  factory _$$ChildInfoStateImplCopyWith(_$ChildInfoStateImpl value,
          $Res Function(_$ChildInfoStateImpl) then) =
      __$$ChildInfoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? docId, String? name, int? gender, int? age, bool isEditable});
}

/// @nodoc
class __$$ChildInfoStateImplCopyWithImpl<$Res>
    extends _$ChildInfoStateCopyWithImpl<$Res, _$ChildInfoStateImpl>
    implements _$$ChildInfoStateImplCopyWith<$Res> {
  __$$ChildInfoStateImplCopyWithImpl(
      _$ChildInfoStateImpl _value, $Res Function(_$ChildInfoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = freezed,
    Object? name = freezed,
    Object? gender = freezed,
    Object? age = freezed,
    Object? isEditable = null,
  }) {
    return _then(_$ChildInfoStateImpl(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isEditable: null == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChildInfoStateImpl extends _ChildInfoState {
  const _$ChildInfoStateImpl(
      {this.docId, this.name, this.gender, this.age, this.isEditable = false})
      : super._();

  @override
  final String? docId;
  @override
  final String? name;
  @override
  final int? gender;
  @override
  final int? age;
  @override
  @JsonKey()
  final bool isEditable;

  @override
  String toString() {
    return 'ChildInfoState(docId: $docId, name: $name, gender: $gender, age: $age, isEditable: $isEditable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildInfoStateImpl &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.isEditable, isEditable) ||
                other.isEditable == isEditable));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, docId, name, gender, age, isEditable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildInfoStateImplCopyWith<_$ChildInfoStateImpl> get copyWith =>
      __$$ChildInfoStateImplCopyWithImpl<_$ChildInfoStateImpl>(
          this, _$identity);
}

abstract class _ChildInfoState extends ChildInfoState {
  const factory _ChildInfoState(
      {final String? docId,
      final String? name,
      final int? gender,
      final int? age,
      final bool isEditable}) = _$ChildInfoStateImpl;
  const _ChildInfoState._() : super._();

  @override
  String? get docId;
  @override
  String? get name;
  @override
  int? get gender;
  @override
  int? get age;
  @override
  bool get isEditable;
  @override
  @JsonKey(ignore: true)
  _$$ChildInfoStateImplCopyWith<_$ChildInfoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
