import 'dart:async';

import 'package:app/app_widget.dart';
import 'package:app/services/log_service.dart';
import 'package:app/utils/build_config.dart';
import 'package:app/utils/locate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Initializes the app and configures dependencies.
///
/// When this is complete, the app is safe to move past the splash screen.
Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await initializeBuildConfig();

  configureDependencies();
  locate<LogService>().d("App initialize completed.");
}

/// A preflight step where we may await some services or
/// functionality, before we leave the splash screen and launch
/// the Flutter app.
///
/// While this async function is being awaited, the app
/// stays on the native splash screen.
Future<void> preflight() async {
  await Future.delayed(const Duration(milliseconds: 200));
  locate<LogService>().d("App preflight completed.");
}

Future<void> main() async {
  await initialize();
  await preflight();

  runApp(const AppWidget());
}
