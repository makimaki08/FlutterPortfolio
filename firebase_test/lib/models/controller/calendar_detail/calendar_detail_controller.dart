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

  Future<void> addAttendanceInfo(CalendarEvent event, String uid) async {
    Loading.show();
    DateTime now = DateTime.now();
    // FIXME: uidがnullになっているので、その対応を追加する。
    final prefs = await SharedPreferences.getInstance();
    final userUid = prefs.getString('user_id');

    // FIXME: この場合だとuidは単体の場合しか対応できず、2名以上を一緒のタイミングで登録することができない。
    // for文を回すなどして、複数のuidを登録できるようにする必要がある。
    FirebaseFirestore.instance.collection('collectionPath').add(
      // FIXME: 子供のuidを登録する必要あり。
      {
        'id': event.id,
        'summary': event.summary,
        'description': event.description,
        'start': event.start,
        'end': event.end,
        'duration': event.duration,
        'uid': userUid,
        'uploadTime': now,
      },
    );
    Loading.dismiss();
  }
}
