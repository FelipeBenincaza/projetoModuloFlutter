import 'package:flutter/material.dart';
import 'package:projetopesquisa/pages/selecaoDomicilio.dart';

void main() {
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const SelecaoDomicilio();
  }
}
