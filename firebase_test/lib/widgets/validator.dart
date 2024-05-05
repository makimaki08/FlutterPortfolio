class Validator {
  // メールアドレスが有効かどうかを確認するメソッド
  static bool isValidEmail(String email) {
    // 正規表現を使用してメールアドレスが有効かどうかをチェック
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // パスワードが6文字以上であるかを確認するメソッド
  static bool isPasswordValid(String password) {
    return password.length >= 6;
  }
}
