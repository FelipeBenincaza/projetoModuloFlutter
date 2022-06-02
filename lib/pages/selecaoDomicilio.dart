import 'package:flutter/material.dart';
import 'package:projetopesquisa/models/domicilio.dart';
import 'package:projetopesquisa/pages/aberturaDomicilio.dart';

class SelecaoDomicilio extends StatefulWidget {
  const SelecaoDomicilio({Key? key}) : super(key: key);

  @override
  State<SelecaoDomicilio> createState() => _SelecaoDomicilioState();
}

class _SelecaoDomicilioState extends State<SelecaoDomicilio> {
  final domicilios = [
    Domicilio(controle: 2022124, endereco: "Rua padre fonseca de primeira, 70 - Iraja", estado: 'Rio de Janeiro', municipio: "Rio de Janeiro", status: 'Não Iniciado'),
    Domicilio(controle: 2022564, endereco: "Rua dias, 56 - Bangu", estado: 'Rio de Janeiro', municipio: "Rio de Janeiro", status: 'Não Iniciado'),
    Domicilio(controle: 2022755, endereco: "Rua sete de setembro, 7 - Centro", estado: 'Rio de Janeiro', municipio: "Rio de Janeiro", status: 'Não Iniciado'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Seleção de Domicílios'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: domicilios.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                  child: ListTile(
                      title: Text("Controle: ${domicilios[index].controle.toString()}"),
                      subtitle: Text("Status: ${domicilios[index].status.toString()}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AberturaDomicilio(domicilio: domicilios[index],)),
                        );
                      },
                      leading: const Icon(Icons.article_outlined,
                      size: 36,)
                  ),
              );
            }),
      ),
    );
  }
}
