import 'package:flutter/material.dart';
import 'package:projetopesquisa/components/campo_informacao.dart';
import 'package:projetopesquisa/models/domicilio.dart';
import 'package:projetopesquisa/pages/questionario.dart';

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
      body: SingleChildScrollView(
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
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.article_outlined, size: 32),
              label: const Text(
                'Abrir Questionário',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Questionario(domicilio: widget.domicilio,)
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
