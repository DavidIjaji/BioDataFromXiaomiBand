import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prueba/controllers/datos_personales_controller.dart';
import 'package:flutter_prueba/pages/start_page.dart';
import 'package:get/get.dart';

class FormularioDatosPersonales extends StatefulWidget {
  //const FormularioDatosPersonales({Key? key}) : super(key: key);
  @override
  _FormularioDatosPersonalesState createState() =>
      _FormularioDatosPersonalesState();
}

class _FormularioDatosPersonalesState extends State<FormularioDatosPersonales> {
  final controller = Get.put(ControlDatosPersonales());
  String sexValue = "falta";
  String tipoID = "falta";
  int empty = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.blue],
              begin: Alignment.centerLeft,
              end: Alignment.bottomCenter),
        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("Agrega tus datos")),
                TextFormField(
                  controller: controller.names,
                  decoration: const InputDecoration(labelText: 'Nombres'),
                  validator: (value) {
                    if (value == null) {
                      empty = 1;
                      print("Nombres esta vacio");
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.apellidos,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      empty = 2;
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButton<String>(
                      //value: sexValue,
                      hint: Text("Sexo"),
                      onChanged: (String? _sexo) {
                        setState(() {
                          sexValue = _sexo!;
                          controller.sex = _sexo;
                          if (sexValue == "falta") {
                            empty = 3;
                          }
                        });
                      },
                      items: [
                        DropdownMenuItem(child: Text("M"), value: "M"),
                        DropdownMenuItem(child: Text("F"), value: "F"),
                        DropdownMenuItem(child: Text("Otro"), value: "Otro"),
                      ]),
                ),
                TextFormField(
                  controller: controller.edad,
                  decoration: const InputDecoration(labelText: 'Edad'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      Get.snackbar(
                          "Llene todos los datos", "Falta el dato edad");
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButton<String>(
                      hint: Text("Tipo de documento"),
                      onChanged: (String? valor) {
                        setState(() {
                          controller.tipoID = valor!;
                        });
                      },
                      items: [
                        DropdownMenuItem(child: Text("CC"), value: "CC"),
                        DropdownMenuItem(child: Text("TI"), value: "TI"),
                        DropdownMenuItem(child: Text("TE"), value: "TE"),
                        DropdownMenuItem(child: Text("CE"), value: "CE"),
                      ]),
                ),
                TextFormField(
                  controller: controller.ID,
                  decoration: const InputDecoration(
                      labelText: 'Numero de identificación'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                enviarDatos(controller: controller),
              ],
            ),
          ),
        ),
      ),
      //)
    );
  }
}

class enviarDatos extends StatelessWidget {
  const enviarDatos({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ControlDatosPersonales controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      alignment: Alignment.center,
      child: ElevatedButton(
        child: Text('Enviar Datos'),
        onPressed: () async {
          /*
          print(controller.apellidos.text);
          if (controller.names.text == null) {
            Get.snackbar(
                "Datos incompletos", "Por favor llene el campo nombres");
          } else if (controller.apellidos.text == null) {
            Get.snackbar(
                "Datos incompletos", "Por favor llene el campo apellidos");
          } else if (controller.edad.text == null) {
            Get.snackbar("Datos incompletos", "Por favor llene el campo edad");
          } else if (controller.sex == "Falta") {
            Get.snackbar("Datos incompletos", "Por favor llene el campo sexo");
          } else if (controller.tipoID == "Falta") {
            Get.snackbar(
                "Datos incompletos", "Por favor llene el campo tipo ID");
          } else if (controller.ID.text == null) {
            Get.snackbar("Datos incompletos", "Por favor llene el campo ID");
          } else {
            Get.snackbar("Gracias", "Datos guardados");
            */
          return (ControlDatosPersonales()
              .crearNuevoUsuario(
                  controller.names.text,
                  controller.apellidos.text,
                  controller.edad.text,
                  controller.sex,
                  controller.tipoID,
                  controller.ID.text)
              .then((value) => Get.to(StartPage())));
          //}
        },
      ),
    );
  }
}
