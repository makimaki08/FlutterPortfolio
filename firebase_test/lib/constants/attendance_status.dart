enum AttendanceStatus { absent, late, early }

extension AttendanceStatusX on AttendanceStatus {
  String get label {
    switch (this) {
      case AttendanceStatus.absent:
        return '欠席';
      case AttendanceStatus.late:
        return '遅刻';
      case AttendanceStatus.early:
        return '早退';
    }
  }

  String get firestoreValue {
    switch (this) {
      case AttendanceStatus.absent:
        return 'absent';
      case AttendanceStatus.late:
        return 'late';
      case AttendanceStatus.early:
        return 'early';
    }
  }
}
