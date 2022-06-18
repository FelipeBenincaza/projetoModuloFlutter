import 'package:flutter/material.dart';
import 'package:projetopesquisa/components/campo_informacao.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';
import 'package:projetopesquisa/pages/questionario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    final sentido = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: sentido == Orientation.portrait ?
        const Text('Abertura do Domicílio') :
        const Text('Abertura do Domicílio', style: TextStyle(fontSize: 32),),
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
            sentido == Orientation.portrait ?
              const Text( "Tipo de Entrevista:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),) :
              const Text( "Tipo de Entrevista:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Card(
              key: const ValueKey('Card1'),
              elevation: 5,
              margin: const EdgeInsets.fromLTRB(0, 5, 5, 10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: sentido == Orientation.portrait ?
                DropdownButton(
                  key: const ValueKey('dropButton'),
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
                  iconEnabledColor: Colors.lightBlue,
                  isExpanded: true,
                ) :
                DropdownButton(
                  key: const ValueKey('dropButton'),
                  items: const [
                    DropdownMenuItem(
                      key: ValueKey('item1'),
                      child: Text('Selecione', style: TextStyle(fontSize: 24)),
                      value: 'Selecione',
                    ),
                    DropdownMenuItem(
                      key: ValueKey('item2'),
                      child: Text('Realizar', style: TextStyle(fontSize: 24)),
                      value: 'Realizar',
                    ),
                    DropdownMenuItem(
                      key: ValueKey('item3'),
                      child: Text('Recusa', style: TextStyle(fontSize: 24)),
                      value: 'Recusa',
                    ),
                    DropdownMenuItem(
                      key: ValueKey('item4'),
                      child: Text('Morador não encontrado', style: TextStyle(fontSize: 24)),
                      value: 'Morador não encontrado',
                    ),
                  ],
                  value: tipoEntrevista,
                  onChanged: setValorDrop,
                  iconEnabledColor: Colors.lightBlue,
                  isExpanded: true,
                ),
              ),
            ),
            isTipoEntrevistaRealizar ?
            ElevatedButton.icon(
              key: const ValueKey('button'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: Icon(
                tipoEntrevista == 'Realizar' ? Icons.article_outlined : Icons.assignment_turned_in,
                size: 32,
              ),
              label: Text(
                tipoEntrevista == 'Realizar' ? 'Abrir Questionário' : 'Finalizar Domicílio',
                style: sentido == Orientation.portrait ?
                        TextStyle(fontSize: 16) :
                        TextStyle(fontSize: 26),
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
    final dom = DomicilioModel(
      id: widget.domicilio.id,
      controle: widget.domicilio.controle,
      endereco: widget.domicilio.endereco,
      estado: widget.domicilio.estado,
      municipio: widget.domicilio.municipio,
      tipoEntrevista: tipoEntrevista,
      status: tipoEntrevista == "Realizar" ? "Em andamento" : "Finalizada",
      quesito1: widget.domicilio.quesito1,
      quesito2: widget.domicilio.quesito2,
      quesito3: widget.domicilio.quesito3,
      quesito4: widget.domicilio.quesito4,
      quesito5: widget.domicilio.quesito5,
      quesito6: widget.domicilio.quesito6,
      quesito7: widget.domicilio.quesito7,
      latitude: widget.domicilio.latitude,
      longitude: widget.domicilio.longitude,
    );

    if (tipoEntrevista == "Realizar"){
      updateUser(dom);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Questionario(
            domicilio: dom,
          ),
        ),
      );
    }else {
      updateUser(dom);
      Navigator.pop(context);
    }
  }

  Future updateUser(DomicilioModel domicilio) async {
    final docUser = FirebaseFirestore.instance.collection('domicilios').doc(domicilio.id);

    final json = domicilio.toJson();
    await docUser.update(json);
  }
}
