// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projetopesquisa/pages/domicilio_page.dart';

void main() {
  testWidgets('Verificar se todos widgets estão aparecendo', (WidgetTester tester) async {
    await tester.pumpWidget( const MaterialApp(home: DomicilioPage(),));

    final addFaker = find.byKey(const ValueKey("addFaker"));
    expect(addFaker, findsOneWidget);

    final textFormEndereco = find.byKey(const ValueKey("endereco"));
    expect(textFormEndereco, findsOneWidget);
    final textFormMunicipio = find.byKey(const ValueKey("municipio"));
    expect(textFormMunicipio, findsOneWidget);
    final textFormEstado = find.byKey(const ValueKey("estado"));
    expect(textFormEstado, findsOneWidget);

    final buttonSalvar = find.byKey(const ValueKey("buttonSalvar"));
    expect(buttonSalvar, findsOneWidget);

    /*await tester.tap(addFaker);
    await tester.pumpAndSettle();*/

  });
}
