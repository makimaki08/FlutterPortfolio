import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/calendar_detail/calendar_detail_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:firebase_test/widgets/calendar_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarDetailPage extends HookConsumerWidget {
  const CalendarDetailPage({
    super.key,
    required this.event,
  });
  final CalendarEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(calendarDetailProvider);
    final LoginState loginState = ref.watch(loginProvider);
    final ChildrenInfoState childrenInfoState =
        ref.watch(childrenInfoEditProvider);
    final ChildrenInfoController childrenInfoController =
        ref.watch(childrenInfoEditProvider.notifier);

    final users = childrenInfoState.children;
    final selectedUids = useState<List<String>>([]);

    // 欠席済みUIDリストを取得してselectedUidsにセット
    useEffect(() {
      childrenInfoController.fetchChildrenInfo();

      Future<void> fetchAbsenceUids() async {
        final snapshot = await FirebaseFirestore.instance
            .collection('collectionPath')
            .where('id', isEqualTo: event.id)
            .get();
        final absenceUids =
            snapshot.docs.map((doc) => doc['uid'] as String).toList();
        selectedUids.value = absenceUids;
      }

      fetchAbsenceUids();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Detail"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                event.summary,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    '${event.duration}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Divider(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.only(bottom: 120), // フッター分の余白を確保
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final uid = user.docId;
                    final isSelected = selectedUids.value.contains(uid);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.whitesmoke,
                          child: Icon(Icons.person, color: AppColors.darkgray),
                        ),
                        title: Text(
                          user.name ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? AppColors.blue : Colors.black87,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 1.2, // チェックボックスを少し大きく
                          child: Checkbox(
                            value: isSelected,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            activeColor: AppColors.blue,
                            onChanged: (isChecked) {
                              if (uid == null) return;
                              if (isChecked == true) {
                                selectedUids.value = [...selectedUids.value, uid];
                              } else {
                                selectedUids.value =
                                    selectedUids.value.where((id) => id != uid).toList();
                              }
                            },
                          ),
                        ),
                        onTap: () {
                          if (uid == null) return;
                          if (isSelected) {
                            selectedUids.value =
                                selectedUids.value.where((id) => id != uid).toList();
                          } else {
                            selectedUids.value = [...selectedUids.value, uid];
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.addAttendanceInfo(event, selectedUids.value);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('欠席を登録しました')),
                  );
                }
                context.pop();
              },
              icon: const Icon(Icons.cancel, color: AppColors.whitesmoke),
              label: const Text('欠席する'),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whitesmoke,
                backgroundColor: AppColors.blue,
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
