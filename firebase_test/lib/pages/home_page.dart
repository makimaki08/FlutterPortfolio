import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  // ここでログイン中userの情報取得
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Home Page'),
                const Gap(20),
                ElevatedButton(
                  child: const Text('load'),
                  onPressed: () => _isLogin(user),
                ),
                ElevatedButton(
                  onPressed: () async {
                    fetchGoogleCalendarEvents();
                  },
                  child: const Text("Googleカレンダー情報取得"),
                ),
                Text(user!.uid),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _isLogin(User? user) async {
  // ログイン中か確認するメソッド
  if (user != null && !user!.emailVerified) {
    await user!.sendEmailVerification();
  }
}

Future<void> fetchGoogleCalendarEvents() async {
  const String calendarId =
      "c_vtiq1pc1t2mjt53ku34onjshhc@group.calendar.google.com";
  const String apiKey = "AIzaSyCNIVV2aeurzvWEILynOzvJeX0nfDRaSN0";
  const String url =
      'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final events = data['items'] as List;

      print('Google Calendar Events:');
      for (var event in events) {
        print('Title: ${event['summary']}');
        print('Start: ${event['start']['dateTime'] ?? event['start']['date']}');
        print('End: ${event['end']['dateTime'] ?? event['end']['date']}');
        print('---');
      }
    } else {
      print('Failed to fetch events: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
