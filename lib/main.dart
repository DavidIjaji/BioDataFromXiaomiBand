//import 'dart:html';
//import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prueba/pages/home_page.dart';
import 'package:flutter_prueba/pages/inicio_page.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_prueba/routes/my_routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    navigatorKey: Get.key,
    getPages: routes(),
  ));
}
*/

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Widget _init = Center(
      child: SpinKitPumpingHeart(
    color: Colors.blue[300],
    size: 150.0,

    //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))
  ));

  @override
  void initState() {
    print("init state");
    super.initState();
  }

  _AppState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        _init = FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return SomethingWentWrong();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Exito();
            }
            return Center(
              child: SpinKitPumpingHeart(
                  color: Colors.blue[300],
                  size: 150.0,
                  controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 3000))),
            );
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("en build");
    // Otherwise, show something whilst waiting for initialization to complete
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: Scaffold(
          backgroundColor: Colors.white,
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            child: _init,
            //transitionBuilder:(child,animation)=>ScaleTransition(
            //scale: animation,
            //child: SizedBox.expand(child:child),),
            switchInCurve: Curves.fastOutSlowIn,
          )),
    );
  }
}

/*
class Loading extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      

    );
  }
}
*/

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPumpingHeart(
          color: Colors.pink,
          size: 50.0,
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: new Text('Algo salio mal')),
    );
  }
}

class Exito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: InicioPage(),
    );
  }
}


/*
class Exito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exito'),
        ),
      ),
    );
  }
}
*/
/*
class Autentificado {
  Future<bool> autentificado() async{

        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          return(false)
        } else {
          print('User is signed in!');
          return(true)
        }
      });
    }
}
*/