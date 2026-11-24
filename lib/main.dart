import 'package:bookia/bookia_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/networking/dio_factory.dart';
import 'core/services/locale/locale_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services inside try-catch to prevent splash lock on emulator
  try {
    await EasyLocalization.ensureInitialized();
    await LocaleHelper.init();
    DioFactory.init();
  } catch (e) {
    debugPrint("Initialization Error: $e");
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const BookiaApp(),
    ),
  );
}