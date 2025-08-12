import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_test/utils/date_format_util.dart';
import 'package:go_router/go_router.dart';

import '../../models/entities/event/calendar_event.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  // ログイン中userの情報取得
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoState state = ref.watch(childrenInfoEditProvider);
    final ChildrenInfoController controller =
        ref.watch(childrenInfoEditProvider.notifier);
    final screenSize = MediaQuery.of(context).size;

    useEffect(() {
      controller.fetchChildrenInfo();
      return null;
    }, const []);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ホーム'),
        ),
        body: SafeArea(
            child: (!state.haveRegistration)
                ? Container(
                    alignment: Alignment.center,
                    child: const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                            "お子様の情報が登録されていません。\n設定タブから、お子様の情報を新規追加してください。")),
                  )
                : ListView.builder(
                    itemCount: state.children.length,
                    itemBuilder: (context, index) {
                      return _ChildAttendCard(
                        screenSize: screenSize,
                        state: state.children[index],
                      );
                    },
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.fetchChildrenInfo();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

// 子供の出席カード
class _ChildAttendCard extends HookConsumerWidget {
  const _ChildAttendCard(
      {super.key, required this.screenSize, required this.state});
  final Size screenSize;
  final ChildInfoState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoController childrenInfoController =
        ref.watch(childrenInfoEditProvider.notifier);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: childrenInfoController.fetchAbsenceInfo(state.docId ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Text('欠席情報の取得に失敗しました');
        }
        final absences = snapshot.data ?? [];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 子供の名前を大きく表示
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: AppColors.burlywood.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    state.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              absences.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: AppColors.whitesmoke,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.darkgray, width: 1),
                      ),
                      child: const Center(
                        child: Text(
                          '欠席情報はありません',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    )
                  : Column(
                      children: absences.map((absence) {
                        final summary = absence['summary'] ?? '';
                        final description = absence['description'] ?? '';
                        final start = formatTimestamp(absence['start']);
                        final end = formatTimestamp(absence['end']);
                        final reason =
                            (absence['reason'] as String?)?.trim() ?? '';
                        // カレンダーイベント情報を作成
                        final calendarEvent = CalendarEvent(
                          id: absence['id'] ?? '',
                          summary: summary,
                          description: description,
                          start: (absence['start'] is Timestamp)
                              ? (absence['start'] as Timestamp).toDate()
                              : absence['start'],
                          end: (absence['end'] is Timestamp)
                              ? (absence['end'] as Timestamp).toDate()
                              : absence['end'],
                          duration: absence['duration'],
                        );
                        return GestureDetector(
                          onTap: () {
                            context.go(
                              '/calendar/detail',
                              extra: calendarEvent,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                  color: AppColors.darkgray, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.event_busy,
                                        color: AppColors.blue, size: 28),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        summary,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (description.isNotEmpty)
                                  Text(
                                    description,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black87),
                                  ),
                                // 追加: 理由（あれば表示）
                                if (reason.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.sticky_note_2_outlined,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          '理由: $reason',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text('開始: $start',
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text('終了: $end',
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        );
      },
    );
  }
}
