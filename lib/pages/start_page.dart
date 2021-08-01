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
    final Shader? linearGradient2 = LinearGradient(
      colors: <Color>[Colors.yellow, Colors.black],
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
                      //la otra variable capturada Pasos
                      Pasos(linearGradient2: linearGradient2),
                      //otra variable Clorias
                      Calorias(linearGradient2: linearGradient2),
                    ],
                  ),
                ))
          ]),
        ));
  }
}

class Calorias extends StatelessWidget {
  const Calorias({
    Key? key,
    required this.linearGradient2,
  }) : super(key: key);

  final Shader? linearGradient2;

  @override
  Widget build(BuildContext context) {
    final List<_ChartDataPasos> _chartDataPasos = [
      _ChartDataPasos('Calorias', 500, Colors.pink),
    ];
    late TooltipBehavior _tooltipBehavior;

    _tooltipBehavior = TooltipBehavior(enable: true);
    return Card(
      elevation: 10,
      shadowColor: Colors.yellow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                child: SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      // Render pie chart
                      RadialBarSeries<_ChartDataPasos, String>(
                          dataSource: _chartDataPasos,
                          xValueMapper: (_ChartDataPasos data, _) => data.x,
                          yValueMapper: (_ChartDataPasos data, _) => data.y,
                          pointColorMapper: (_ChartDataPasos data, _) =>
                              data.color,
                          trackColor: Colors.red,
                          strokeColor: Colors.yellow,
                          maximumValue: 1200,
                          enableTooltip: true,
                          cornerStyle: CornerStyle.bothCurve),
                    ]),
              ),
              Container(
                //width: 200,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Calorias",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                //color: Colors.black,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient2)),
                      ],
                    ),
                    Icon(Icons.fireplace_rounded, color: Colors.red, size: 40),
                    Text("0",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            //color: Colors.black,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient2)),
                  ],
                ),
              ), /*
              
              Container(
                width: 10,
                child: Text(90.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}

class Pasos extends StatelessWidget {
  const Pasos({
    Key? key,
    required this.linearGradient2,
  }) : super(key: key);

  final Shader? linearGradient2;

  @override
  Widget build(BuildContext context) {
    final List<_ChartDataPasos> _chartDataPasos = [
      _ChartDataPasos('Pasos', 500, Colors.yellow),
    ];
    late TooltipBehavior _tooltipBehavior;

    _tooltipBehavior = TooltipBehavior(enable: true);
    return Card(
      elevation: 10,
      shadowColor: Colors.yellow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                child: SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      // Render pie chart
                      RadialBarSeries<_ChartDataPasos, String>(
                          dataSource: _chartDataPasos,
                          xValueMapper: (_ChartDataPasos data, _) => data.x,
                          yValueMapper: (_ChartDataPasos data, _) => data.y,
                          pointColorMapper: (_ChartDataPasos data, _) =>
                              data.color,
                          trackColor: Colors.amber,
                          strokeColor: Colors.yellow,
                          maximumValue: 1200,
                          enableTooltip: true,
                          cornerStyle: CornerStyle.bothCurve),
                    ]),
              ),
              Container(
                //width: 200,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Pasos",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                //color: Colors.black,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient2)),
                      ],
                    ),
                    Icon(Icons.directions_walk, color: Colors.orange, size: 40),
                    Text("0",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            //color: Colors.black,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient2)),
                  ],
                ),
              ), /*
              
              Container(
                width: 10,
                child: Text(90.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartDataPasos {
  _ChartDataPasos(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

class graficaBPM extends StatelessWidget {
  const graficaBPM({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DatosBanda data;

  @override
  Widget build(BuildContext context) {
    List<_ChartData> chartData = <_ChartData>[
      _ChartData("00:00", 0),
    ];

    ChartSeriesController? _chartSeriesController;
    int contador = 0;
    return StreamBuilder(
      stream: data
          .datoBanda, //voy a la clase y la función dentro que entrega el valor del stream
      initialData: 0,
      builder: (_, AsyncSnapshot<dynamic> snapshot) {
        int entregarBPM() {
          return snapshot.data;
        }

        void _updateDataSource() {
          contador = contador + 1;
          chartData
              .add(_ChartData(contador.toString(), snapshot.data.toDouble()));
          if (chartData.length == 20) {
            // Removes the last index data of data source.
            chartData.removeAt(0);
            // Here calling updateDataSource method with addedDataIndexes to add data in last index and removedDataIndexes to remove data from the last.
            _chartSeriesController?.updateDataSource(
                addedDataIndexes: <int>[chartData.length - 1],
                removedDataIndexes: <int>[0]);
          }
        }

        _updateDataSource();

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
                      tooltipBehavior: TooltipBehavior(
                          enable: true,
                          activationMode: ActivationMode.longPress),
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        // Initialize line series
                        LineSeries<_ChartData, String>(
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              // Assigning the controller to the _chartSeriesController.
                              _chartSeriesController = controller;
                            },
                            dataSource: chartData,
                            xValueMapper: (_ChartData sales, _) => sales.hora,
                            yValueMapper: (_ChartData sales, _) => sales.bpm,
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

class _ChartData {
  _ChartData(this.hora, this.bpm);
  final String hora;
  final double bpm;
}
