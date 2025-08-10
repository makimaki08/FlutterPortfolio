import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String formatTimestamp(dynamic timestamp) {
  if (timestamp is Timestamp) {
    final dateTime = timestamp.toDate();
    return DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
  } else if (timestamp is DateTime) {
    return DateFormat('yyyy/MM/dd HH:mm').format(timestamp);
  } else {
    return '';
  }
}
