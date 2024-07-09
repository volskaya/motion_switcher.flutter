import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:app/resources/resources.dart';

void main() {
  test('config_assets assets test', () {
    expect(File(ConfigAssets.dev).existsSync(), isTrue);
    expect(File(ConfigAssets.prod).existsSync(), isTrue);
    expect(File(ConfigAssets.test).existsSync(), isTrue);
  });
}
