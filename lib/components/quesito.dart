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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          texto,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        DropdownButton(
          items: items.map((item) => DropdownMenuItem(
            child: Text(item),
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
