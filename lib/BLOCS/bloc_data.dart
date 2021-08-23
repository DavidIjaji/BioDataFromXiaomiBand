import 'dart:async';
import 'package:flutter_prueba/repositorios/data_repository.dart';
class DataHRBloc{

  final _dataStateController = StreamController<int>.broadcast();
  StreamSink<int> get _inData => _dataStateController.sink;
  Stream<int> get data => _dataStateController.stream.asBroadcastStream();

  
  
  final _dataEventController = StreamController<int>();

  Sink<int> get dataEventSink => _dataEventController.sink;

   DataHRBloc(){
     _dataEventController.stream.listen(_pasarData);
     //print(data);
   }
  void _pasarData(int value){
    _inData.add(value);
  }

}