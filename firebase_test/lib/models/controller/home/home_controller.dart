import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeController = Provider<HomeController>((ref) => HomeController(ref));

class HomeController {
  HomeController(this._ref);
  final Ref _ref;
}
