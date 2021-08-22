import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_prueba/BLOCS/bloc_extra_data.dart';
import 'package:flutter_prueba/pages/home_page.dart';
import 'package:flutter_prueba/pages/start_page.dart';
import 'package:flutter_prueba/pages/blue_page.dart';
import 'package:flutter_prueba/pages/settings_page.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_prueba/controllers/login_controller.dart';
import 'package:flutter_prueba/controllers/datos_banda_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_prueba/BLOCS/bloc_data.dart';


final bloc = DataHRBloc();
final blocExtra = DataEXTRABloc();
class InicioPage extends StatefulWidget {
  const InicioPage({ Key? key }) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int _paginaActual =0;
  
  List<Widget> paginas = [StartPage(bloc: bloc,bloc_extra:blocExtra), BluePage(bloc: bloc, bloc_extra:blocExtra), SettingsPage()];
  @override
  Widget build(BuildContext context) {
    //final provider= DataBloc();
    return  Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                setState(() {
                  _paginaActual=index;
                });
              },
              currentIndex: _paginaActual,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Inicio" ),
                BottomNavigationBarItem(icon: Icon(Icons.bluetooth),label: "Conexión" ),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Configuraciones" ),
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     controller.signOut();
            //   },
            //   child: Icon(Icons.exit_to_app),
            //   backgroundColor: Colors.red,
            // ),
            body: paginas[_paginaActual]
          
    );

  }
}