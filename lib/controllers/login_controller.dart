import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prueba/pages/formulario_datos.dart';
import 'package:flutter_prueba/pages/home_page.dart';
import 'package:flutter_prueba/pages/start_page.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference pacientes =
      FirebaseFirestore.instance.collection('pacientes');

  void signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      Get.snackbar('Hola', 'su ingreso ha sido exitoso');
      var esNuevo = userCredential.additionalUserInfo!.isNewUser;
      final user = userCredential.user;
      Future.delayed(
        Duration(seconds: 2),
        () {
          print("LOGIN DE USER Y PASSWORD");
          print("es nuevo? $esNuevo");
          if (esNuevo) {
            //si es nuevo va llenar el formualario si no pues se va a la la grafica
            Get.to(FormularioDatosPersonales());
            //si es nuevo hace un documento con el id en pacientes
            pacientes.doc("${user!.email}");
          } else {
            //si no es nuevo pasa de una a la pantalla
            Get.to(StartPage());
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("Error", "Email no encontrado",
            snackPosition: SnackPosition.TOP);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar("Error", "Contraseña invalida",
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }

  void signOut() async {
    // ignore: await_only_futures
    final User? user = await _auth.currentUser;
    if (user == null) {
      Get.snackbar('out', 'No one has signed in.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _signOut();
    final String uid = user.uid;
    Get.snackbar('Out', uid + 'has successfully signed out.',
        snackPosition: SnackPosition.BOTTOM);
    Get.to(HomePage());
  }

  //Example code of how to sign in with Google.
  void signInWithGoogle() async {
    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      var esNuevo = userCredential.additionalUserInfo!.isNewUser;
      print("ES NUEVO? $esNuevo");
      final user = userCredential.user;
      Get.snackbar('Hola', 'Sing In ${user!.email} with Google');
      print('Ingreso bien');
      Future.delayed(Duration(seconds: 2), () {
        if (esNuevo) {
          //si es nuevo se va a completar los datos de registro
          Get.to(FormularioDatosPersonales());
        } else {
          //si no es nuevo pasa de una a la pantalla
          Get.to(StartPage());
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar('Fallo', 'Failed to sign in with Google: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
