

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget usuario() => ListTile(
    title: Text("Daniel Vallejo",
    style: TextStyle(fontSize: 35,
                      fontWeight: FontWeight.normal),),
    leading: Icon(Icons.person,color: Colors.blueAccent , size: 70.0, ),
    onTap: ()=>Get.snackbar("Saliendo", "presionó en cerrar sesión"),
    subtitle: Text("daniel@daniel.com",
    style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.normal)),

  );

  Widget notifications() => ListTile(
    title: Text("Notificaciones",
    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.normal),),
    leading: Icon(Icons.notifications,color: Colors.pinkAccent  ),
    onTap: ()=>Get.snackbar("notificaciones", "presionó en notificaciones"),
    subtitle: Text("Actualizaciones de la app, frecuencia cardiaca...",
    style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.normal)),

  );

  Widget darkmode()=>ListTile(
    title: Row(
      children: [
        Text("Modo oscuro",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal),),
          SizedBox(width: 70,),
          CupertinoSwitch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
      ],
    ),
    leading: Icon(Icons.dark_mode_outlined,color: Colors.blueAccent[700]  ),
    

  );


  Widget account() => ListTile(
    title: Text("Configuración de la cuenta",
    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.normal),),
    leading: Icon(Icons.person,color: Colors.greenAccent  ),
    onTap: ()=>Get.snackbar("Cuenta", "presionó en cuenta"),
    subtitle: Text("contraseña, privacidad, idioma",
    style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.normal)),

  );

  Widget buildLogout() => ListTile(
    title: Text("Cerrar sesión",
    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.normal),),
    leading: Icon(Icons.logout,color: Colors.blueAccent ,),
    onTap: ()=>Get.snackbar("Saliendo", "presionó en cerrar sesión"),

  );

  Widget buildDeleteAccount() => ListTile(
    title: Text("Borrar cuenta",
    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.normal)),

    leading: Icon(Icons.delete,color: Colors.redAccent ,),
    onTap: ()=>Get.snackbar("Borrando cuenta", "presionó en borrar cuenta"),

  );

  Widget reportabug() => ListTile(
    title: Text("Reporta un error",
    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.normal)),

    leading: Icon(Icons.bug_report,color: Colors.purpleAccent ,),
    onTap: ()=>Get.snackbar("Reportando error", "presionó en reportar bug"),

  );

  Widget sendfeedback() => ListTile(
    title: Text("Envía feedback!",
    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.normal)),

    leading: Icon(Icons.delete,color: Colors.greenAccent ,),
    onTap: ()=>Get.snackbar("Enviando feedback", "presionó en feedback"),

  );
  bool _switchValue=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              Container(
                child: Column(
                  children:<Widget>[
                   Text("Configuraciones",style: TextStyle(fontSize: 30,
                        fontWeight: FontWeight.bold)
                      ),
                    SizedBox(height: 25.0,),
                    usuario(),
                    SizedBox(height: 25.0,),
                    darkmode()
                ],
                ),
                
              ),
              SizedBox(height: 20.0,),
              Container(
                child: Column(
                  children:<Widget>[
                    ListTile(
                      title: Text("General",
                      ),
                    ),
                    account(),
                    notifications(),
                    buildLogout(),
                    buildDeleteAccount()
                ],
                ),
                
              ),
              SizedBox(height: 20.0,),
    
              Container(
                child: Column(
                  children:<Widget>[
                    ListTile(
                      title: Text("Feedback"),
                    ),
                    reportabug(),
                    sendfeedback()
                ],
                ),
                
              ),
    
    
            ],
          )
          ),
      );
    
    
  }
}