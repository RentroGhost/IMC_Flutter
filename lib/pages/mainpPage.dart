import 'package:calculadoraimcflutter/pages/calculatorPage.dart';
import 'package:calculadoraimcflutter/pages/historicPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
//Create controller for the pages
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //Appbar serving as app title
        appBar: AppBar(
          title: const Text("Calculadora IMC"),
          ),
      body: Column(
        children: [
          Expanded(
            //Page view for seeing the other pages
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  posicaoPagina = value;
                });
              },
              children: const [
                CalculatorPage(),
                HistoricPage(),
              ],
            ),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items: const [
                BottomNavigationBarItem(label: "Calculadora", icon: Icon(Icons.calculate)),
                BottomNavigationBarItem(label: "Histórico", icon: Icon(Icons.list)),
                
              ])
        ],
      ),
      )
      );

  }


}