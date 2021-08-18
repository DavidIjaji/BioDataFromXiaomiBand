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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView(
              children: [
                Center(
                    child: Text(
                  "Agrega tus datos",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  /*
                  decoration: BoxDecoration(
                    border: Border(),
                    color: Color(0xFF527DAA),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),*/
                  height: 50.0,
                  child: TextFormField(
                    controller: controller.names,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: 'Nombres',
                      labelStyle:
                          new TextStyle(color: Colors.white, fontSize: 16.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value == null) {
                        empty = 1;
                        print("Nombres esta vacio");
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: controller.apellidos,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Apellidos',
                    labelStyle:
                        new TextStyle(color: Colors.white, fontSize: 16.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      empty = 2;
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
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
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: controller.edad,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Edad',
                    labelStyle:
                        new TextStyle(color: Colors.white, fontSize: 16.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      Get.snackbar(
                          "Llene todos los datos", "Falta el dato edad");
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
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
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: controller.ID,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Numero de identificación',
                    labelStyle:
                        new TextStyle(color: Colors.white, fontSize: 16.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
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
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                return (ControlDatosPersonales()
                    .crearNuevoUsuario(
                        controller.names.text,
                        controller.apellidos.text,
                        controller.edad.text,
                        controller.sex,
                        controller.tipoID,
                        controller.ID.text)
                    .then((value) => Get.to(StartPage())));
              },
              child: Text(
                'CONTINUAR',
                style: TextStyle(
                  color: Colors.white /*Color(0xFF527DAA)*/,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            )) /*ElevatedButton(
        child: Text('Enviar Datos'),
        onPressed: () async {
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
      ),*/
        );
  }
}
