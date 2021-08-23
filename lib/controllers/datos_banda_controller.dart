//import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_prueba/pages/blue_page.dart';

import 'package:flutter_prueba/controllers/firestore_controller.dart';

class DatosBanda /*extends Getx*/ {
  bool a = true;
  num bpm() {
    //var now = new DateTime.now();
    Random ranBPM = new Random();
    int min = 60;
    int max = 120;


    num r = min + ranBPM.nextInt(max - min);
    //print(r);
    return r;
  }

  Stream<num> get datoBanda async* {
    //este stream esta entregando un numero ramdom cada 2s
    while (a) {
      await Future.delayed(Duration(seconds: 2));

      //Si se quiere actualizar en tiempo real

      /*FSCRUD().AddHRrealTime(
          "davidijajo@gmail.com", "11082021", this.bpm().toInt());*/
      yield this.bpm();
    }
  }
}

class AlmacenarData {}
