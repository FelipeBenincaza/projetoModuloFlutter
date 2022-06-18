import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';

class DomicilioPage extends StatefulWidget {
  const DomicilioPage({Key? key}) : super(key: key);

  @override
  State<DomicilioPage> createState() => _DomicilioPageState();
}

class _DomicilioPageState extends State<DomicilioPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerEndereco;
  late TextEditingController controllerMunicipio;
  late TextEditingController controllerEstado;

  @override
  void initState() {
    super.initState();
    controllerEndereco = TextEditingController();
    controllerMunicipio = TextEditingController();
    controllerEstado = TextEditingController();
  }

  @override
  void dispose() {
    controllerEndereco.dispose();
    controllerMunicipio.dispose();
    controllerEstado.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sentido = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: sentido == Orientation.portrait
            ? const Text('Cadastrar Domicílio')
            : const Text(
                'Cadastrar Domicílio',
                style: TextStyle(fontSize: 32),
              ),
        actions: [
          IconButton(
            key: const ValueKey("addFaker"),
            icon: const Icon(Icons.add),
            onPressed: (){
              controllerEndereco.text = faker.address.streetAddress();
              controllerMunicipio.text = faker.address.city();
              controllerEstado.text = faker.address.state();
            },
          ),
        ],
      ),
      body:  Form(
          key: formKey,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            TextFormField(
              key: const ValueKey("endereco"),
              controller: controllerEndereco,
              decoration: decoration('Endereço'),
              validator: (text) =>
                  text != null && text.isEmpty ? 'Dados invalidos' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: const ValueKey("municipio"),
              controller: controllerMunicipio,
              decoration: decoration('Município'),
              keyboardType: TextInputType.number,
              validator: (text) => text != null && text.isEmpty
                  ? 'Dados invalidos'
                  : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: const ValueKey("estado"),
              controller: controllerEstado,
              decoration: decoration('Estado'),
              keyboardType: TextInputType.number,
              validator: (text) => text != null && text.isEmpty
                  ? 'Dados invalidos'
                  : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              key: const ValueKey("buttonSalvar"),
              label: Text("Salvar",
                style: sentido == Orientation.portrait ?
                  TextStyle(fontSize: 16) :
                  TextStyle(fontSize: 26),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: Icon(Icons.article_outlined, size: 32,),
              onPressed: () {
                final isValid = formKey.currentState!.validate();

                if (isValid) {
                  final dom = DomicilioModel(
                    id: '',
                    controle: Random().nextInt(1000000000) + 100000000,
                    endereco: controllerEndereco.text,
                    estado: controllerEstado.text,
                    municipio: controllerMunicipio.text,
                    tipoEntrevista: "Selecione",
                    status: "Não Iniciado",
                    quesito1: "Selecione",
                    quesito2: "Selecione",
                    quesito3: "Selecione",
                    quesito4: "Selecione",
                    quesito5: "Selecione",
                    quesito6: "Selecione",
                    quesito7: "Selecione",
                    latitude: "",
                    longitude: "",
                  );

                  createUser(dom);
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'Controle ${dom.controle} cadastrado!',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                }
              },
            )
          ]),
        ),
      );
  }

  InputDecoration decoration(String label) => InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
  );

  Future createUser(DomicilioModel domicilio) async {
    final docUser = FirebaseFirestore.instance.collection('domicilios').doc();
    domicilio.id = docUser.id;

    final json = domicilio.toJson();
    await docUser.set(json);
  }
}
