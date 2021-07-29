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
      appBar: AppBar(
          title: Text(
        'BioSolutions Medical Reports',
        style: TextStyle(fontSize: 12),
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          //Image(image: AssetImage("lib\assets\img\LogoBioSolutions4x.png")),
          Container(
            child: Center(
              child: Image(
                  image: AssetImage("assets/LogoBioSolutions.png"), width: 220),
            ),
          ),
          /*Container(
            height: 216,
            width: 349,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              image: DecorationImage(
                image: AssetImage("\lib\assets\img\LogoBioSolutions.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ), 
            child: Text("Do it",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontFamily: 'LangerReguler')),
            alignment: Alignment.center,
            
          ),
          */
          /*
          SizedBox(
            height: 100,
          ),
          */
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
    );
  }
}
