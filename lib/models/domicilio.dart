import 'package:equatable/equatable.dart';

class Domicilio extends Equatable{
  late int controle;
  late String endereco;
  late String estado;
  late String municipio;
  late String tipoEntrevista;
  late String status;
  late String telefone;

  Domicilio({
    required this.controle,
    required this.endereco,
    required this.estado,
    required this.municipio,
    required this.tipoEntrevista,
    required this.status,
    required this.telefone
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}