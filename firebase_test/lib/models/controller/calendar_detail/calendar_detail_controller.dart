import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/calendar_detail/calendar_detail_state.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_test/constants/attendance_status.dart';

final calendarDetailProvider = Provider(CalendarDetailController.new);

class CalendarDetailController {
  CalendarDetailController(this._ref);
  final Ref _ref;

  // 一意なドキュメント参照（event.id と uid を結合）
  DocumentReference<Map<String, dynamic>> _docRefFor({
    required String eventId,
    required String uid,
  }) {
    return FirebaseFirestore.instance
        .collection('attendances')
        .doc('${eventId}_$uid');
  }

  // ステータスは任意指定（デフォルトは欠席）: 上書き保存（merge）
  Future<void> addAttendanceInfo({
    required CalendarEvent event,
    required List<String> uids,
    AttendanceStatus status = AttendanceStatus.absent,
    Map<String, String>? reasons,
  }) async {
    if (uids.isEmpty) return;

    Loading.show();
    try {
      final now = DateTime.now();
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('user_id');

      final batch = FirebaseFirestore.instance.batch();
      for (final uid in uids) {
        final docRef = _docRefFor(eventId: event.id, uid: uid);
        batch.set(
          docRef,
          {
            'id': event.id,
            'eventId': event.id,
            'uid': uid,
            'status': status.firestoreValue,
            'reason': reasons != null ? (reasons[uid] ?? '') : '',
            'summary': event.summary,
            'description': event.description,
            'start': event.start,
            'end': event.end,
            'duration': event.duration,
            'registeredBy': userUid,
            'uploadTime': now,
            'updatedAt': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      }
      await batch.commit();
    } finally {
      Loading.dismiss();
    }
  }

  // 取り消し（該当ユーザー分を削除）
  Future<void> clearAttendanceInfo({
    required CalendarEvent event,
    required List<String> uids,
  }) async {
    if (uids.isEmpty) return;

    Loading.show();
    try {
      final batch = FirebaseFirestore.instance.batch();
      for (final uid in uids) {
        final docRef = _docRefFor(eventId: event.id, uid: uid);
        batch.delete(docRef);
      }
      await batch.commit();
    } finally {
      Loading.dismiss();
    }
  }
}
