import 'package:calculadoraimcflutter/model/CalculatorModel.dart';
import 'package:calculadoraimcflutter/model/HistoricModel.dart';
import 'package:calculadoraimcflutter/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(CalculatorModelAdapter());
  Hive.registerAdapter(HistoricModelAdapter());

  runApp(const MyApp());
}