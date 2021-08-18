import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControlDatosPersonales extends GetxController {
  //const ControlDatosPersonales({ Key? key }) : super(key: key);

  final names = TextEditingController();
  final apellidos = TextEditingController();
  final sexo = TextEditingController();
  final edad = TextEditingController();
  // ignore: non_constant_identifier_names
  final ID = TextEditingController();
  String sex = "";
  String tipoID = "";

  CollectionReference pacientes =
      FirebaseFirestore.instance.collection('pacientes');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> crearNuevoUsuario(
      //crea un documento con el id del usuario
      _nombres,
      _apellidos,
      _edad,
      _sexo,
      _tipoID,
      _id) async {
    return pacientes
        .doc(user!.email)
        .set({
          'nombres': _nombres,
          'apellidos': _apellidos,
          'sexo': _sexo,
          'edad': _edad,
          'tipoID': _tipoID,
          'ID': _id,
        })
        .then((value) => print("exito"))
        .catchError((error) => print("Error: $error"));
  }
}
