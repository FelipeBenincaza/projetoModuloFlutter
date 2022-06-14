import 'package:flutter/material.dart';

import '../models/domicilio.dart';

class Questionario extends StatefulWidget {
  late Domicilio domicilio;
  Questionario({Key? key, required this.domicilio}) : super(key: key);

  @override
  State<Questionario> createState() => _QuestionarioState();
}

class _QuestionarioState extends State<Questionario> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionário Domicílio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('1. Nas redondezas ou arredores do seu domicílio:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            Text('1.1. Existe iluminação pública?',
                style: TextStyle(fontSize: 16,),),
          ],
        ),
      ),
    );
  }
}
