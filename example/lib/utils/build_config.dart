// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:app/extensions/completer.dart';
import 'package:app/utils/build_config_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

BuildConfigData? _initializedData;
BuildConfigData get BuildConfig {
  assert(isBuildConfigInitialized());
  if (_initializedData == null) throw Exception("BuildConfig accessed before being initialized.");
  return _initializedData!;
}

bool _isInitializing = false;
bool isBuildConfigInitialized() => _initializedData != null;

final _completer = Completer<void>();

/// Initializes our [BuildConfig].
///
/// Usually the 1st call on app / integration test launch.
Future<void> initializeBuildConfig() async {
  assert(dotenv.isInitialized == isBuildConfigInitialized());

  const env = String.fromEnvironment("ENV", defaultValue: "dev");

  // Build config can be initialized only once.
  if (_isInitializing) return _completer.future;
  if (isBuildConfigInitialized()) {
    assert(_completer.isCompleted);
    return;
  }

  _isInitializing = true;

  // If we detect flutter unit tests, force build config "test".
  final isUnitTest = Platform.environment.containsKey("FLUTTER_TEST");
  final name = isUnitTest ? "test" : env;
  final path = 'configs/$name.config';

  await dotenv.load(fileName: path);

  // We add some hardcoded fields depending on what our build config initialized.
  final configMap = dotenv.env;
  final effectiveConfigMap = {...configMap, "path": path, 'name': name};
  final data = BuildConfigData.fromJson(effectiveConfigMap);

  // Let's clean dotenv, so people 100% know to use our [BuildConfig].
  dotenv.clean();
  _initializedData = data;
  _completer.completeSafe();
  _isInitializing = false;
}
