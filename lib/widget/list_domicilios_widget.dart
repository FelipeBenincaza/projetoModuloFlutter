import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';
import 'package:projetopesquisa/pages/aberturaDomicilio.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListDomiciliosWidget extends StatefulWidget {
  const ListDomiciliosWidget({Key? key}) : super(key: key);

  @override
  _ListDomiciliosWidgetState createState() => _ListDomiciliosWidgetState();
}

class _ListDomiciliosWidgetState extends State<ListDomiciliosWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => buildUsers();

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

  Widget buildUser(DomicilioModel domicilio) =>Slidable(
      key: Key(domicilio.id.toString()),
      endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              label: 'Enviar',
              backgroundColor: Colors.green,
              icon: Icons.update,
              onPressed: (BuildContext context) async{
                deleteUser(domicilio);
                final snackBar = SnackBar(
                  backgroundColor: Colors.blueAccent,
                  content: Text(
                    'Controle ${domicilio.controle} foi excluído!',
                    style: const TextStyle(fontSize: 24),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ]),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
              child: tipoIcon(domicilio.status),),
          title: Text("Controle: ${domicilio.controle.toString()}"),
          subtitle: Text("Status: ${domicilio.status.toString()}"),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AberturaDomicilio(domicilio: domicilio),
          )),
        ),
      ),
  );

  tipoIcon(String status){
    if(status == 'Finalizada'){
      return const Icon( Icons.assignment_turned_in, size: 36,);
    } else if (status == 'Em andamento'){
      return const Icon( Icons.edit_note_outlined, size: 36,);
    }else{
      return const Icon( Icons.article_outlined, size: 36,);
    }
  }

  Stream<List<DomicilioModel>> readUsers() => FirebaseFirestore.instance
      .collection('domicilios')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => DomicilioModel.fromJson(doc.data()))
          .toList());

  Future<DomicilioModel?> readUser() async {
    /// Get single document by ID
    final docUser =
        FirebaseFirestore.instance.collection('domicilios').doc('id');
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return DomicilioModel.fromJson(snapshot.data()!);
    }
  }

  Future deleteUser(DomicilioModel domicilio) async {
    /// Reference to document
    final docUser = FirebaseFirestore.instance.collection('domicilios').doc(domicilio.id);

    await docUser.delete();
  }

  void showSnackBar(ScaffoldState? currentState, String s) {
    final snackBar = SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 1),
    );
    currentState?.showSnackBar(snackBar);
  }
}
