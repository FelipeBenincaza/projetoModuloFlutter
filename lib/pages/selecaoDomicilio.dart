import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:projetopesquisa/controller/domicilios_controller.dart';
import 'package:projetopesquisa/models/domicilio.dart';
import 'package:projetopesquisa/pages/aberturaDomicilio.dart';

class SelecaoDomicilio extends StatefulWidget {
  const SelecaoDomicilio({Key? key}) : super(key: key);

  @override
  State<SelecaoDomicilio> createState() => _SelecaoDomicilioState();
}

class _SelecaoDomicilioState extends State<SelecaoDomicilio> {
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
                    return Card(
                      elevation: 5,
                      child: ListTile(
                          title: Text(
                              "Controle: ${domiciliosController.listDomicilios[index].controle.toString()}"),
                          subtitle: Text(
                              "Status: ${domiciliosController.listDomicilios[index].status.toString()}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AberturaDomicilio(
                                        domicilio: domiciliosController
                                            .listDomicilios[index],
                                      )),
                            );
                          },
                          leading: const Icon(
                            Icons.article_outlined,
                            size: 36,
                          )),
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
      status: "Não Iniciado",
    );
    domiciliosController.addDomicilio(dom);
  }
}
