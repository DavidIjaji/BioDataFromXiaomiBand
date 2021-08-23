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
import 'package:flutter_prueba/controllers/datos_banda_controller.dart';
import 'package:intl/intl.dart';


import 'package:flutter_prueba/BLOCS/bloc_data.dart';

//import 'package:firebase_auth/firebase_auth.dart';

class StartPage extends StatefulWidget {
  final bloc;
  final bloc_extra;
  StartPage({this.bloc,this.bloc_extra});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with AutomaticKeepAliveClientMixin {
  
  final controller = Get.put(LoginController());
  //num cambia = DatosBanda().bpm();
  //propiedad para hacer las emisiones
  //final data = new DatosBanda();
  //final HR = 90;
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      child: SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                controller.signOut();
              },
              child: Icon(Icons.exit_to_app),
              backgroundColor: Colors.red,
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height * 0.1,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        child: Text("BioSolutions",
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              )
                              )
                              ),
      
                    Container(
                        color: Colors.white,
                        //este container tendra las tarjetas de los datos a visualizar
                        height:MediaQuery.of(context).copyWith().size.height * 0.8,    
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
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                            children: [
                              //aqui se pondran las cartas
                              CardBPM(bloc: widget.bloc),
                              //la otra variable capturada Pasos
                              Pasos(bloc:widget.bloc_extra, linearGradient2: linearGradient2),
                              //otra variable Clorias
                              Calorias(bloc: widget.bloc_extra ,linearGradient2: linearGradient2),
      
                              Distancia(bloc:widget.bloc_extra)
      
      
                            ],
                            addAutomaticKeepAlives: false,
                          ),
                        ))
                  ]),
            )),
      ),
      //),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CardBPM extends StatelessWidget {
  final bloc;
  //final bloc_extra;

  CardBPM({
    Key? key,
    this.bloc,
  }) : super(key: key);

  //final DatosBanda data;

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
                child: Text("BPM",
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
              StreamBuilder<int>(
                stream: bloc.data,
                initialData: 0,
                builder: (c, snapshot) {
                final value = snapshot.data!;
                print("desde start page");
                print(value);
                return Container(
                  width: 100,
                  child: Text(value.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue))
                      
                      // return Text(0.toString(),
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //         fontSize: 60,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.blue));
                      
                     
                  
                );
                }
              ),
            ],
          ),
          Container(
                child: GraficaBPM(bloc: bloc),
              )
            
          ,
        ],
      ),
    );
  }
}

class Calorias extends StatelessWidget {
  const Calorias({
    Key? key,
    this.bloc,
    this.linearGradient2}) : super(key: key);

  final linearGradient2;
  final bloc;

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
                            dataSource:_chartDataCalorias,
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
                          StreamBuilder<List<int>>(
                            stream: bloc.data,
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                final value = snapshot.data!;
                                return Text((value[9]+256*value[10]+256*value[11]+256*value[12]).toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //color: Colors.black,
                                      fontWeight: FontWeight.bold,)
                                      );
                                      }
                              return Text("Cargando...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )
                                    );
                            }
                          ),
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

class Distancia extends StatelessWidget {
  const Distancia({
    Key? key,
    this.bloc,
    this.linearGradient2,
  }) : super(key: key);
  final bloc;
  final Shader? linearGradient2;

  @override
  Widget build(BuildContext context) {
    final List<_ChartDataDistancia> _chartDataDistancia = [
      _ChartDataDistancia('Distancia', 1000, Colors.blue),
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
                          RadialBarSeries<_ChartDataDistancia, String>(
                            dataSource: _chartDataDistancia,
                            xValueMapper: (_ChartDataDistancia data, _) => data.x,
                            yValueMapper: (_ChartDataDistancia data, _) => data.y,
                            pointColorMapper: (_ChartDataDistancia data, _) =>
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
                          Text("Distancia",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                //color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                          Icon(Icons.directions_walk,
                              color: Colors.blue, size: 40),
                          StreamBuilder<List<int>>(
                            stream: bloc.data,
                            
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                final value = snapshot.data!;
                                return Text((value[5]+256*value[6]+256*value[7]+256*value[8]).toString()+" m",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //color: Colors.black,
                                      fontWeight: FontWeight.bold,)
                                      );
                                      }
                              return Text("Cargando...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )
                                    );
                            }
                          ),
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

class _ChartDataDistancia {
  _ChartDataDistancia(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

class GraficaBPM extends StatelessWidget {
  const GraficaBPM({
    Key? key,
    this.bloc,
  }) : super(key: key);

  final bloc;

  @override
  Widget build(BuildContext context) {
    List<_ChartData> chartData = <_ChartData>[
      _ChartData("00:00", 0),
    ];

    ChartSeriesController? _chartSeriesController;
    int contador = 0;
    return StreamBuilder(
      stream: bloc.data, //voy a la clase y la función dentro que entrega el valor del stream
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



class Pasos extends StatelessWidget {
  const Pasos({
    Key? key,
    this.bloc,
    this.linearGradient2,
  }) : super(key: key);
  final bloc;
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
                          StreamBuilder<List<int>>(
                            stream: bloc.data,
                            
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                final value = snapshot.data!;
                                return Text((value[1]+256*value[2]+256*value[3]+256*value[4]).toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //color: Colors.black,
                                      fontWeight: FontWeight.bold,)
                                      );
                                      }
                              return Text("Cargando...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )
                                    );
                            }
                          ),
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
