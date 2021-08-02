import 'package:flutter/material.dart';
import 'package:flutter_prueba/pages/login_page.dart';
import 'package:flutter_prueba/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 2.0],
                colors: [
                  Colors.white,
                  Colors.blue,
                ],
              )),
            child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: AnimatedTextKit(
                  
                  animatedTexts: [
                    
                  WavyAnimatedText('Bienvenido a Biosolutions!', 
                  textStyle: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 25.0,
                    fontFamily: 'OpenSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    speed: Duration(milliseconds: 100)
                  ),
                  WavyAnimatedText('Nos encanta cuidarte',
                  textStyle: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 25.0,
                    fontFamily: 'OpenSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    speed: Duration(milliseconds: 100)),
                  WavyAnimatedText('Porque nos importas.',
                  textStyle: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 25.0,
                    fontFamily: 'OpenSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    speed: Duration(milliseconds: 100)),
                    
                  ],
      
                  repeatForever: true,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              //Image(image: AssetImage("lib\assets\img\LogoBioSolutions4x.png")),
              Container(
                child: Center(
                  child: Image(
                      image: AssetImage("assets/LogoBioSolutions2.jpeg"), width: 220),
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
                    icon: Icons.login,
                    backgroundColor: Colors.blueAccent,
                    text: "Ingresar",
                    onPressed: () => Get.to(LoginPage())),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
              Container(
                child: SignInButtonBuilder(
                    icon: Icons.person_add,
                    backgroundColor: Colors.yellow,
                    text: "Registrarse!",
                    onPressed: () => Get.to(RegisterPage())),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
