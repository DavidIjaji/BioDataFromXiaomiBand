import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_prueba/pages/home_page.dart';
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
    final Shader? linearGradient = LinearGradient(
      colors: <Color>[Colors.white, Colors.blue],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200, 70));
    final Shader? linearGradient1 = LinearGradient(
      colors: <Color>[Colors.green, Colors.white],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 300, 400));
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            controller.signOut();
          },
          child: Icon(Icons.exit_to_app),
          backgroundColor: Colors.red,
        ),
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                height: MediaQuery.of(context).copyWith().size.height * 0.2,
                color: Colors.black,
                padding: const EdgeInsets.only(top: 20.0),
                alignment: Alignment.center,
                child: Text("BioSolutions",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient))),
            Container(
                //este container tendra las tarjetas de los datos a visualizar
                height: MediaQuery.of(context).copyWith().size.height * 0.8,
                width: MediaQuery.of(context).copyWith().size.width,
                //padding: const EdgeInsets.all(20),
                //height: 500,
                //width: 300,
                /*decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.blue, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),*/
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      //aqui se pondran las cartas
                      Card(
                        elevation: 10,
                        shadowColor: Colors.green,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: Text("Frecuencia cardiaca",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          //color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = linearGradient1)),
                                ),
                                Icon(Icons.favorite,
                                    color: Colors.green, size: 40),
                                Container(
                                  width: 100,
                                  child: Text(90.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ),
                              ],
                            ),
                            Container(
                              child: graficaBPM(data: data),
                            ),
                          ],
                        ),
                      ),
                      //la otra variable capturada
                    ],
                  ),
                ))
          ]),
        ));
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
    num _getRandomInt(int min, int max) {
      final Random random = Random();
      return min + random.nextInt(max - min);
    }

    ChartSeriesController? _chartSeriesController;
    void _updateDataSource(Timer timer) {
      List<_ChartData> chartData = <_ChartData>[];

      // Count of type integer which binds as x value for the series
      String count = DateTime.now().toString();
      chartData.add(_ChartData(count, _getRandomInt(10, 100).toInt()));
      if (chartData.length == 20) {
        // Removes the last index data of data source.
        chartData.removeAt(0);
        // Here calling updateDataSource method with addedDataIndexes to add data in last index and removedDataIndexes to remove data from the last.
        _chartSeriesController?.updateDataSource(
            addedDataIndexes: <int>[chartData.length - 1],
            removedDataIndexes: <int>[0]);
      }
      //count = count.second + timer;
    }

    Timer? timer;
    timer =
        Timer.periodic(const Duration(milliseconds: 1000), _updateDataSource);

    // Data source which binds to the series

    List<_ChartData> chartData = <_ChartData>[
      _ChartData(DateTime.now().toString(), 60)
    ];

    return StreamBuilder(
      stream: data
          .datoBanda, //voy a la clase y la función dentro que entrega el valor del stream
      initialData: 0,
      builder: (_, AsyncSnapshot<dynamic> snapshot) {
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
                  height: 120,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.green, Colors.white],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: SfCartesianChart(
                      /*
                    series: <LineSeries<_ChartData, String>>[
                      LineSeries<_ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          // Assigning the controller to the _chartSeriesController.
                          _chartSeriesController = controller;
                        },
                        // Binding the chartData to the dataSource of the line series.
                        dataSource: chartData,
                        xValueMapper: (_ChartData data, _) => data.hora,
                        yValueMapper: (_ChartData data, _) => data.bpm,
                      )
                    ],*/
                      ),

                  /*SfCartesianChart(
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
                      ]),*/
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChartData {
  _ChartData(this.hora, this.bpm);
  final String hora;
  final int bpm;
}
/*
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
    final List<_ChartData> chartData = <_ChartData>[];
    Timer? timer;
    ChartSeriesController? _chartSeriesController;
    // Count of type integer which binds as x value for the series
    int count = 19;
    List<_ChartData> chartData = <_ChartData>[
      _ChartData(DateTime.now(), 0),
    ];
    timer = Timer.periodic(const Duration(milliseconds: 1000), _updateDataSource);
    //var now = DateTime.now().toString();

    void _updateDataSource(Timer timer) {
      chartData.add(_ChartData(count, _getRandomInt(10, 100)));
      if (chartData.length == 20) {
        // Removes the last index data of data source.
        chartData.removeAt(0);
        // Here calling updateDataSource method with addedDataIndexes to add data in last index and removedDataIndexes to remove data from the last.
        _chartSeriesController?.updateDataSource(addedDataIndexes: <int>[chartData.length – 1],              removedDataIndexes: <int>[0]);
      }
      count = count + 1;
    }
    num _getRandomInt(num min, num max) {
   final Random random = Random();
   return min + random.nextInt(max - min);
}
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
*/