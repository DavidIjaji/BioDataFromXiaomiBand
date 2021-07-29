import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prueba/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_) {
        return SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: const Text(
                      'Login Page',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) =>
                        value!.isEmpty ? 'Email cannot be blank' : null,
                  ),
                  TextFormField(
                    controller: controller.passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: (value) =>
                        value!.isEmpty ? 'Contraseña cannot be blank' : null,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.Email,
                      text: "Sign In",
                      onPressed: () async {
                        _.signInWithEmailAndPassword();
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.GoogleDark,
                      text: "Google",
                      onPressed: () async {
                        _.signInWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
