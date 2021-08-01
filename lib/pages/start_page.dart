import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_prueba/controllers/login_controller.dart';
import 'package:flutter_prueba/controllers/datos_banda_controller.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final controller = Get.put(LoginController());

  num cambia = DatosBanda().bpm();
  //propiedad para hacer las emisiones
  final data = new DatosBanda();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
        appBar: AppBar(
          backgroundColor: Color(003638),
          title: Text("Bienvenido"),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return TextButton(
                  onPressed: () async {
                    controller.signOut();
                  },
                  child: Text('Sing Out'));
            })
          ],
        ),*/
        backgroundColor: Colors.blue,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(80),
                  bottomLeft: Radius.circular(80),
                ),
                color: Colors.blue[900],
              ),
              padding: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.center,
              child: Text("BioSolutions",
                  style: TextStyle(fontSize: 30, color: Colors.white))),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 336,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Frecuencia cardiaca",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blue),
                    ),
                    Icon(Icons.favorite, color: Colors.pink),
                  ],
                ),
                graficaBPM(data: data),
              ])),
        ]));
  }
}

class graficaBPM extends StatelessWidget {
  const graficaBPM({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DatosBanda data;
  //List<_ChartData> chartData = <_ChartData>[];

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now().toString();

    return StreamBuilder(
      stream: data
          .datoBanda, //voy a la clase y la función dentro que entrega el valor del stream
      initialData: 0,
      builder: (_, AsyncSnapshot<dynamic> snapshot) {
        print(snapshot.data);
        // ignore: non_constant_identifier_names
        //<SalesData>[].add(snapshot.data.toDouble());
        //SalesData(now, snapshot.data.toDouble());
        print(SalesData);
        //<SalesData>[].add(now,snapshot.data.toDouble());
        return Card(
          shadowColor: Colors.red,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            //padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue, Colors.red],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: SfCartesianChart(
                      tooltipBehavior: TooltipBehavior(
                          enable: true,
                          activationMode: ActivationMode.longPress),
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        // Initialize line series
                        LineSeries<SalesData, String>(
                            dataSource: [
                              // Bind data source
                              SalesData('01:00', 60),
                              SalesData('01:05', 62),
                              SalesData('01:10', 60),
                              SalesData('01:15', 70),
                              SalesData('01:16', snapshot.data.toDouble())
                            ],
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                            // Render the data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class DataFirestore extends StatelessWidget {
  //const DataFirestore({ Key? key }) : super(key: key);

  DataFirestore(DocumentSnapshot document) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("pacientes").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
          }
          return const Text("Cargando...");
        },
      ),
    );
  }
}
