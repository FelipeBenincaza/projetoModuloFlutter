import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projetopesquisa/controller/domicilios_controller.dart';
import 'package:projetopesquisa/models/domicilio.dart';
import 'package:projetopesquisa/pages/aberturaDomicilio.dart';
import 'package:pesquisapack/pesquisapack.dart';

class SelecaoDomicilio extends StatefulWidget {
  const SelecaoDomicilio({Key? key}) : super(key: key);

  @override
  State<SelecaoDomicilio> createState() => _SelecaoDomicilioState();
}

class _SelecaoDomicilioState extends State<SelecaoDomicilio> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); //uso do Slidable
  late DomiciliosController domiciliosController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    domiciliosController = DomiciliosController();
    domiciliosController.getDomicilios();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Seleção de Domicílios'),
          actions: [
            IconButton(onPressed: addDomicilio, icon: Icon(Icons.add)),
            IconButton(onPressed: sair, icon: Icon(Icons.exit_to_app)),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(5),
          child: AnimatedBuilder(
            animation: domiciliosController,
            builder: (context, child) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: domiciliosController.listDomicilios.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: Key(domiciliosController
                          .listDomicilios[index].controle
                          .toString()),
                        endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                        SlidableAction(
                        label: 'Enviar',
                        backgroundColor: Colors.blueAccent,
                        icon: Icons.update,
                        onPressed: (BuildContext context) async{
                          final update = domiciliosController.listDomicilios[index];
                          await domiciliosController.deleteDomicilioIndex(index);

                          showSnackBar(scaffoldKey.currentState, 'Atualizado');

                        },
                      ),
                    ]),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                            title: Text(
                                "Controle: ${domiciliosController.listDomicilios[index].controle.toString()}"),
                            subtitle: Text(
                                "Status: ${domiciliosController.listDomicilios[index].status.toString()}"),
                            onTap: () {
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AberturaDomicilio(domicilio: domiciliosController.listDomicilios[index],)
                                ),
                              );*/
                            },
                            leading: const Icon(
                              Icons.article_outlined,
                              size: 36,
                            )),
                      )
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  addDomicilio() {
    final faker = Faker();
    Domicilio dom = Domicilio(
        controle: faker.hashCode,
        endereco: faker.address.streetAddress(),
        estado: faker.address.state(),
        municipio: faker.address.countryCode(),
        tipoEntrevista: "Selecione",
        status: "Não Iniciado",
    );
    domiciliosController.addDomicilio(dom);
  }

  sair() {
    FirebaseAuth.instance.signOut();
  }

  void showSnackBar(ScaffoldState? currentState, String s) {
    final snackBar = SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 1),
    );
    currentState?.showSnackBar(snackBar);
  }
}
