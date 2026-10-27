import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog_app/main.dart';

void main() {
  testWidgets('Mini Katalog App baslatma testi', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp());
    expect(find.text('Discover'), findsOneWidget);
  });
}
