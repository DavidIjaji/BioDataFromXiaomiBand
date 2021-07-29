import 'package:flutter_prueba/controllers/register_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterLoginPage extends StatelessWidget {
  final controller = Get.put(LoginRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginRegisterController>(
        builder: (_) {
          return Form(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller.passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text('Register'),
                      onPressed: () async {
                        _.register();
                      },
                    ),
                  ),
                  /*Container(
                      alignment: Alignment.center,
                      child: Text(controller.success
                          ? 'successfully register' + controller.userEmail
                          : 'Registro Fallido')),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
