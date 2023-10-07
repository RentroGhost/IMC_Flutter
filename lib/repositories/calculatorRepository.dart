import 'package:calculadoraimcflutter/model/CalculatorModel.dart';
import 'package:calculadoraimcflutter/model/HistoricModel.dart';
import 'package:hive/hive.dart';

class CalculatorRepository {
  static late Box _box;


  static Future<CalculatorRepository> carregar() async {
      if (Hive.isBoxOpen('calculatorModel')) {
    _box = Hive.box('calculatorModel');
  }
  else {
    _box = await Hive.openBox('calculatorModel');
  }

  return CalculatorRepository._criar();
  }

  CalculatorRepository._criar();

  salvar(calculatorModel) async {
    await _box.put('calculatorModel', calculatorModel);
  }

  CalculatorModel obterDados() {
    CalculatorModel? calculatorModel = _box.get('calculatorModel');
    if (calculatorModel == null) {
      return CalculatorModel.vazio();
    }
    return calculatorModel;
  }


  // alterar(CalculatorModel calculatorModel) {
  //   calculatorModel.save();
  // }

  // excluir(CalculatorModel calculatorModel) {
  //   calculatorModel.delete();
  // }
}