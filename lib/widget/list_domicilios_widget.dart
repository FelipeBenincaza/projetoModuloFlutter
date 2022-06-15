import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';
import 'package:projetopesquisa/pages/aberturaDomicilio.dart';

class ListDomiciliosWidget extends StatefulWidget {
  @override
  _ListDomiciliosWidgetState createState() => _ListDomiciliosWidgetState();
}

class _ListDomiciliosWidgetState extends State<ListDomiciliosWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => buildUsers();
    /*  Scaffold(
    appBar: AppBar(
      title: const Text('Seleção dos Domicílios'),
    ),
    body: buildUsers(),
    // body: buildSingleUser(),

  );*/

  Widget buildUsers() => StreamBuilder<List<DomicilioModel>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final users = snapshot.data!;

          return ListView(
            children: users.map(buildUser).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Widget buildSingleUser() => FutureBuilder<DomicilioModel?>(
    future: readUser(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong! ${snapshot.error}');
      } else if (snapshot.hasData) {
        final user = snapshot.data;

        return user == null
            ? const Center(child: Text('No Domicilios'))
            : buildUser(user);
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );

  Widget buildUser(DomicilioModel domicilio) => Card(
      elevation: 5,
      child:ListTile(
    leading: const CircleAvatar(child: Icon(
      Icons.article_outlined,
      size: 36,
    )),
    title: Text("Controle: ${domicilio.controle.toString()}"),
    subtitle: Text("Status: ${domicilio.status.toString()}"),
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AberturaDomicilio(domicilio: domicilio),
    )),
  ),);

  Stream<List<DomicilioModel>> readUsers() => FirebaseFirestore.instance
      .collection('domicilios')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => DomicilioModel.fromJson(doc.data())).toList());

  Future<DomicilioModel?> readUser() async {
    /// Get single document by ID
    final docUser = FirebaseFirestore.instance.collection('domicilios').doc('id');
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return DomicilioModel.fromJson(snapshot.data()!);
    }
  }
}