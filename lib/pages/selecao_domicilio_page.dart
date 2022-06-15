import 'dart:math';

import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetopesquisa/widget/list_domicilios_widget.dart';

class TempHomePage extends StatelessWidget {
  const TempHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListDomiciliosWidget(),
    );
  }
}
class SelecaoDomicilioPage extends StatefulWidget {
  const SelecaoDomicilioPage({Key? key}) : super(key: key);

  @override
  _SelecaoDomicilioPageState createState() => _SelecaoDomicilioPageState();
}
class _SelecaoDomicilioPageState extends State<SelecaoDomicilioPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Seleção dos Domicílios'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: createDomicilio,
        ),
        IconButton(onPressed: sair, icon: Icon(Icons.exit_to_app)),
      ],
    ),
    body: const TempHomePage(),
  );

  Future createDomicilio() async {
    /// Reference to document
    final docUser = FirebaseFirestore.instance.collection('domicilios').doc();

    final json = {
      'id': docUser.id,
      'controle': Random().nextInt(1000000000) + 100000000,
      'endereco': faker.address.streetAddress(),
      'estado': faker.address.state(),
      'municipio': faker.address.countryCode(),
      'tipoEntrevista': "Selecione",
      'status': "Não Iniciado",
      'quesito1': "Selecione",
      'quesito2': "Selecione",
      'quesito3': "Selecione",
      'quesito4': "Selecione",
      'quesito5': "Selecione",
      'quesito6': "Selecione",
      'latitude': "",
      'longitude': "",
    };

    /// Create document and write data to Firebase
    await docUser.set(json);
  }

  sair() {
    FirebaseAuth.instance.signOut();
  }
}