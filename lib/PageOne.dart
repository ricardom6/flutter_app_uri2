import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

class PageOne extends StatefulWidget {
  String msg;
  PageOne({this.msg});
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  int _counter = 0;
  String _plataforma = '';

  static const platformAndroid = const MethodChannel('codigo.nativo/Android');
  static const platformIOS = const MethodChannel('codigo.nativo/IOS');

  Future<void> _getIncremento() async {
    int incremento;
    try {
      if (Platform.isAndroid) {
        incremento = await platformAndroid.invokeMethod('getIncremento');
      } else if (Platform.isIOS) {
        incremento = await platformIOS.invokeMethod('getIncremento');
      }
    } on PlatformException catch (e) {
      incremento = 0;
      print("Failed to get incremento: '${e.message}'.");
    }

    setState(() {
      _counter += incremento;
    });
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      _plataforma = 'Plataforma Android';
    } else if (Platform.isIOS) {
      _plataforma = 'Plataforma iOS';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _home(),
    );
  }

  void _incrementCounter() {
    _getIncremento();
  }

  Widget _home() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_plataforma),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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
}
