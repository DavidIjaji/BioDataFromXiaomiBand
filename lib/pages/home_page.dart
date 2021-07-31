import 'package:flutter/material.dart';
import 'package:flutter_prueba/pages/login_page.dart';
import 'package:flutter_prueba/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/button_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Center(
                  child:
                      Image(image: AssetImage("assets/icono.png"), width: 220),
                ),
              ),
            ),
            Container(
              child: SignInButtonBuilder(
                  icon: Icons.person_add,
                  backgroundColor: Colors.blueAccent,
                  text: "Sign in",
                  onPressed: () => Get.to(LoginPage())),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            Container(
              child: SignInButtonBuilder(
                  icon: Icons.person_add,
                  backgroundColor: Colors.yellow,
                  text: "Sign up",
                  onPressed: () => Get.to(RegisterLoginPage())),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
