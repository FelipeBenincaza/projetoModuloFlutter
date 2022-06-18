// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';
import 'package:projetopesquisa/pages/questionario.dart';

void main() {
  final dom = DomicilioModel(
    id: faker.randomGenerator.toString(),
    controle: Random().nextInt(1000000000) + 100000000,
    endereco: faker.address.streetAddress(),
    estado: faker.address.state(),
    municipio: faker.address.countryCode(),
    tipoEntrevista: "Realizar",
    status: "Em Andamento",
    quesito1: "Selecione",
    quesito2: "Selecione",
    quesito3: "Selecione",
    quesito4: "Selecione",
    quesito5: "Selecione",
    quesito6: "Selecione",
    quesito7: "Selecione",
    latitude: "Selecione",
    longitude: "Selecione",
  );

  testWidgets('Verifica widgets foram montados', (WidgetTester tester) async {

    await tester.pumpWidget( MaterialApp(home: Questionario(domicilio: dom)));

    final buttonLocal = find.byKey(const ValueKey('buttonLocal'));
    expect(buttonLocal, findsOneWidget);

    final dropQuesito1 = find.byKey(const ValueKey("drop1"));
    expect(dropQuesito1, findsOneWidget);
    final dropQuesito2 = find.byKey(const ValueKey('drop2'));
    expect(dropQuesito2, findsOneWidget);
    final dropQuesito3 = find.byKey(const ValueKey("drop3"));
    expect(dropQuesito3, findsOneWidget);
    final dropQuesito4 = find.byKey(const ValueKey("drop4"));
    expect(dropQuesito4, findsOneWidget);
    final dropQuesito5 = find.byKey(const ValueKey('drop5'));
    expect(dropQuesito5, findsOneWidget);
    final dropQuesito6 = find.byKey(const ValueKey("drop6"));
    expect(dropQuesito6, findsOneWidget);
    final dropQuesito7 = find.byKey(const ValueKey('drop7'));
    expect(dropQuesito7, findsNothing);

    final buttonSalvar = find.byKey(const ValueKey('buttonSalvar'));
    expect(buttonSalvar, findsOneWidget);
  });

  testWidgets('Verifica se quesito7 é mostrado ao responder Não no quesito6', (WidgetTester tester) async {

    await tester.pumpWidget( MaterialApp(home: Questionario(domicilio: dom)));

    final dropQuesito6 = find.byKey(const ValueKey("drop6"));
    expect(dropQuesito6, findsOneWidget);
    final dropQuesito7 = find.byKey(const ValueKey('drop7'));
    expect(dropQuesito7, findsNothing);

    await tester.ensureVisible(dropQuesito6);
    await tester.pumpAndSettle();
    await tester.tap(dropQuesito6);
    await tester.pumpAndSettle();

    final dropdownItem = find.byKey(const ValueKey('dropItem6_Não')).last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();
    expect(dropQuesito7, findsOneWidget);
  });
}