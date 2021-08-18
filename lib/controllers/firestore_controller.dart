import 'dart:collection';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FSCRUD {
  //esta clase sirve para subir y leer datos
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future LeerDatosPaciente(correo) async {
    print(FirebaseFirestore.instance.collection("pacientes").doc(correo).get());
    /*
    FirebaseFirestore.instance
        .collection("pacientes")
        .doc(correo)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> consulta =
          documentSnapshot.data() as Map<String, dynamic>;
      print(consulta);
      return (consulta);
    });
    */
  }

  Future LeerVariable(correo, fecha, variable) async {
    FirebaseFirestore.instance
        .collection("pacientes")
        .doc(correo)
        .collection(fecha)
        .doc(variable)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> consulta =
          documentSnapshot.data() as Map<String, dynamic>;
      print(consulta);
      return (consulta);
    });
  }

  Future AddVariable(correo, fecha, key, valor) async {
    //est sirve para agregar pasos,distancia y calorias

    //--POR HACER QUE SI NO EXISTE LA FECHA LA CREE Y TAMBIEN LA VARIABLE----
    CollectionReference usuarios =
        FirebaseFirestore.instance.collection("pacientes");
    Map<String, dynamic> Valor = new HashMap();
    Valor.putIfAbsent(key, () => valor);

    FirebaseFirestore.instance
        .collection("pacientes")
        .doc(correo)
        .collection(fecha)
        .doc(key)
        .set(Valor);
  }

  Future AddHR(correo, fecha, List<int> bpm, List<String> hora) async {
    Map<String, dynamic> HR = new HashMap();
    HR.putIfAbsent("bpm", () => bpm);
    HR.putIfAbsent("hora", () => hora);

    FirebaseFirestore.instance
        .collection("pacientes")
        .doc(correo)
        .collection(fecha)
        .doc("HR")
        .set(HR);
  }

  Future AddHRrealTime(correo, fecha, int bpm) async {
    DateTime now = DateTime.now();
    String hora = DateFormat('kk:mm:ss').format(now);
    FirebaseFirestore.instance
        .collection("pacientes")
        .doc(correo)
        .collection(fecha)
        .doc("HR")
        .update({
      "bpm": FieldValue.arrayUnion([bpm]),
      "hora": FieldValue.arrayUnion([hora])
      //si no extiste la coleccion se crea
    }).catchError((e) => AddHR(correo, fecha, [0], ["0"]));

    /*try {
      FirebaseFirestore.instance
          .collection("pacientes")
          .doc(correo)
          .collection(fecha)
          .doc("HR")
          .update({
        "bpm": FieldValue.arrayUnion([bpm]),
        "hora": FieldValue.arrayUnion([hora])
      });
    } catch (e) {
      print("ERORRRRR");
      AddHR(correo, fecha, [0], ["0"]);
    }*/

    //esto crea el vetor por si no existe
    //AddHR(correo, fecha, [0], ["0"])
    /*
    DocumentReference users = FirebaseFirestore.instance
        .collection('pacientes')
        .doc(correo)
        .collection(fecha)
        .doc("HR");
    FutureBuilder<DocumentSnapshot>(
        future: users.get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          print("ACAAAAAY");
          print(snapshot);
          print(snapshot.hasData);
          if (snapshot.hasData || !snapshot.data!.exists) {
            AddHR(correo, fecha, [0], ["0"]);
            return Text("Document does not exist");
          }
          return Text("Todo ok");
        });
        */
/*
    FirebaseFirestore.instance
        .collection("pacientes")
        .doc(correo)
        .collection(fecha)
        .doc("HR")
        .update({
      "bpm": FieldValue.arrayUnion([bpm]),
      "hora": FieldValue.arrayUnion([hora])
    });*/
  }
}
