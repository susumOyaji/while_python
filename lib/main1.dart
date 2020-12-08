import 'package:flutter/material.dart';
import 'CounterBloc.dart';
import 'service.dart';
import 'dart:convert' as convert;


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Service _service = new Service();












  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        ),
        body: new Center(
          child:   new StreamBuilder(stream: _service.counterObservable, builder: (context, AsyncSnapshot<String> snapshot){


            Map<String, dynamic> user = convert.jsonDecode(snapshot.data);
            var rest1 = user["Data"];
//            var rest = user["Data"][0];
//            print('Data In Zero Index, ${rest['firstName']}!');
             print(snapshot.data);
            return  new ListView.builder
              (
                itemCount: rest1.length as int,
                itemBuilder: (BuildContext ctxt, int index) {
{
                  return new Text(rest[index]['firstName']);

                }

            );
          }),
        ),
        floatingActionButton: new Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          new Padding(padding: EdgeInsets.only(bottom: 10), child:
          new FloatingActionButton(
            onPressed: _service.increment,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          )
          ),
          new FloatingActionButton(
            onPressed: _service.decrement,
            tooltip: 'Decrement',
            child: new Icon(Icons.remove),
          ),
        ])
    );
  }

  @override
  void initState() {
   _service.httpRequest();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

}