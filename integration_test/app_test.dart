import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:repaso_flutter/main.dart' as app;

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Realizar conversion", (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), "1");
    // No puedo acceder a uno al haber dos.
    //await tester.tap(find.byType(DropdownMenu<String>));
    await tester.tap(find.text("Convert and save"));
    // Ni puta idea
    //expect(find.text("Result: 1.0 KM"), findsOneWidget);
  });
}