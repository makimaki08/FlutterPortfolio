// Mocks generated by Mockito 5.4.4 from annotations
// in firebase_test/test/sample/cat_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

import 'cat_test.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [Cat].
///
/// See the documentation for Mockito's code generation for more information.
class MockCat extends _i1.Mock implements _i2.Cat {
  @override
  int get lives => (super.noSuchMethod(
        Invocation.getter(#lives),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  set lives(int? _lives) => super.noSuchMethod(
        Invocation.setter(
          #lives,
          _lives,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String sound() => (super.noSuchMethod(
        Invocation.method(
          #sound,
          [],
        ),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.method(
            #sound,
            [],
          ),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.method(
            #sound,
            [],
          ),
        ),
      ) as String);

  @override
  bool eatFood(
    String? food, {
    bool? hungry,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #eatFood,
          [food],
          {#hungry: hungry},
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i4.Future<void> chew() => (super.noSuchMethod(
        Invocation.method(
          #chew,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  int walk(List<String>? places) => (super.noSuchMethod(
        Invocation.method(
          #walk,
          [places],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  void sleep() => super.noSuchMethod(
        Invocation.method(
          #sleep,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void hunt(
    String? place,
    String? prey,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #hunt,
          [
            place,
            prey,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  int getLives() => (super.noSuchMethod(
        Invocation.method(
          #getLives,
          [],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
}
