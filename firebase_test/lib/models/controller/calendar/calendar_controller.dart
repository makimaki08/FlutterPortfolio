import 'package:firebase_test/models/controller/calendar/calendar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String calendarId =
    'c_vtiq1pc1t2mjt53ku34onjshhc@group.calendar.google.com';
const String apiKey = 'AIzaSyCNIVV2aeurzvWEILynOzvJeX0nfDRaSN0';
const String calendarUrl =
    'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey';

final calendarProvider = FutureProvider<List<Event>>((ref) async {
  final response = await http.get(Uri.parse(calendarUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final events = data['items'] as List;
    return events.map((event) => Event.fromJson(event)).toList();
  } else {
    print("response = ${response}, ${response.statusCode}");
    throw Exception('Failed to load events');
  }
});

class CalendarController extends StateNotifier<CalendarState> {
  CalendarController(this._ref) : super(const CalendarState());
  final Ref _ref;

  Future<void> reload() async {}
}

class Event {
  final String id;
  final String summary;
  final String description;
  final DateTime start;
  final DateTime end;

  Event({
    required this.id,
    required this.summary,
    required this.description,
    required this.start,
    required this.end,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 'No id',
      summary: json['summary'] ?? 'No title',
      description: json['description'] ?? '',
      start: DateTime.parse(json['start']['dateTime']),
      end: DateTime.parse(json['end']['dateTime']),
    );
  }
}
