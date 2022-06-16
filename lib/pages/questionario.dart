import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetopesquisa/components/quesito.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';

import 'package:pesquisapack/pesquisapack.dart';
import 'package:location/location.dart';

class Questionario extends StatefulWidget {
  late DomicilioModel domicilio;
  bool semGps = true;
  Questionario({Key? key, required this.domicilio}) : super(key: key);

  @override
  State<Questionario> createState() => _QuestionarioState();
}

class _QuestionarioState extends State<Questionario> {
  late String quesito1;
  late String quesito2;
  late String quesito3;
  late String quesito4;
  late String quesito5;
  late String quesito6;
  late String quesito7;
  late LocationData localizacao;
  late String latitude;
  late String longitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quesito1 = widget.domicilio.quesito1;
    quesito2 = widget.domicilio.quesito2;
    quesito3 = widget.domicilio.quesito3;
    quesito4 = widget.domicilio.quesito4;
    quesito5 = widget.domicilio.quesito5;
    quesito6 = widget.domicilio.quesito6;
    quesito7 = widget.domicilio.quesito7;
    latitude = widget.domicilio.latitude;
    longitude = widget.domicilio.longitude;
  }

  void _buttonLocalizacao() async{
    localizacao = await pegarLocalizacao();
    latitude = localizacao.latitude.toString();
    longitude = localizacao.longitude.toString();
  }

  @override
  Widget build(BuildContext context) {
    final sentido = MediaQuery.of(context).orientation;
    final valor = ValidaQuestionario();
    final List<String> itemList1 = ['Selecione', 'Sim', 'Não'];
    final List<String> itemList2 = ['Selecione', 'Queimado (na propriedade)', 'Enterrado (na propriedade)', 'Jogado em terreno baldio ou logradouro', 'Outro destino',];

    return Scaffold(
      appBar: AppBar(
        title: sentido == Orientation.portrait ?
                const Text('Questionário Domicílio') :
                const Text('Questionário Domicílio', style: TextStyle(fontSize: 32),),
        actions: [
          IconButton(onPressed: _buttonLocalizacao, icon: const Icon(Icons.gps_fixed_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            sentido == Orientation.portrait ?
            const Text('1. Nas redondezas ou arredores do seu domicílio:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
            ) :
            const Text('1. Nas redondezas ou arredores do seu domicílio:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Quesito(texto: '1.1 - Existe iluminação pública?', valor: quesito1, function: setQuesito1, items: itemList1,),
            Quesito(texto: '1.2 - Existe transporte coletivo como ônibus, van, trem, metrô etc.?', valor: quesito2, function: setQuesito2, items: itemList1,),
            Quesito(texto: '1.3 - Existe creche ou escola pública?', valor: quesito3, function: setQuesito3, items: itemList1,),
            Quesito(texto: '1.4 - Existe posto de saúde ou outro centro de atendimento de saúde público?', valor: quesito4, function: setQuesito4, items: itemList1,),
            Quesito(texto: '1.5 - Existe policiamento?', valor: quesito5, function: setQuesito5, items: itemList1,),
            Quesito(texto: '1.6 - Existe coleta de lixo?', valor: quesito6, function: setQuesito6, items: itemList1,),
            quesito6 == 'Não' ? Quesito(texto: '1.6.1 - Qual é o (principal) destino dado ao lixo?', valor: quesito7, function: setQuesito7, items: itemList2,) : const SizedBox(height: 2),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.save, size: 32),
              label: sentido == Orientation.portrait ?
                      const Text('Salvar Questionario', style: TextStyle(fontSize: 16),) :
                      const Text('Salvar Questionario', style: TextStyle(fontSize: 26),),
              onPressed: () {
                if(valor.verificaGps(latitude, longitude) != "" && widget.semGps){
                  showConfirma(valor.verificaGps(latitude, longitude));
                } else if(valor.verificaQuesitosRespondidos(quesito1, quesito2, quesito3, quesito4, quesito5, quesito6) != ""){
                  showMsg(valor.verificaQuesitosRespondidos(quesito1, quesito2, quesito3, quesito4, quesito5, quesito6));
                }else if(valor.verificaQuesito7(quesito6, quesito7) != ""){
                  showMsg(valor.verificaQuesito7(quesito6, quesito7));
                } else{
                  salvaQuestionario();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  showConfirma(String text){
    final valor = ValidaQuestionario();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Atenção'),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancela'),
            child: const Text('Cancela'),
          ),
          TextButton(
            onPressed: () {
              widget.semGps = false;
              Navigator.pop(context, 'Confirma');
              if(valor.verificaQuesitosRespondidos(quesito1, quesito2, quesito3, quesito4, quesito5, quesito6) != ""){
                showMsg(valor.verificaQuesitosRespondidos(quesito1, quesito2, quesito3, quesito4, quesito5, quesito6));
              }else if(valor.verificaQuesito7(quesito6, quesito7) != ""){
                showMsg(valor.verificaQuesito7(quesito6, quesito7));
              } else{
                salvaQuestionario();
              }
            },
            child: const Text('Confirma'),
          ),
        ],
      ),
    );
  }

  showMsg(String text){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Questionário Inválido!'),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  salvaQuestionario(){
    final dom = DomicilioModel(
      id: widget.domicilio.id,
      controle: widget.domicilio.controle,
      endereco: widget.domicilio.endereco,
      estado: widget.domicilio.estado,
      municipio: widget.domicilio.municipio,
      tipoEntrevista: widget.domicilio.tipoEntrevista,
      status: "Finalizada",
      quesito1: quesito1,
      quesito2: quesito2,
      quesito3: quesito3,
      quesito4: quesito4,
      quesito5: quesito5,
      quesito6: quesito6,
      quesito7: quesito7,
      latitude: latitude,
      longitude: longitude,
    );
    salvar(dom);
  }

  salvar(DomicilioModel domicilio){
    updateUser(domicilio);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Future updateUser(DomicilioModel domicilio) async {
    final docUser = FirebaseFirestore.instance.collection('domicilios').doc(domicilio.id);

    final json = domicilio.toJson();
    await docUser.update(json);
  }

  FutureOr<LocationData> pegarLocalizacao() async {
    Location location =  Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Error();

        //return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Error();
        //return;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  void setQuesito1(String? select){
    if(select is String){
      setState((){
        quesito1 = select;
      });
    }
  }

  void setQuesito2(String? select){
    if(select is String){
      setState((){
        quesito2 = select;
      });
    }
  }

  void setQuesito3(String? select){
    if(select is String){
      setState((){
        quesito3 = select;
      });
    }
  }

  void setQuesito4(String? select){
    if(select is String){
      setState((){
        quesito4 = select;
      });
    }
  }

  void setQuesito5(String? select){
    if(select is String){
      setState((){
        quesito5 = select;
      });
    }
  }

  void setQuesito6(String? select){
    if(select is String){
      setState((){
        quesito6 = select;
        if (quesito6 != 'Não') {
          quesito7 = 'Selecione';
        }
      });
    }
  }

  void setQuesito7(String? select){
    if(select is String){
      setState((){
        quesito7 = select;
      });
    }
  }
}
