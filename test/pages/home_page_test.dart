import 'package:choose_right_price/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomePage', () {
    Finder checkButton() => find.text('Kiểm tra');
    Finder nextButton() => find.text('Tiếp tục');
    Finder priceInput() => find.byKey(const Key('priceInput'));
    Finder resultCheck() => find.byKey(const Key('resultStatus'));

    testWidgets(
      'Next to the end of the product list',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));

        expect(find.text(products[0].name), findsOneWidget);

        for (var i = 1; i < products.length; i++) {
          await tester.tap(checkButton());
          await tester.enterText(priceInput(), '0');
          await tester.pump();
          await tester.tap(nextButton());
          await tester.pump();
          expect(find.text(products[i].name), findsOneWidget);
        }

        // await tester.tap(find.text('Kiểm tra'));
        // await tester.pump();
        // expect(find.text(products[1].name), findsOneWidget);

        await tester.tap(checkButton());
        await tester.pump();
        await tester.tap(nextButton());
        await tester.pump();
        expect(find.text(products[6].name), findsOneWidget);
      },
    );

    testWidgets('Check result &show next product', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(nextButton(), findsNothing);
      expect(resultCheck(), findsNothing);

      await tester.enterText(priceInput(), '3');
      await tester.tap(checkButton());
      await tester.pump();
      expect(nextButton(), findsOneWidget);
      expect(resultCheck(), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);

      await tester.tap(nextButton());
      await tester.pump();

      expect(nextButton(), findsNothing);
      expect(resultCheck(), findsNothing);
      await tester.enterText((priceInput()), '6');
      await tester.tap(checkButton());
      await tester.pump();
      expect(nextButton(), findsOneWidget);
      expect(resultCheck(), findsOneWidget);
      expect(find.text('fail'), findsOneWidget);

      await tester.enterText(priceInput(), '4');
      await tester.tap(find.text('Kiểm tra'));
      await tester.pump();
      expect(find.text('pass'), findsOneWidget);
    });
  });
}
