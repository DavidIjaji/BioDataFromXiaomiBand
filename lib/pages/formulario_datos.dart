import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prueba/controllers/datos_personales_controller.dart';
import 'package:flutter_prueba/pages/start_page.dart';
import 'package:get/get.dart';

class FormularioDatosPersonales extends StatelessWidget {
  //const FormularioDatosPersonales({Key? key}) : super(key: key);
  final controller = Get.put(ControlDatosPersonales());

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[400],
          title: Text("Completa los datos"),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return TextButton(
                  onPressed: () async {
                    Get.to(StartPage());
                  },
                  child: Text('Omitir',
                      style: TextStyle(fontSize: 15, color: Colors.white)));
            })
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TextFormField(
              controller: controller.nombres,
              decoration: const InputDecoration(labelText: 'Nombres'),
              validator: (value) {
                if (value!.isEmpty) {
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
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.sexo,
              decoration: const InputDecoration(labelText: 'Sexo'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            /*
            DropdownButton<String>(
              items: <String>['M', 'F', 'Otro'].map((String value) {
                return DropdownMenuItem<String>(
                  value: controller.sexo,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                
              },
            ),*/
            TextFormField(
              controller: controller.edad,
              decoration: const InputDecoration(labelText: 'Edad'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.ID,
              decoration:
                  const InputDecoration(labelText: 'Numero de identificación'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text('Enviar Datos'),
                onPressed: () async {
                  return (ControlDatosPersonales()
                      .crearNuevoUsuario()
                      .then((value) => Get.to(StartPage())));
                },
              ),
            ),
          ],
        )));
  }
}
