import 'package:flutter/material.dart';
import 'package:projetopesquisa/components/campo_informacao.dart';
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CampoInformacao(campo: "Controle:", informacao: widget.domicilio.controle.toString()),
            CampoInformacao(campo: "Endereço:", informacao: widget.domicilio.endereco),
            CampoInformacao(campo: "Município:", informacao: widget.domicilio.municipio),
            CampoInformacao(campo: "Estado:", informacao: widget.domicilio.estado),
            CampoInformacao(campo: "Status:", informacao: widget.domicilio.status),
          ],
        ),
      ),
    );
  }
}
