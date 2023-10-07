import 'package:calculadoraimcflutter/Classes/ImcCalculo.dart';
import 'package:calculadoraimcflutter/model/CalculatorModel.dart';
import 'package:calculadoraimcflutter/repositories/calculatorRepository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {

  //Create controllers
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  

  //Create vars
  late CalculatorRepository calculatorRepository;
  var calculatorModel = CalculatorModel.vazio();

  // double? peso;
  // String pesotext = "0";
  // double? altura;
  // String alturatext = "0";
  double imc = 0;
  var situacao = "";

  var calculoimc = IMCCalculo();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    calculatorRepository = await CalculatorRepository.carregar();
    calculatorModel = calculatorRepository.obterDados();
    alturaController.text = (calculatorModel.altura ?? 0).toString();
    // peso = calculatorModel.peso ?? 0;
    // altura = calculatorModel.altura ?? 0;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        body: ListView(
          children: [

            

            const SizedBox(height: 15,),

            //TextField for Peso Value
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 10),
              child: const Text("Preencha com seu peso em Kg, por favor:", style: TextStyle(fontSize: 18),),
            ),

            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  calculatorModel.peso = double.tryParse(pesoController.text);
                });
              },
            ),

            const SizedBox(height: 15,),
            
            //TextField for Altura value

            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 10),
              child: const Text("Preencha com sua altura em metros, por favor:", style: TextStyle(fontSize: 18),),
            ),

            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  calculatorModel.altura = double.tryParse(alturaController.text);
                });
              },
            ),

            const SizedBox(height: 20,),

            //Calculate IMC
            Row(
              children: [
                Expanded(flex:1, child: Container()),
              
                Expanded(
              flex:1,
              child: Container(
                child: ElevatedButton(
                  child: Text("Calcular"),
                   onPressed: () async {

                    // setState(() {
                    //   calculatorModel.peso = double.parse(pesotext);
                    //   calculatorModel.altura = double.parse(alturatext);
                    // });
                    //Check if fields are empty
                    if (pesoController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("O peso deve ser preenchido"),),
                        );
                    }
                    else if (calculatorModel.altura == 0){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Erro, altura igual ou menor a 0"),),);
                    }
                    else if (alturaController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("A altura deve ser preenchida"),),
                        );
                    }
                    else if ((alturaController.text.contains(",")) || (pesoController.text.contains(",")) ) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Por favor use apenas \".\" para inserir os dados"),),
                        );
                    }
                    else {
                      //Store values
                      
                    setState(() {
                      

                      //Calculate
                    imc = calculoimc.Calculo(calculatorModel.peso, calculatorModel.altura);
                    situacao = calculoimc.Situacao(imc);
                    });
                    
                    
                  
                    calculatorModel.altura = double.parse(alturaController.text);
                    calculatorModel.peso = double.parse(pesoController.text);
                    calculatorModel.imc = imc;
                    calculatorModel.situacao = situacao;

                  calculatorRepository.salvar(calculatorModel);
                    
                    

                    }

                   }, ),
              ),
            ),
              Expanded(flex:1, child: Container()),
              ],
            ),

            const SizedBox(height: 20,),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: const Text("Resultado", style: TextStyle(
                fontSize: 27,
                 fontWeight: FontWeight.w700),),
            ),
 
            //Shows results
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        
                        Text("IMC: ${imc.toStringAsFixed(2)}", style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                        ),

                        Text("Sua situação é: \n$situacao",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        ),
                        ),
                      ],
                      
                        ),
                               
                    ),
                ],
              ),
            ),
            

            ],

            

        ),


      ),

    );
    
  }
}