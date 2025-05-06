import 'package:freezed_annotation/freezed_annotation.dart';
part 'calendar_detail_state.freezed.dart';

@freezed
class CalendarDetailState with _$CalendarDetailState {
  const factory CalendarDetailState({
    @Default(false) bool isAuth,
  }) = _CalendarDetailState;

  const CalendarDetailState._();
}
