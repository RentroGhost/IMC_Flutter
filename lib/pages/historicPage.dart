import 'dart:typed_data';

import 'package:calculadoraimcflutter/Classes/ImcCalculo.dart';
import 'package:calculadoraimcflutter/Classes/historic.dart';
import 'package:calculadoraimcflutter/model/CalculatorModel.dart';
import 'package:calculadoraimcflutter/model/HistoricModel.dart';
import 'package:calculadoraimcflutter/pages/calculatorPage.dart';
import 'package:calculadoraimcflutter/repositories/calculatorRepository.dart';
import 'package:calculadoraimcflutter/repositories/historicRepository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}



class _HistoricPageState extends State<HistoricPage> {

//Controllers
var nomeController = TextEditingController();
var imcHistoricController = TextEditingController();
var pesoHistoricController = TextEditingController();
late CalculatorRepository calculatorRepository;
var calculatorModel = CalculatorModel.vazio();
late HistoricRepository historicRepository;
var historicModel = HistoricModel.vazio();

//Variables
var _historics = const <HistoricModel>[];
String imctext = "";
var nome = "";
var imc;
String? situacao;
DateTime lasttime = DateTime.now();
var peso;
var altura;

var calculoimc = IMCCalculo();


//late Box boxHistoric;


  @override

void initState() {
    // TODO: implement initState
    _historics = [];
    super.initState();
    carregarDados();
  }

void carregarDados() async {
  historicRepository = await HistoricRepository.carregar();
  calculatorRepository = await CalculatorRepository.carregar();
  calculatorModel = calculatorRepository.obterDados() ?? CalculatorModel.vazio();
  peso = calculatorModel.peso ?? 0;
  altura = calculatorModel.altura ?? 0;
  nome = historicModel.nome ?? "";

  _historics = await historicRepository.listHistoric();

  setState(() {});
}

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {  
          showDialog(context: context, builder: (BuildContext bc) {
            return ListView(
              children:[ AlertDialog(
                title: Text("Adicione seu último resultado para acompanhar! (dados baseados em seu último resultado)"),
                content: Column(
                  children: [
            
                    //TextField for Nome value
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text("Preencha com seu nome, por favor:", style: TextStyle(fontSize: 18),),
                    ),
              
                     TextField(
                       controller: nomeController,
                     ),
                    
                    
                    // //Textfield for imc input
                    // SizedBox(height: 30,),
                    // Container(child: Text("Qual seu IMC?", style: TextStyle(fontSize: 18),),),
                    // TextField(
                    //   keyboardType: TextInputType.number,
                    //   controller: imcHistoricController,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       imctext = value;
                    //     });
                    //   },),
            
                    //Save data
                    Row(
                      children: [
                        Expanded(flex:1, child: Container()),
                
                        Expanded(
                          flex:1,
                          child: Container(
                          child: TextButton(
                            child: Text("Salvar"),
                            onPressed: () async {
            
                              //Check if fields are empty
                              if (nomeController.text.trim().length <=0){
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("O nome deve ser preenchido!"),),
                                );
                             }
                            //   else if (imcHistoricController.text.isEmpty) {
                            //    ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(content: Text("O IMC deve ser preenchido"),),
                            //   );
                            //  }
                            //  else if (imcHistoricController.text.contains(",")) {
                            //    ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text("Por favor use apenas \".\" para inserir os dados"),),
                            //    );
                            //   }
                             else {
                              //Store values
                                setState(() {
                                  nome = nomeController.text;
                                  imc = calculatorModel.imc!;
                                  lasttime = DateTime.now();
                                  peso = calculatorModel.peso;
                                  altura = calculatorModel.altura;
                                  situacao = calculatorModel.situacao;
                                  
                               //Calculate
                                  // situacao = calculoimc.Situacao(imc);
                                });
                               await historicRepository.salvar(HistoricModel.criar(nome, altura, peso, imc, situacao!));
                              Navigator.pop(context);                       
                               _historics = await historicRepository.listHistoric();
                              setState(() {
                                
                              });
                               
                                // boxHistoric.put('peso', imc);
                                // boxHistoric.put('nome', nome);
                              }
                              
                              
            
                       }, ),
                ),
                
              ),
                Expanded(flex:1, child: Container(
                  child: TextButton( child: Text("Cancelar"), onPressed: () {
                    Navigator.pop(context);
                  },),
                )),
                ],
              ),


                  ],
                  
                ),
              ),
              ]
            );
          });
        },
      ),
        
        body: Container(
          child: Column(
            
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _historics.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var historic = _historics[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        setState(() {
                          _historics.removeAt(index);
                        });
                         await historicRepository.excluir(historic);
                         _historics = await historicRepository.listHistoric();
                      },
                      key: Key(historic.id), 
                      child: ListTile (
                        title: 
                        Row(
                          children: [
                            Text("${historic.nome}"),
                            Text(" IMC: ${historic.imc.toStringAsFixed(2)}"),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text("Data: ${DateFormat('dd/MM/yyyy').format(lasttime)}"),
                            Text(" Status: ${historic.situacao}"),
                          ],
                        
                        ),
                                                
                      ));
                }),
              )
            ],
          ),
        )
      
    );
  }
}