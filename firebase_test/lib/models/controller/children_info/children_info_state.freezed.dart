// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'children_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChildrenInfoState {
  bool get haveRegistration => throw _privateConstructorUsedError;
  List<ChildInfoState> get children => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChildrenInfoStateCopyWith<ChildrenInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildrenInfoStateCopyWith<$Res> {
  factory $ChildrenInfoStateCopyWith(
          ChildrenInfoState value, $Res Function(ChildrenInfoState) then) =
      _$ChildrenInfoStateCopyWithImpl<$Res, ChildrenInfoState>;
  @useResult
  $Res call({bool haveRegistration, List<ChildInfoState> children});
}

/// @nodoc
class _$ChildrenInfoStateCopyWithImpl<$Res, $Val extends ChildrenInfoState>
    implements $ChildrenInfoStateCopyWith<$Res> {
  _$ChildrenInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? haveRegistration = null,
    Object? children = null,
  }) {
    return _then(_value.copyWith(
      haveRegistration: null == haveRegistration
          ? _value.haveRegistration
          : haveRegistration // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ChildInfoState>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildrenInfoStateImplCopyWith<$Res>
    implements $ChildrenInfoStateCopyWith<$Res> {
  factory _$$ChildrenInfoStateImplCopyWith(_$ChildrenInfoStateImpl value,
          $Res Function(_$ChildrenInfoStateImpl) then) =
      __$$ChildrenInfoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool haveRegistration, List<ChildInfoState> children});
}

/// @nodoc
class __$$ChildrenInfoStateImplCopyWithImpl<$Res>
    extends _$ChildrenInfoStateCopyWithImpl<$Res, _$ChildrenInfoStateImpl>
    implements _$$ChildrenInfoStateImplCopyWith<$Res> {
  __$$ChildrenInfoStateImplCopyWithImpl(_$ChildrenInfoStateImpl _value,
      $Res Function(_$ChildrenInfoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? haveRegistration = null,
    Object? children = null,
  }) {
    return _then(_$ChildrenInfoStateImpl(
      haveRegistration: null == haveRegistration
          ? _value.haveRegistration
          : haveRegistration // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ChildInfoState>,
    ));
  }
}

/// @nodoc

class _$ChildrenInfoStateImpl extends _ChildrenInfoState {
  const _$ChildrenInfoStateImpl(
      {this.haveRegistration = false,
      required final List<ChildInfoState> children})
      : _children = children,
        super._();

  @override
  @JsonKey()
  final bool haveRegistration;
  final List<ChildInfoState> _children;
  @override
  List<ChildInfoState> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'ChildrenInfoState(haveRegistration: $haveRegistration, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildrenInfoStateImpl &&
            (identical(other.haveRegistration, haveRegistration) ||
                other.haveRegistration == haveRegistration) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode => Object.hash(runtimeType, haveRegistration,
      const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildrenInfoStateImplCopyWith<_$ChildrenInfoStateImpl> get copyWith =>
      __$$ChildrenInfoStateImplCopyWithImpl<_$ChildrenInfoStateImpl>(
          this, _$identity);
}

abstract class _ChildrenInfoState extends ChildrenInfoState {
  const factory _ChildrenInfoState(
      {final bool haveRegistration,
      required final List<ChildInfoState> children}) = _$ChildrenInfoStateImpl;
  const _ChildrenInfoState._() : super._();

  @override
  bool get haveRegistration;
  @override
  List<ChildInfoState> get children;
  @override
  @JsonKey(ignore: true)
  _$$ChildrenInfoStateImplCopyWith<_$ChildrenInfoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
