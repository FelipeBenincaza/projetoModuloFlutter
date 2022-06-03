import 'package:flutter/material.dart';
import 'package:projetopesquisa/infra/carrega_dados.dart';
import 'package:projetopesquisa/models/domicilio.dart';

class DomiciliosController extends ChangeNotifier{
  late List<Domicilio> listDomicilios = <Domicilio>[];

  Future getDomicilios() async{
    listDomicilios = await CarregaDados().getDado();
    notifyListeners();
  }

  addDomicilio(Domicilio domicilio){
    listDomicilios.add(domicilio);
    notifyListeners();
  }

  deleteDomicilioIndex(int domicilio){
    listDomicilios.removeAt(domicilio);
    notifyListeners();
  }

  deleteDomicilio(Domicilio domicilio){
    listDomicilios.remove(domicilio);
    notifyListeners();
  }

  atualizarDomicilio(int indice, Domicilio domicilio){
    listDomicilios[indice] = domicilio;
    notifyListeners();
  }
}