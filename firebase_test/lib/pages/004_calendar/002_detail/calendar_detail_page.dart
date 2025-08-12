import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/calendar_detail/calendar_detail_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/pages/004_calendar/002_detail/calendar_detail_body.dart';
import 'package:firebase_test/pages/004_calendar/002_detail/clendar_detail_bottom_bar.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_test/constants/attendance_status.dart';

class CalendarDetailPage extends HookConsumerWidget {
  const CalendarDetailPage({
    super.key,
    required this.event,
  });
  final CalendarEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoState childrenInfoState =
        ref.watch(childrenInfoEditProvider);
    final users = childrenInfoState.children;

    // 状態は親で保持
    final status = useState<AttendanceStatus>(AttendanceStatus.absent);
    final selections = useState<Map<String, AttendanceStatus>>({});
    final initialSelectionsRef =
        useValueNotifier<Map<String, AttendanceStatus>>({});
    final reasons = useValueNotifier<Map<String, String>>({});

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // スクロールする本文（全体スクロール）
          CalendarDetailBody(
            event: event,
            users: users,
            status: status,
            selections: selections,
            initialSelectionsRef: initialSelectionsRef,
            reasons: reasons,
          ),
          // 画面下に重ねる更新ボタン（キーボードの後ろに隠れる）
          Positioned(
            left: 16,
            right: 16,
            bottom: 16 + MediaQuery.of(context).padding.bottom,
            child: CalendarDetailBottomBar(
              event: event,
              selections: selections,
              initialSelectionsRef: initialSelectionsRef,
              reasons: reasons,
            ),
          ),
        ],
      ),
    );
  }
}

// AppBar 分割
class CalendarDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CalendarDetailAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
    );
  }
}
