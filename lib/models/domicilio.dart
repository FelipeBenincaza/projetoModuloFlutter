import 'package:equatable/equatable.dart';

class Domicilio extends Equatable{
  late int controle;
  late String endereco;
  late String estado;
  late String municipio;
  late String status;

  Domicilio({
    required this.controle,
    required this.endereco,
    required this.estado,
    required this.municipio,
    required this.status
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}