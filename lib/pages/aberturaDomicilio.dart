import 'package:flutter/material.dart';
import 'package:projetopesquisa/components/campo_informacao.dart';
import 'package:projetopesquisa/models/domicilio.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';
import 'package:projetopesquisa/pages/questionario.dart';
import 'package:projetopesquisa/pages/selecaoDomicilio.dart';

import '../controller/domicilios_controller.dart';

class AberturaDomicilio extends StatefulWidget {
  late DomicilioModel domicilio;

  AberturaDomicilio({Key? key, required this.domicilio}) : super(key: key);

  @override
  State<AberturaDomicilio> createState() => _AberturaDomicilioState();
}

class _AberturaDomicilioState extends State<AberturaDomicilio> {
  late String tipoEntrevista;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tipoEntrevista = widget.domicilio.tipoEntrevista;
  }

  void setValorDrop(String? select) {
    if (select is String) {
      setState(() {
        tipoEntrevista = select;
      });
    }
  }

  bool get isTipoEntrevistaRealizar {
    return tipoEntrevista != "Selecione";
  }

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
            CampoInformacao(
                campo: "Controle:",
                informacao: widget.domicilio.controle.toString()),
            CampoInformacao(
                campo: "Endereço:", informacao: widget.domicilio.endereco),
            CampoInformacao(
                campo: "Município:", informacao: widget.domicilio.municipio),
            CampoInformacao(
                campo: "Estado:", informacao: widget.domicilio.estado),
            const Text(
              "Tipo de Entrevista:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.fromLTRB(0, 5, 5, 10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: DropdownButton(
                  items: const [
                    DropdownMenuItem(
                      child: Text('Selecione'),
                      value: 'Selecione',
                    ),
                    DropdownMenuItem(
                      child: Text('Realizar'),
                      value: 'Realizar',
                    ),
                    DropdownMenuItem(
                      child: Text('Recusa'),
                      value: 'Recusa',
                    ),
                    DropdownMenuItem(
                      child: Text('Morador não encontrado'),
                      value: 'Morador não encontrado',
                    ),
                  ],
                  value: tipoEntrevista,
                  onChanged: setValorDrop,
                  iconEnabledColor: Colors.green,
                  isExpanded: true,
                ),
              ),
            ),
            isTipoEntrevistaRealizar ?
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: Icon(
                tipoEntrevista == 'Realizar' ? Icons.article_outlined : Icons.assignment_turned_in,
                size: 32,
              ),
              label: Text(
                tipoEntrevista == 'Realizar' ? 'Abrir Questionário' : 'Finalizar Domicílio',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: _clickButton,
            ) : const Align(
              alignment: Alignment.center,
              child: Text(
                "Favor selecionar o Tipo de Entrevista!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
              ) ,
            )
          ],
        ),
      ),
    );
  }

  _clickButton(){
    if (tipoEntrevista == "Realizar"){
      /*widget.domicilio.status = "Em Andamento";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Questionario(
            domicilio: widget.domicilio,
          ),
        ),
      );*/
    }else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelecaoDomicilio(),
        ),
      );
    }
  }
}
