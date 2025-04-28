// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
// import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final homeProvider = StateNotifierProvider<HomeController, ChildrenInfoState>(
//     HomeController.new);

// class HomeController extends StateNotifier<ChildrenInfoState> {
//   var _ref;

//   HomeController(this._ref)
//       : super(const ChildrenInfoState(children: [ChildInfoState()]));

//   // memo: uidを元にして、firebaseから情報を取得する
//   void fetchChildrenInfo() {
//     FirebaseFirestore.instance
//         .collection('children')
//         .get()
//         .then((QuerySnapshot snapshot) {
//       List<ChildInfoState> newChildren = [];
//       snapshot.docs.forEach((doc) {
//         /// usersコレクションのドキュメントIDを取得する
//         var child = ChildInfoState(
//           docId: doc.id,
//           name: doc.get('name'),
//           gender: doc.get('gender'),
//           age: doc.get('age'),
//         );

//         newChildren.add(child);
//       });
//       state = state.copyWith(
//         children: newChildren,
//         haveRegistration: newChildren.isNotEmpty,
//       );
//     });
//   }
// }

// Future<void> _isLogin(User? user) async {
//   // ログイン中か確認するメソッド
//   if (user != null && !user.emailVerified) {
//     await user.sendEmailVerification();
//   }
// }

// Future<void> fetchGoogleCalendarEvents() async {
//   const String calendarId =
//       "c_vtiq1pc1t2mjt53ku34onjshhc@group.calendar.google.com";
//   const String apiKey = "AIzaSyCNIVV2aeurzvWEILynOzvJeX0nfDRaSN0";

//   final now = DateTime.now();
//   final oneWeekAgo = now.subtract(const Duration(days: 7)).toUtc();
//   final threeWeeksLater = now.add(const Duration(days: 21)).toUtc();

//   final timeMin = oneWeekAgo.toIso8601String();
//   final timeMax = threeWeeksLater.toIso8601String();

//   final url =
//       'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey&timeMin=$timeMin&timeMax=$timeMax';

//   try {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final events = data['items'] as List;

//       print('Google Calendar Events:');
//       for (var event in events) {
//         print('Title: ${event['summary']}');
//         print('Start: ${event['start']['dateTime'] ?? event['start']['date']}');
//         print('End: ${event['end']['dateTime'] ?? event['end']['date']}');
//         print('---');
//       }
//     } else {
//       print('Failed to fetch events: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
