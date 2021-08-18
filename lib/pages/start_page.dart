import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_prueba/controllers/firestore_controller.dart';
import 'package:flutter_prueba/pages/home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_prueba/controllers/login_controller.dart';
import 'package:flutter_prueba/controllers/datos_banda_controller.dart';
import 'package:intl/intl.dart';

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
  final HR = 90;
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
    return Container(
      //height: double.infinity,
      //child: SingleChildScrollView(
      //physics: AlwaysScrollableScrollPhysics(),
      /*
        padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 120.0,
            ),
            */
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              controller.signOut();
              FSCRUD().LeerDatosPaciente("davidijajo@gmail.com");
              //controller.RevisarDatos("6373738");
              /*
              FSCRUD().AddVariable(
                  "davidijajo@gmail.com", "09082021", "Pasos", "1500");
              FSCRUD().LeerVariable("davidijajo@gmail.com", "07082021", "HR");
              FSCRUD()
                  .AddVariable("davidijajo@gmail.com", "07082021", "Pasos", "10");
              FSCRUD().AddVariable(
                  "davidijajo@gmail.com", "07082021", "Distancia", "40");
                  
              DateTime now = DateTime.now();
              String formattedDate = DateFormat('kk:mm').format(now);
              FSCRUD().AddHR("davidijajo@gmail.com", "11082021", [
                60,
                61,
                63,
                62,
                65
              ], [
                formattedDate,
                formattedDate,
                formattedDate,
                formattedDate,
                formattedDate
              ]);
              */
            },
            child: Icon(Icons.exit_to_app),
            backgroundColor: Colors.red,
          ),
          body: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.2,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text("BioSolutions",
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            /*foreground: Paint()..shader = linearGradient*/
                          ))),
                  Container(
                      color: Colors.white,
                      //este container tendra las tarjetas de los datos a visualizar
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.8,
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
                        child: ListView(
                          children: [
                            //aqui se pondran las cartas
                            CardBPM(data: data),
                            //la otra variable capturada Pasos
                            Pasos(linearGradient2: linearGradient2),
                            //otra variable Clorias
                            Calorias(linearGradient2: linearGradient2),
                          ],
                          addAutomaticKeepAlives: false,
                        ),
                      ))
                ]),
          )),
      //),
    );
  }
}

class CardBPM extends StatelessWidget {
  const CardBPM({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DatosBanda data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blue,
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
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                    )),
              ),
              /*Icon(Icons.favorite,
              color: Colors.blue, size: 40),*/
              SpinKitPumpingHeart(
                color: Colors.blue[300],
                size: 40,
              ),
              Container(
                width: 100,
                child: Text(90.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
            ],
          ),
          Container(
            child: graficaBPM(data: data),
          ),
        ],
      ),
    );
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
    final List<_ChartDataCalorias> _chartDataCalorias = [
      _ChartDataCalorias('Calorias', 700, Colors.blue),
    ];
    late TooltipBehavior _tooltipBehavior;

    _tooltipBehavior = TooltipBehavior(enable: true);
    return Card(
      elevation: 10,
      shadowColor: Colors.blue,
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SfCircularChart(
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          // Render pie chart
                          RadialBarSeries<_ChartDataCalorias, String>(
                            dataSource: _chartDataCalorias,
                            xValueMapper: (_ChartDataCalorias data, _) =>
                                data.x1,
                            yValueMapper: (_ChartDataCalorias data, _) =>
                                data.y1,
                            pointColorMapper: (_ChartDataCalorias data, _) =>
                                data.color1,
                            maximumValue: 1200,
                            enableTooltip: true,
                            animationDuration: 10,
                            innerRadius: "60",
                            cornerStyle: CornerStyle.bothFlat,
                            trackBorderWidth: 1,
                            trackBorderColor: Colors.transparent,
                            radius: "100%",
                          ),
                        ]),
                    Container(
                      //width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Calorias",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      //color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = linearGradient2)),
                            ],
                          ),
                          Icon(Icons.fireplace_rounded,
                              color: Colors.blue, size: 40),
                          Text("0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  //color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = linearGradient2)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /*
              
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

class _ChartDataCalorias {
  _ChartDataCalorias(this.x1, this.y1, this.color1);
  final String x1;
  final int y1;
  final Color color1;
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
      _ChartDataPasos('Pasos', 500, Colors.blue),
    ];
    late TooltipBehavior _tooltipBehavior;

    _tooltipBehavior = TooltipBehavior(enable: true);
    return Card(
      elevation: 10,
      shadowColor: Colors.blue,
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SfCircularChart(
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          // Render pie chart
                          RadialBarSeries<_ChartDataPasos, String>(
                            dataSource: _chartDataPasos,
                            xValueMapper: (_ChartDataPasos data, _) => data.x,
                            yValueMapper: (_ChartDataPasos data, _) => data.y,
                            pointColorMapper: (_ChartDataPasos data, _) =>
                                data.color,
                            maximumValue: 1200,
                            enableTooltip: true,
                            animationDuration: 10,
                            innerRadius: "60",
                            cornerStyle: CornerStyle.bothFlat,
                            trackBorderWidth: 1,
                            trackBorderColor: Colors.transparent,
                            radius: "100%",
                          ),
                        ]),
                    Container(
                      //width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Pasos",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                //color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                          Icon(Icons.directions_walk,
                              color: Colors.blue, size: 40),
                          Text("0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                //color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /*
              
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

        return Column(
          children: [
            Container(
              height: 120,
              /*
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green, Colors.white],
                      begin: Alignment.topRight,
                      end: Alignment.topLeft)),
                      */
              child: SfCartesianChart(
                  backgroundColor: Colors.white,
                  tooltipBehavior: TooltipBehavior(
                      canShowMarker: true,
                      enable: true,
                      activationMode: ActivationMode.singleTap),
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                  ),
                  primaryYAxis: CategoryAxis(isVisible: false),
                  series: <ChartSeries>[
                    // Initialize line series
                    AreaSeries<_ChartData, String>(
                        enableTooltip: true,
                        gradient: LinearGradient(
                            colors: <Color>[Colors.white, Colors.blue],
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter),
                        onRendererCreated: (ChartSeriesController controller) {
                          // Assigning the controller to the _chartSeriesController.
                          _chartSeriesController = controller;
                        },
                        dataSource: chartData,
                        xValueMapper: (_ChartData sales, _) => sales.hora,
                        yValueMapper: (_ChartData sales, _) => sales.bpm,
                        // Render the data label
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true, alignment: ChartAlignment.center))
                  ]),
            ),
          ],
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
