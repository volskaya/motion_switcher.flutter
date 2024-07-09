import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:app/resources/resources.dart';

void main() {
  test('image_shoe_assets assets test', () {
    expect(File(ImageShoeAssets.shoe0).existsSync(), isTrue);
    expect(File(ImageShoeAssets.shoe1).existsSync(), isTrue);
    expect(File(ImageShoeAssets.shoe2).existsSync(), isTrue);
    expect(File(ImageShoeAssets.shoe3).existsSync(), isTrue);
  });
}
