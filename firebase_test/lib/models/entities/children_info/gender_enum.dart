enum Gender {
  man,
  woman,
}

extension GenderExtension on Gender {
  int get value {
    switch (this) {
      case Gender.man:
        return 1;
      case Gender.woman:
        return 2;
    }
  }
}
