class CalendarEvent {
  final String id;
  final String description;
  final DateTime start;
  final DateTime end;
  final String summary;

  CalendarEvent({
    required this.id,
    required this.description,
    required this.start,
    required this.end,
    required this.summary,
  });
}
