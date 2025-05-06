import 'package:intl/intl.dart';

class CalendarEvent {
  final String id;
  final String summary;
  final String description;
  final DateTime start;
  final DateTime end;
  final String? duration;

  CalendarEvent({
    required this.id,
    required this.summary,
    required this.description,
    required this.start,
    required this.end,
    this.duration,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    final DateFormat startFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final DateFormat endFormatter = DateFormat('HH:mm');
    if (json['start']['dateTime'] != null && json['end']['dateTime'] != null) {
      return CalendarEvent(
        id: json['id'],
        summary: json['summary'] ?? 'No title',
        description: json['description'] ?? '',
        start: DateTime.parse(json['start']['dateTime']),
        end: DateTime.parse(json['end']['dateTime']),
        duration:
            "${startFormatter.format(DateTime.parse(json['start']['dateTime']).toLocal())}~${endFormatter.format(DateTime.parse(json['end']['dateTime']).toLocal())}",
      );
    }
    return CalendarEvent(
      id: json['id'],
      summary: json['summary'] ?? 'No title',
      description: json['description'] ?? '',
      start: DateTime.parse(json['start']['date']),
      end: DateTime.parse(json['end']['date']),
    );
  }
}
