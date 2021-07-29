//import 'package:get/get.dart';
import 'dart:math';

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
      yield this.bpm();
    }
  }
}
