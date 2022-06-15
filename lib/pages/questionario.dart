import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projetopesquisa/components/quesito.dart';
import 'package:projetopesquisa/models/domicilio_model.dart';
import 'package:projetopesquisa/pages/selecao_domicilio_page.dart';

import 'package:pesquisapack/pesquisapack.dart';
import 'package:location/location.dart';

class Questionario extends StatefulWidget {
  late DomicilioModel domicilio;
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
  late LocationData localizacao;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quesito1 = "Selecione";
    quesito2 = "Selecione";
    quesito3 = "Selecione";
    quesito4 = "Selecione";
    quesito5 = "Selecione";
    quesito6 = "Selecione";
  }

  void _buttonLocalizacao() async{
    localizacao = await pegarLocalizacao();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionário Domicílio'),
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
            const Text('1. Nas redondezas ou arredores do seu domicílio:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Quesito(texto: '1.1. Existe iluminação pública?', valor: quesito1, function: setQuesito1),
            Quesito(texto: '1.2. Existe transporte coletivo como ônibus, van, trem, metrô etc.?', valor: quesito2, function: setQuesito2),
            Quesito(texto: '1.3. Existe creche ou escola pública?', valor: quesito3, function: setQuesito3),
            Quesito(texto: '1.4. Existe posto de saúde ou outro centro de atendimento de saúde público?', valor: quesito4, function: setQuesito4),
            Quesito(texto: '1.5. Existe policiamento?', valor: quesito5, function: setQuesito5),
            Quesito(texto: '1.6. Existe coleta de lixo?', valor: quesito6, function: setQuesito6),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.save, size: 32),
              label: const Text(
                'Salvar Questionario',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            )
          ],
        ),
      ),
    );
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
      });
    }
  }
}
