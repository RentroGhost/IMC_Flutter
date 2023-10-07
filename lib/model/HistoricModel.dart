import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'HistoricModel.g.dart';

@HiveType(typeId: 1)
class HistoricModel extends HiveObject {
@HiveField(0)
final id = UniqueKey().toString(); 
@HiveField(1)
String nome = "";
@HiveField(2)
double altura = 0;
@HiveField(3)
double peso = 0;
@HiveField(4)
double imc = 0;
@HiveField(5)
String situacao = "";


HistoricModel();

HistoricModel.criar(this.nome,this.altura,this.peso, this.imc, this.situacao);

HistoricModel.vazio() {
  nome = "";
  altura = 0;
  peso = 0;
  imc = 0;
  situacao = "";
}

}