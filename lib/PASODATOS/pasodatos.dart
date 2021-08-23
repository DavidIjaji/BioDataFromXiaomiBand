//import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_prueba/pages/blue_page.dart';

import 'package:flutter_prueba/controllers/firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';

import 'package:pointycastle/api.dart' as API;
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/ecb.dart';
import 'package:encrypt/encrypt.dart' as AES;
import 'package:flutter_blue/flutter_blue.dart';

import 'package:flutter_prueba/BLOCS/bloc_data.dart';
import 'package:flutter_prueba/BLOCS/bloc_extra_data.dart';

import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:typed_data';


class DatosBanda1 /*extends Getx*/ {
  bool a = true;
  int bpm(valor) {
    //print(r);
    return valor;
  }

  Stream<int> flujoPeticiones(
    
    List<BluetoothCharacteristic> HRcharacteristics,
    List<BluetoothCharacteristic> MOREDATAcharacteristics,
    List<BluetoothCharacteristic> AUTHcharacteristics,
    BluetoothDevice device) 
    async*{

      //print(device.name);
      final String llave;
      if(device.name=="Amazfit Band 5"){
        llave="2ac092e2f4666eb3e0465171043f3e1b";
      }else if(device.name=="Mi Smart Band 4"){
        llave="2db9134728769f4ae34d8e672688f3f5";
      }else{
        llave="";
      }
      //print(HEX.decode("2ac092e2f4666eb3e0465171043f3e1b"));
      
      
      await AUTHcharacteristics[0].write([1,0, ...HEX.decode(llave)], withoutResponse: true);
      await AUTHcharacteristics[0].setNotifyValue(!AUTHcharacteristics[0].isNotifying);
      await AUTHcharacteristics[0].write([2,0], withoutResponse: true);
      AUTHcharacteristics[0].value.listen((value)async *{
        print(HEX.encode(value));
        if (value.length>16) {
          //final KEYAUTH = HEX.encode(value).substring(6,);
          final Uint8List KEYAUTH  = Uint8List.fromList(
            [...HEX.decode(llave)],
          );

          Uint8List randomNumber = Uint8List.fromList(
            [...HEX.decode(HEX.encode(value).substring(6,))],
          );
          //print("RANDOM NUMBER");
          //print(randomNumber);

          API.BlockCipher cipher = ECBBlockCipher(AESFastEngine());

          cipher.init(
            true,
            API.KeyParameter(KEYAUTH),
          );
          Uint8List ENCRIPTACION = cipher.process(randomNumber);
          //print("ENCRIPTACION");
          //print(HEX.encode(ENCRIPTACION));
          await AUTHcharacteristics[0].write([3,0,...ENCRIPTACION], withoutResponse: true);

            //await HRcharacteristics[1].write([0x15,0x02,0x01], withoutResponse: true);
            //await HRcharacteristics[0].read();
            await HRcharacteristics[0].setNotifyValue(!HRcharacteristics[0].isNotifying);
            await MOREDATAcharacteristics[0].setNotifyValue(!MOREDATAcharacteristics[0].isNotifying);
            

            
            HRcharacteristics[0].value.listen((value)async*{
            print(value[1]);
             //_bloc.dataEventSink.add(value[1]);
              yield this.bpm(value[1]);
            
             
            });
            
            //await MOREDATAcharacteristics[0].read();
            MOREDATAcharacteristics[0].value.listen((value){
              //_blocExtra.dataEventSink.add(value);
              print(value);
            });
             
           
        }
          });
      
      

  }


  // Stream<num> get datoBanda async* {
  //   //este stream esta entregando un numero ramdom cada 2s
  //   while (a) {
  //     await Future.delayed(Duration(seconds: 2));

  //     //Si se quiere actualizar en tiempo real

  //     /*FSCRUD().AddHRrealTime(
  //         "davidijajo@gmail.com", "11082021", this.bpm().toInt());*/
  //     yield this.bpm();
  //   }
  //}
}

class AlmacenarData {}
