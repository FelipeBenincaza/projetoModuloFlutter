import 'package:flutter/material.dart';

class Quesito extends StatelessWidget {
  final String texto;
  final String valor;
  final Function(String?) function;
  final List<String> items;

  Quesito({
    Key? key,
    required this.texto,
    required this.valor,
    required this.function,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sentido = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          texto,
          style: sentido == Orientation.portrait ?
          const TextStyle(
            fontSize: 18,
          ) : const TextStyle(
            fontSize: 22,
          ),
        ),
        DropdownButton(
          items: items.map((item) => DropdownMenuItem(
                  child: Text(
                    item,
                    style: sentido == Orientation.portrait ?
                    const TextStyle( fontSize: 16,) :
                    const TextStyle( fontSize: 22,),
                  ),
                  value: item,
                ),).toList(),
          value: valor,
          onChanged: function,
          iconEnabledColor: Colors.green,
          isExpanded: true,
        ),
      ],
    );
  }
}
