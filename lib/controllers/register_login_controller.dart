import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prueba/pages/formulario_datos.dart';
import 'package:flutter_prueba/pages/start_page.dart';
import 'package:get/get.dart';

class LoginRegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool success = false;
  String userEmail = '';
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() async {
    final user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
      success = true;
      print('Registro Ok');
      Future.delayed(
        Duration(seconds: 2),
        () {
          Get.to(FormularioDatosPersonales());
        },
      );
      userEmail = user.email!;
    } else {
      success = false;
    }
  }
}
