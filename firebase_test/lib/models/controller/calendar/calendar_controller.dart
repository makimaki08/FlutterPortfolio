import 'package:firebase_test/models/controller/calendar/calendar_state.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String calendarId =
    "c_vtiq1pc1t2mjt53ku34onjshhc@group.calendar.google.com";
const String apiKey = "AIzaSyCNIVV2aeurzvWEILynOzvJeX0nfDRaSN0";

final now = DateTime.now();
final oneWeekAgo = now.subtract(const Duration(days: 7)).toUtc();
final threeWeeksLater = now.add(const Duration(days: 21)).toUtc();

final timeMin = oneWeekAgo.toIso8601String();
final timeMax = threeWeeksLater.toIso8601String();

final calendarUrl =
    'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey&timeMin=$timeMin&timeMax=$timeMax';

final calendarProvider = FutureProvider<List<CalendarEvent>>((ref) async {
  await Loading.show();

  final response = await http.get(Uri.parse(calendarUrl));

  await Loading.dismiss();

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final events = data['items'] as List;
    return events
        .map((event) => CalendarEvent.fromJson(event))
        .where((event) => event.duration != null)
        .toList();
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
