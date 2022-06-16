import 'package:flutter/material.dart';

class CampoInformacao extends StatelessWidget {
  String campo;
  String informacao;

  CampoInformacao({Key? key, required this.campo, required this.informacao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sentido = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        sentido == Orientation.portrait ?
          Text( campo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),) :
          Text( campo, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        Card(
          elevation: 5,
          margin: const EdgeInsets.fromLTRB(0,5,5,10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12,8,8,8),
            child: sentido == Orientation.portrait ?
            Text( informacao, style: const TextStyle(fontSize: 18,),) :
            Text( informacao, style: const TextStyle(fontSize: 24,),),
          ),
        ),
      ],
    );
  }
}
