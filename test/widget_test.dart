// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:faker/faker.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';
import 'package:projetopesquisa/pages/aberturaDomicilio.dart';

void main() {
  testWidgets('Verifica se button vai aparecer ao selecionar um tipo de entrevista', (WidgetTester tester) async {
    final dom = DomicilioModel(
      id: faker.randomGenerator.toString(),
      controle: Random().nextInt(1000000000) + 100000000,
      endereco: faker.address.streetAddress(),
      estado: faker.address.state(),
      municipio: faker.address.countryCode(),
      tipoEntrevista: "Selecione",
      status: "Não Iniciada",
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
    await tester.pumpWidget( MaterialApp(home: AberturaDomicilio(domicilio: dom),));
    final card = find.byKey(const ValueKey('Card1'));
    expect(card, findsOneWidget);
    final dropButton = find.byKey(const ValueKey('dropButton'));
    expect(dropButton, findsOneWidget);
    final button = find.byKey(const ValueKey('button'));
    expect(button, findsNothing);

    await tester.tap(dropButton);
    await tester.pumpAndSettle();

    ///if you want to tap first item
    //final dropdownItem = find.text('Realizada').last;

    final dropdownItem = find.byKey(const ValueKey('item2')).last;
    expect(dropdownItem, findsOneWidget);
    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();
    expect(button, findsOneWidget);
  });
}
