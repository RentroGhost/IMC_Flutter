import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'CalculatorModel.g.dart';

@HiveType(typeId: 0)
class CalculatorModel extends HiveObject {
@HiveField(0)
double? altura = 0;
@HiveField(1)
double? peso = 0;
@HiveField(2)
double? imc = 0;
@HiveField(3)
String? situacao = "";

CalculatorModel();

CalculatorModel.vazio() {
  altura = 0;
  peso = 0;
  imc = 0;
  situacao = "";
}

}