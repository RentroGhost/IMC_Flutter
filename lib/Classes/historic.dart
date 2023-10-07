import 'package:flutter/material.dart';

class Historic {
  final String _id = UniqueKey().toString();
  String _nome = "";
  double _imc = 0.0;
  String _situacao = "";
  DateTime _data = DateTime(0);

  Historic(this._nome, this._imc, this._situacao, this._data);

  String get id => _id;

  String get nome => _nome;

  set nome(String nome){
    _nome = nome;
  }
  
  double get imc => _imc;
  
  set imc(double imc){
    _imc = imc;
  }

  String get situacao => _situacao;

  set situacao(String situacao){
    _situacao = situacao;
  }

  DateTime get data => _data;

   set data(DateTime data){
    _data = data;
  }
}