import 'package:app/app_widget.dart';
import 'package:app/main.dart';
import 'package:app/utils/build_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(initialize);

  testWidgets('App pumps with test config.', (widgetTester) async {
    expect(BuildConfig.tests, equals(true));
    await widgetTester.pumpWidget(const AppWidget());
    expect(true, true);
  });
}
