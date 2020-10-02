import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: exer1009(),
    ));

class exer1009 extends StatefulWidget {
  @override
  _exer1009State createState() => _exer1009State();
}

class _exer1009State extends State<exer1009> {
  TextEditingController salController = TextEditingController();
  TextEditingController vendasController = TextEditingController();
  TextEditingController resulController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const channel1009 = const MethodChannel('codigo.nativo/Android');

  void _somar() {
    int salario = int.parse(salController.text);
    int vendas = int.parse(vendasController.text);
    _getSalario(salario, vendas);
  }

  Future<int> _getSalario(salario, vendas) async {

    try {
      print("chamando 1009");

      Map<String, dynamic> resultJson = jsonDecode(await channel1009.invokeMethod('getSalario',
          {"valor_Salario" : salario, "valor_Vendas": vendas, }));


      int resul = resultJson["resul"];

      print(">> Retorno 1009:  $resul");
      setState(() {
        //int intX = soma;
        resulController.text = ("$resul");
      });
    } on PlatformException catch (e) {
      print(e.message);
  }}

  @override
  Widget build(BuildContext context) {
    TextStyle styleDecoration = TextStyle(color: Colors.blue, fontSize: 20);
    TextStyle styleField = TextStyle(color: Colors.lightBlueAccent);

    RaisedButton raisedButton = RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _somar();
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Text("1009 Salario"),
      color: Colors.blueAccent,
      textColor: Colors.white,
    );

    AppBar appBar = AppBar(
      title: Text("Ex1009 Salario"),
      centerTitle: true,
      //backgroundColor: Colors.black,
      actions: <Widget>[],
    );

    TextFormField tFSalario = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Salario Fixo:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        border: OutlineInputBorder(),
        //suffixText: "ºC",
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: salController,
      validator: (value) {
        if (value.isEmpty) {
          return "Informe um valor";
        }
      },
    );
    TextFormField tFVendas = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Total Vendas:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        border: OutlineInputBorder(),
        //suffixText: "ºC",
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: vendasController,
      validator: (value) {
        if (value.isEmpty) {
          return "Informe um valor";
        }
      },
    );

    TextFormField tFResul = TextFormField(
      enabled: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Resultado',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        border: OutlineInputBorder(),
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: resulController,
    );

    Container containerBtn = Container(
      padding: EdgeInsets.fromLTRB(8, 24, 8, 24),
      height: 100.0,
      child: raisedButton,
    );

    Padding pad = Padding(
      padding: EdgeInsets.all(8.0),
      child: tFResul,
    );

    Row row = Row(
      children: <Widget>[
        Expanded(child: Padding(padding: EdgeInsets.all(4.0), child: tFSalario)),
        Expanded(child: Padding(padding: EdgeInsets.all(4.0), child: tFVendas)),
      ],
    );

    //ListView column = ListView(
    //  padding: EdgeInsets.all(10),
    //  shrinkWrap: true,
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //icon,
        Divider(),
        Divider(),
        row,
        containerBtn,
        //tFResul,
        pad,
        Divider(),
        Divider(),
      ],
    );

    Form form = Form(
      child: column,
      key: _formKey,
    );

    SingleChildScrollView singleChildScrollView = SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[form, Text("Desenvolvido por M6 Automação")]));
    //Container containerColuna =
    //  Container(padding: EdgeInsets.all(8), child: column);

    Scaffold scaffold = Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: singleChildScrollView,
    );
    return scaffold;
  }
}
