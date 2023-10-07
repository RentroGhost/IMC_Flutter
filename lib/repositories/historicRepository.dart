// ignore_for_file: list_remove_unrelated_type

import 'package:calculadoraimcflutter/model/HistoricModel.dart';
import 'package:hive/hive.dart';

class HistoricRepository {
  static late Box _box;

  static Future<HistoricRepository> carregar() async {
      if (!Hive.isBoxOpen('box_historicos')) {
    _box = await Hive.openBox('box_historicos');
  }
  else {
    _box = Hive.box('box_historicos');
  }

  return HistoricRepository._criar();
  }

  HistoricRepository._criar();

  salvar(HistoricModel) {
    _box.add(HistoricModel);
  }

  alterar(HistoricModel historicModel) {
    historicModel.save();
  }

  excluir(HistoricModel historicModel) {
    historicModel.delete();
  }

  Future<List<HistoricModel>> listHistoric() async {
     return _box.values.cast<HistoricModel>().toList();
  }


}