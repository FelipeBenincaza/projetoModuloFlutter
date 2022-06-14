import '../models/domicilio.dart';

class CarregaDados{
  final domicilios = [
    Domicilio(controle: 2022124, endereco: "Rua padre fonseca de primeira, 70 - Iraja", estado: 'Rio de Janeiro', municipio: "Rio de Janeiro", tipoEntrevista: 'Não Iniciado', status: 'Não Iniciado', telefone: '(21)2659863'),
    Domicilio(controle: 2022564, endereco: "Rua dias, 56 - Bangu", estado: 'Rio de Janeiro', municipio: "Rio de Janeiro", tipoEntrevista: 'Não Iniciado', status: 'Não Iniciado', telefone: '(21)35621487'),
    Domicilio(controle: 2022755, endereco: "Rua sete de setembro, 7 - Centro", estado: 'Rio de Janeiro', municipio: "Rio de Janeiro", tipoEntrevista: 'Não Iniciado', status: 'Não Iniciado', telefone: '(21)996584236'),
  ];

  Future getDado() async{
    return domicilios;
  }
}