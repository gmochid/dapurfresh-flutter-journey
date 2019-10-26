import 'dart:async';

import 'package:azuralabs_flutter/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:intl/date_symbol_data_local.dart';
import './config/config.dart';

void main() async {
  await initializeDateFormatting('id_ID');

  FlutterError.onError = (details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  await FlutterCrashlytics().initialize();

  runZoned(() async {
    runApp(
        new AppConfig(orderCollection: 'orders', child: MyApp())
    );
  }, onError: (error, stackTrace) {
    FlutterCrashlytics().reportCrash(error, stackTrace);
  });
}
