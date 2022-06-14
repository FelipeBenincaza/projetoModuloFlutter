import 'package:flutter/material.dart';

class Quesito extends StatelessWidget {
  final String texto;
  final String valor;
  final Function(String?) function;

  Quesito(
      {Key? key,
      required this.texto,
      required this.valor,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          texto,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        DropdownButton(
          items: const [
            DropdownMenuItem(
              child: Text('Selecione'),
              value: 'Selecione',
            ),
            DropdownMenuItem(
              child: Text('Sim'),
              value: 'Sim',
            ),
            DropdownMenuItem(
              child: Text('Não'),
              value: 'Não',
            ),
          ],
          value: valor,
          onChanged: function,
          iconEnabledColor: Colors.green,
          isExpanded: true,
        ),
      ],
    );
  }
}
