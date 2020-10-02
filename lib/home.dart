import 'package:flutter/material.dart';
import 'dart:io' show Platform; //para identificar o dispositivo.
import 'PageTwo.dart';
import 'exer1001.dart';
import 'exer1009.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_plataforma),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => exer1001()));
              },
              child: Text("EX1001-SOMA"),
              color: Colors.blueAccent,
              textColor: Colors.white,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => exer1009()));
              },
              child: Text("EX1009-SALARIO"),
              color: Colors.blueAccent,
              textColor: Colors.white,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PageTwo()));
              },
              child: Text("Page two"),
              color: Colors.blueAccent,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushSaved() {}
}
