import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final ChildrenInfoController controller;
  final int index;

  const ConfirmDeleteDialog({
    super.key,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.amber),
          const SizedBox(width: 8),
          const Flexible(
            child: Text(
              'このお子様情報を削除しますか？',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: const Text(
        'この操作は取り消せません。削除すると元に戻せません。',
        style: TextStyle(height: 1.4),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton.icon(
          icon: const Icon(Icons.delete_forever),
          label: const Text('削除する'),
          style: FilledButton.styleFrom(
            backgroundColor: scheme.error,
            foregroundColor: scheme.onError,
          ),
          onPressed: () async {
            await controller.deleteChildInfo(index);
            Navigator.of(context).pop();
            controller.fetchChildrenInfo();
          },
        ),
      ],
    );
  }
}
