import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Service{

  IO.Socket socket =IO.io('http://192.168.0.5:8080' ,<String, dynamic>{
    'transports': ['websocket']
  }) ;
  String initialCount = ''; //if the data is not passed by paramether it initializes with ''
  BehaviorSubject<String> _subjectCounter;

  Service({this.initialCount}){
   //Show emited data on notify event through websocket! 
   socket.on('notify', (data) {
      print(data);
      httpRequest();

    });
    
 _subjectCounter = new BehaviorSubject<String>.seeded(this.initialCount); //initializes the subject with element already
 
 }

  Stream<String> get counterObservable => _subjectCounter.stream;

  void increment(){
    httpPostRequest();
    httpRequest();
  }



//Get User Data
  void httpRequest() async{
    var url = 'http://192.168.0.5:8080/show/user';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse;
      _subjectCounter.sink.add(response.body);
      print('Number of books about http: $jsonResponse.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

  }


//Post User Data
  void httpPostRequest() async{
    var url = 'http://192.168.0.5:8080/create/user';

    Map data = {
      "firstName": "CodeSearch",
      "lastName": "Online"
    };
    var body = convert.json.encode(data);
    Map userHeader = {"Content-type": "application/json", "Accept": "application/json"};
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,body:body,headers:{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse;


      print('Number of books about http: $jsonResponse.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

  }



  void dispose(){
    _subjectCounter.close();
  }

}
