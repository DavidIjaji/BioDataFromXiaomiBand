import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prueba/controllers/login_controller.dart';
import 'package:get/get.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';

// class LoginPage extends StatelessWidget {
//   final controller = Get.put(LoginController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GetBuilder<LoginController>(
//       init: LoginController(),
//       builder: (_) {
//         return SingleChildScrollView(
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 100,
//                   ),
//                   Container(
//                     child: const Text(
//                       'Login Page',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     alignment: Alignment.center,
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   TextFormField(
//                     controller: controller.emailController,
//                     decoration: const InputDecoration(labelText: 'Email'),
//                     validator: (value) =>
//                         value!.isEmpty ? 'Email cannot be blank' : null,
//                   ),
//                   TextFormField(
//                     controller: controller.passwordController,
//                     decoration: const InputDecoration(labelText: 'Contraseña'),
//                     validator: (value) =>
//                         value!.isEmpty ? 'Contraseña cannot be blank' : null,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(top: 16.0),
//                     alignment: Alignment.center,
//                     child: SignInButton(
//                       Buttons.Email,
//                       text: "Sign In",
//                       onPressed: () async {
//                         _.signInWithEmailAndPassword();
//                       },
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(top: 16.0),
//                     alignment: Alignment.center,
//                     child: SignInButton(
//                       Buttons.GoogleDark,
//                       text: "Google",
//                       onPressed: () async {
//                         _.signInWithGoogle();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     ));
//   }
// }
//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prueba/utilidades/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Ingresa tu email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Contraseña',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Ingresa tu contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildForgotPasswordBtn() {
  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: FlatButton(
  //       onPressed: () => print('Forgot Password Button Pressed'),
  //       padding: EdgeInsets.only(right: 0.0),
  //       child: Text(
  //         'Forgot Password?',
  //         style: kLabelStyle,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildRememberMeCheckbox() {
  //   return Container(
  //     height: 20.0,
  //     child: Row(
  //       children: <Widget>[
  //         Theme(
  //           data: ThemeData(unselectedWidgetColor: Colors.white),
  //           child: Checkbox(
  //             value: _rememberMe,
  //             checkColor: Colors.green,
  //             activeColor: Colors.white,
  //             onChanged: (value) {
  //               setState(() {
  //                 _rememberMe = value;
  //               });
  //             },
  //           ),
  //         ),
  //         Text(
  //           'Remember me',
  //           style: kLabelStyle,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- O -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Ingresa con',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn( onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'No tienes cuenta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
            
              text: ' Regístrate!',
              
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
       init: LoginController(),
       builder: (_) {
         return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
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
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Ingresa',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async {
                              _.signInWithEmailAndPassword();
                                        },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'INGRESA',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      _buildSignInWithText(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildSocialBtn(
                               () async {
                                  _.signInWithGoogle();
                                },
                              AssetImage(
                                'assets/logo/google.jpg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
       }
      )
    );
  }



}