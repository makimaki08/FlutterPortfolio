import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/calendar_detail/calendar_detail_state.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final calendarDetailProvider = Provider(CalendarDetailController.new);

class CalendarDetailController {
  CalendarDetailController(this._ref);
  final Ref _ref;

  Future<void> addAttendanceInfo(CalendarEvent event, List<String> uids) async {
    Loading.show();
    DateTime now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    final userUid = prefs.getString('user_id');

    for (final uid in uids) {
      await FirebaseFirestore.instance.collection('collectionPath').add({
        'id': event.id,
        'summary': event.summary,
        'description': event.description,
        'start': event.start,
        'end': event.end,
        'duration': event.duration,
        'uid': uid,
        'registeredBy': userUid,
        'uploadTime': now,
      });
    }
    Loading.dismiss();
  }
}
