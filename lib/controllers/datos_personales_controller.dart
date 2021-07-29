import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_prueba/pages/start_page.dart';
import 'package:get/get.dart';

class ControlDatosPersonales extends GetxController {
  //const ControlDatosPersonales({ Key? key }) : super(key: key);

  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final sexo = TextEditingController();
  final edad = TextEditingController();
  // ignore: non_constant_identifier_names
  final ID = TextEditingController();

  CollectionReference pacientes =
      FirebaseFirestore.instance.collection('pacientes');

  Future<void> crearNuevoUsuario() async {
    print(nombres.text);
    print(nombres);
    return pacientes
        .add({
          'nombres': nombres.text,
          'apellidos': apellidos.text,
          'sexo': sexo,
          'edad': edad.text,
          'ID': ID.text
        })
        .then((value) => print("Usuario añadido"))
        .catchError((error) => print("Error: $error"));
  }
}
