import 'package:cloud_firestore/cloud_firestore.dart';

class DomicilioModel {
  String id;
  final int controle;
  final String endereco;
  final String estado;
  final String municipio;
  final String tipoEntrevista;
  final String status;

  DomicilioModel({
    this.id = '',
    required this.controle,
    required this.endereco,
    required this.estado,
    required this.municipio,
    required this.tipoEntrevista,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'controle': controle,
    'endereco': endereco,
    'estado': estado,
    'municipio': municipio,
    'tipoEntrevista': tipoEntrevista,
    'status': status,
  };

  static DomicilioModel fromJson(Map<String, dynamic> json) => DomicilioModel(
    id: json['id'],
    controle: json['controle'],
    endereco: json['endereco'],
    estado: json['estado'],
    municipio: json['municipio'],
    tipoEntrevista: json['tipoEntrevista'],
    status: json['status'],
  );
}