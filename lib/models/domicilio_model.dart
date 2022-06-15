import 'package:cloud_firestore/cloud_firestore.dart';

class DomicilioModel {
  String id;
  final int controle;
  final String endereco;
  final String estado;
  final String municipio;
  final String tipoEntrevista;
  final String status;
  final String quesito1;
  final String quesito2;
  final String quesito3;
  final String quesito4;
  final String quesito5;
  final String quesito6;
  final String latitude;
  final String longitude;

  DomicilioModel({
    this.id = '',
    required this.controle,
    required this.endereco,
    required this.estado,
    required this.municipio,
    required this.tipoEntrevista,
    required this.status,
    required this.quesito1,
    required this.quesito2,
    required this.quesito3,
    required this.quesito4,
    required this.quesito5,
    required this.quesito6,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'controle': controle,
    'endereco': endereco,
    'estado': estado,
    'municipio': municipio,
    'tipoEntrevista': tipoEntrevista,
    'status': status,
    'quesito1': quesito1,
    'quesito1': quesito1,
    'quesito2': quesito2,
    'quesito3': quesito3,
    'quesito4': quesito4,
    'quesito5': quesito5,
    'quesito6': quesito6,
    'latitude': latitude,
    'longitude': longitude,
  };

  static DomicilioModel fromJson(Map<String, dynamic> json) => DomicilioModel(
    id: json['id'],
    controle: json['controle'],
    endereco: json['endereco'],
    estado: json['estado'],
    municipio: json['municipio'],
    tipoEntrevista: json['tipoEntrevista'],
    status: json['status'],
    quesito1: json['quesito1'],
    quesito2: json['quesito2'],
    quesito3: json['quesito3'],
    quesito4: json['quesito4'],
    quesito5: json['quesito5'],
    quesito6: json['quesito6'],
    latitude: json['latitude'],
    longitude: json['longitude'],
  );
}