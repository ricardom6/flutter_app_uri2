import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:io' show Platform; //para identificar o dispositivo.

void main() => runApp(MaterialApp(
  home: Home(),
  //home: Secundaria(),
));

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _plataforma = '';
  @override
  void initState() {
    if (Platform.isAndroid) {
      _plataforma = 'Plataforma Android';
    } else if (Platform.isIOS) {
      _plataforma = 'Plataforma IOS';
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: _home(),
    );
  }
  //aqui
}
