import 'package:flutter_test/flutter_test.dart';
import 'package:trade_watchlist/app/app.dart';

void main() {
  testWidgets('App renders watchlist page', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Watchlist'), findsOneWidget);
  });
}
