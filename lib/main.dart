import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz_trivia/features/app/presentation/widgets/app_scope.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();

    runApp(AppScope(prefs: prefs));
  }, (error, stackTrace) {
    if (kDebugMode) {
      print('Caught error: $error');
      print('Stack trace: $stackTrace');
    }
  });
}
