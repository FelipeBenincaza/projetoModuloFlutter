import 'package:flutter/material.dart';
import 'package:projetopesquisa/models/domicilio.dart';

class AberturaDomicilio extends StatefulWidget {
  late Domicilio domicilio;
  AberturaDomicilio({Key? key, required this.domicilio}) : super(key: key);

  @override
  State<AberturaDomicilio> createState() => _AberturaDomicilioState();
}

class _AberturaDomicilioState extends State<AberturaDomicilio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Abertura do Domicílio'),
        ),
        body: Column(children: [
          Text("Controle: ${widget.domicilio.controle.toString()}"),
          Text("Status: ${widget.domicilio.status}"),
        ],)
      );
  }
}
