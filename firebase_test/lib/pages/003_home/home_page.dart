import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/style/color/app_colors.dart';
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
              children: [
                const Gap(8),
                Text("${DateTime.now().year}年${DateTime.now().month}月"),
                const Gap(8),

                // TODO: 以下Demo版のため、修正必要
                const Text(
                  "田中太郎",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                const Gap(4),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.appBarTheme,
                  ),
                  child: const Column(
                    children: [
                      Text("16:30~19:00"),
                      Text("4~6年生"),
                    ],
                  ),
                )
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

  final now = DateTime.now();
  final oneWeekAgo = now.subtract(const Duration(days: 7)).toUtc();
  final threeWeeksLater = now.add(const Duration(days: 21)).toUtc();

  final timeMin = oneWeekAgo.toIso8601String();
  final timeMax = threeWeeksLater.toIso8601String();

  final url =
      'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey&timeMin=$timeMin&timeMax=$timeMax';

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
