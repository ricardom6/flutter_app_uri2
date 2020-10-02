import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: exer1001(),
    ));

class exer1001 extends StatefulWidget {
  @override
  _exer1001State createState() => _exer1001State();
}

class _exer1001State extends State<exer1001> {
  TextEditingController intAController = TextEditingController();
  TextEditingController intBController = TextEditingController();
  TextEditingController intXController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const platformAndroid2 = const MethodChannel('codigo.nativo/Android');

  void _somar() {
    int intA = int.parse(intAController.text);
    int intB = int.parse(intBController.text);
    _getSoma(intA, intB); //Passando argumentos
    //_getSoma();
  }

  Future<int> _getSoma(intA, intB) async {
    // Passando argumentos
    //Future<int> _getSoma() async {

    int soma;
    try {
      print("Future Soma");
      //String resultString = await platformAndroid2.invokeMethod('getSoma',
      //    {"valor_A" : intA, "valor_B": intB, });

      Map<String, dynamic> resultJson = jsonDecode(await platformAndroid2.invokeMethod('getSoma',
          {"valor_A" : intA, "valor_B": intB, }));


      var soma = resultJson["soma"];
      var subtracao = resultJson["subtracao"];

      print(">> Resultado da soma:  $soma");
      print(">> Resultado da subtracao:  $subtracao");




      soma = await platformAndroid2.invokeMethod('getSoma');
    } on PlatformException catch (e) {
      soma = 999;
      print("Failed Soma: '${e.message}'.");
    }
    setState(() {
      int intX = soma;
      intXController.text = (intX.toString());
    });
  }

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
      child: Text("1001 Somar"),
      color: Colors.blueAccent,
      textColor: Colors.white,
    );

    AppBar appBar = AppBar(
      title: Text("Ex1001 Soma"),
      centerTitle: true,
      //backgroundColor: Colors.black,
      actions: <Widget>[],
    );

    TextFormField tFIntA = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'valor 1:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        border: OutlineInputBorder(),
        //suffixText: "ºC",
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: intAController,
      validator: (value) {
        if (value.isEmpty) {
          return "Informe um valor";
        }
      },
    );
    TextFormField tFIntB = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Valor 2:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        border: OutlineInputBorder(),
        //suffixText: "ºC",
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: intBController,
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
      controller: intXController,
    );

    Container containerBtn = Container(
      padding: EdgeInsets.fromLTRB(8, 24, 8, 24),
      height: 100.0,
      child: raisedButton,
    );

    Padding pad = Padding(
      padding: EdgeInsets.all(8.0),
      child: tFIntA,
    );

    Row row = Row(
      children: <Widget>[
        Expanded(child: Padding(padding: EdgeInsets.all(4.0), child: tFIntA)),
        Expanded(child: Padding(padding: EdgeInsets.all(4.0), child: tFIntB)),
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
        tFResul,
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
