import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CalendarEventCard extends StatelessWidget {
  const CalendarEventCard({
    super.key,
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.summary,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Gap(12),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20, color: Colors.grey),
                const Gap(8),
                Text(
                  '${event.duration}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Gap(12),
            if (event.description.isNotEmpty)
              Text(
                '説明：${event.description}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}
