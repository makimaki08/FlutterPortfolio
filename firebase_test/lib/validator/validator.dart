class ValidateText {
  String? emailValidator(String? value) {
    if (value != null) {
      String pattern = r'^[0-9a-z_./?-]+@([0-9a-z-]+\.)+[0-9a-z-]+$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return '正しいメールアドレスを入力してください';
      }
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value != null) {
      String pattern = r'^[a-zA-Z0-9]{6,}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return '6文字以上の英数字を入力してください';
      }
    }
    return null;
  }
}
