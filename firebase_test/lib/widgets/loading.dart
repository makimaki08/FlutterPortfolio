import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading {
  /// show loading
  static Future<void> show() {
    return EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }

  /// dismiss loading
  static Future<void> dismiss() {
    return EasyLoading.dismiss();
  }
}
