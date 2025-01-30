import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repaso_flutter/domain/conversion.dart';
import 'package:repaso_flutter/presentation/widgets/transaction_card.dart';

main() {
  testWidgets("Transaction Card muestra la conversión y permite eliminarla",
      (tester) async {
    bool isDeleted = false;
    await tester.pumpWidget(MaterialApp(
      home: TransactionCard(
        conversion: Conversion.convert(10, "KM", "KM"),
        onDeletePressed: (context, conversion) {
          isDeleted = true;
        },
      ),
    ));

    expect(find.text("10.0"), findsOneWidget);
    await tester.tap(find.byType(IconButton));
    expect(isDeleted, true);
  });
}
