import 'dart:async';
//import 'package:flutter_prueba/repositorios/data_repository.dart';
class DataEXTRABloc{

  final _dataStateController = StreamController<List<int>>.broadcast();
  StreamSink<List<int>> get _inData => _dataStateController.sink;
  Stream<List<int>> get data => _dataStateController.stream.asBroadcastStream();

  
  
  final _dataEventController = StreamController<List<int>>();

  Sink<List<int>> get dataEventSink => _dataEventController.sink;

   DataEXTRABloc(){
     _dataEventController.stream.listen(_pasarData);
     //print(data);
   }
  void _pasarData( value){
    _inData.add(value);
  }

}