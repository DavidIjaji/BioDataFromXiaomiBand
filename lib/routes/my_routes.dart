import 'package:flutter_prueba/pages/formulario_datos.dart';
import 'package:flutter_prueba/pages/home_page.dart';
import 'package:flutter_prueba/pages/login_page.dart';
import 'package:flutter_prueba/pages/register_page.dart';
import 'package:flutter_prueba/pages/start_page.dart';
import 'package:get/route_manager.dart';

routes() => {
      GetPage(name: "/home", page: () => HomePage()),
      GetPage(
          name: "/start", page: () => StartPage(), transition: Transition.zoom),
      GetPage(
          name: "/login", page: () => LoginPage(), transition: Transition.zoom),
      GetPage(
          name: "/registration",
          page: () => RegisterLoginPage(),
          transition: Transition.zoom),
      GetPage(
          name: "/formularioDatos",
          page: () => FormularioDatosPersonales(),
          transition: Transition.zoom),
    };
