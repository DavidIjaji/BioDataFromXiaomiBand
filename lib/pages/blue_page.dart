import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as AES;
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:pointycastle/api.dart' as API;
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/ecb.dart';


import 'package:hex/hex.dart';

class BluePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 

       StreamBuilder<BluetoothState>(
            stream: FlutterBlue.instance.state,
            initialData: BluetoothState.unknown,
            builder: (c, snapshot) {
              final state = snapshot.data;
              if (state == BluetoothState.on) {
                return FindDevicesScreen();
              }
              return BluetoothOffScreen(state: state);
            });
       
    
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, //buscar
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)  //buscar
                  .primaryTextTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}


class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map<Widget>(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            r.device.discoverServices();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;
  
  Future<void>FlujoPeticiones(
    List<BluetoothCharacteristic> HRcharacteristics,
    List<BluetoothCharacteristic> MOREDATAcharacteristics,
    List<BluetoothCharacteristic> AUTHcharacteristics) 
    async{
      //print(device.name);
      final String llave;
      if(device.name=="Amazfit Band 5"){
        llave="2ac092e2f4666eb3e0465171043f3e1b";
      }else if(device.name=="Mi Smart Band 4"){
        llave="2db9134728769f4ae34d8e672688f3f5";
      }else{
        llave="";
      }
      //print(HEX.decode("2ac092e2f4666eb3e0465171043f3e1b"));
      
      
      await AUTHcharacteristics[0].write([1,0, ...HEX.decode(llave)], withoutResponse: true);
      await AUTHcharacteristics[0].setNotifyValue(!AUTHcharacteristics[0].isNotifying);
      await AUTHcharacteristics[0].write([2,0], withoutResponse: true);
      AUTHcharacteristics[0].value.listen((value)async {
        print(HEX.encode(value));
        if (value.length>16) {
          //final KEYAUTH = HEX.encode(value).substring(6,);
          final Uint8List KEYAUTH  = Uint8List.fromList(
            [...HEX.decode(llave)],
          );

          Uint8List randomNumber = Uint8List.fromList(
            [...HEX.decode(HEX.encode(value).substring(6,))],
          );
          print("RANDOM NUMBER");
          print(randomNumber);

          API.BlockCipher cipher = ECBBlockCipher(AESFastEngine());

          cipher.init(
            true,
            API.KeyParameter(KEYAUTH),
          );
          Uint8List ENCRIPTACION = cipher.process(randomNumber);
          print("ENCRIPTACION");
          print(HEX.encode(ENCRIPTACION));
          await AUTHcharacteristics[0].write([3,0,...ENCRIPTACION], withoutResponse: true);

            //await HRcharacteristics[1].write([0x15,0x02,0x01], withoutResponse: true);
            //await HRcharacteristics[0].read();
            await HRcharacteristics[0].setNotifyValue(!HRcharacteristics[0].isNotifying);
            await MOREDATAcharacteristics[0].setNotifyValue(!MOREDATAcharacteristics[0].isNotifying);
            
            
            
            HRcharacteristics[0].value.listen((value){
              print(value[1]);
            });
            
            //await MOREDATAcharacteristics[0].read();
            MOREDATAcharacteristics[0].value.listen((value){
              print(value);
            });
             
           
        }
          });
      
      

  }
 

  Widget _authenticate(List<BluetoothService> services) {
    final List<BluetoothCharacteristic> HRcharacteristics ;
    final List<BluetoothCharacteristic> AUTHcharacteristics;
    final List<BluetoothCharacteristic> MOREDATAcharacteristics;


    services=services.where((s) => 
      s.uuid.toString().toUpperCase().substring(4, 8)=="FEE1"
    ||s.uuid.toString().toUpperCase().substring(4, 8)=="180D" 
    ||s.uuid.toString().toUpperCase().substring(4, 8)=="FEE0",

    ).toList();
    
    //print(services);
    if(services.length==0){
    return Text("Debes autenticar tu banda para ver tus datos en la app!");
    }else{
      HRcharacteristics=services[0].characteristics.toList();

      MOREDATAcharacteristics=services[1].characteristics.where((c) => 
      c.uuid.toString().toUpperCase().substring(4, 8)=="0007").toList();

      AUTHcharacteristics=services[2].characteristics.where((c) => 
      c.uuid.toString().toUpperCase().substring(4, 8)=="0009").toList();

      FlujoPeticiones(HRcharacteristics,MOREDATAcharacteristics,AUTHcharacteristics);
    //au
       print(HRcharacteristics);
      // print(AUTHcharacteristics);
      // print(MOREDATAcharacteristics);
      return TextButton(onPressed: (){},child: Text("si hay"),);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Container(
                  child: Center(
                    child: 
                    
                     _authenticate(snapshot.data!),
                    
                  ),
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}


class ScanResultTile extends StatelessWidget {
  ScanResultTile({  required this.result,required this.onTap});

  final ScanResult result;
  final VoidCallback onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              //style: Theme.of(context)
                  //.textTheme
                  //.caption
                  //.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return "Vacio";
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return "Vacio";
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: ElevatedButton(
        child: Text('CONNECT'),
        //color: Colors.black,
        //textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        _buildAdvRow(
            context, 'Complete Local Name', result.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(
            context,
            'Manufacturer Data',
            getNiceManufacturerData(
                    result.advertisementData.manufacturerData) ??
                'N/A'),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'Service Data',
            getNiceServiceData(result.advertisementData.serviceData) ),
      ],
    );
  }
}

// class DeviceScreen extends StatelessWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);

//   final BluetoothDevice device;

//   Future<void>FlujoPeticiones(
//     List<BluetoothCharacteristic> HRcharacteristics,
//     List<BluetoothCharacteristic> AUTHcharacteristics,
//     List<BluetoothCharacteristic> MOREDATAcharacteristics) async{
//       await AUTHcharacteristics[0].setNotifyValue(!AUTHcharacteristics[0].isNotifying);
//             AUTHcharacteristics[0].value.listen((value) {
//               print(value);
//                 });
      

//   }
 

//   Widget _authenticate(List<BluetoothService> services) {
//     final List<BluetoothCharacteristic> HRcharacteristics ;
//     final List<BluetoothCharacteristic> AUTHcharacteristics;
//     final List<BluetoothCharacteristic> MOREDATAcharacteristics;


//     services=services.where((s) => 
//       s.uuid.toString().toUpperCase().substring(4, 8)=="FEE1"
//     ||s.uuid.toString().toUpperCase().substring(4, 8)=="180D" 
//     ||s.uuid.toString().toUpperCase().substring(4, 8)=="FEE0",

//     ).toList();
    
//     //print(services);
//     if(services.length==0){
//     return Text("Debes autenticar tu banda para ver tus datos en la app!");
//     }else{
//       HRcharacteristics=services[0].characteristics.toList();

//       MOREDATAcharacteristics=services[1].characteristics.where((c) => 
//       c.uuid.toString().toUpperCase().substring(4, 8)=="0007").toList();

//       AUTHcharacteristics=services[2].characteristics.where((c) => 
//       c.uuid.toString().toUpperCase().substring(4, 8)=="0009").toList();

//       FlujoPeticiones(HRcharacteristics,MOREDATAcharacteristics,AUTHcharacteristics);
//     //au
//       print(HRcharacteristics);
//       print(AUTHcharacteristics);
//       print(MOREDATAcharacteristics);
//       return TextButton(onPressed: (){},child: Text("si hay"),);
//     }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(device.name),
//         actions: <Widget>[
//           StreamBuilder<BluetoothDeviceState>(
//             stream: device.state,
//             initialData: BluetoothDeviceState.connecting,
//             builder: (c, snapshot) {
//               VoidCallback? onPressed;
//               String text;
//               switch (snapshot.data) {
//                 case BluetoothDeviceState.connected:
//                   onPressed = () => device.disconnect();
//                   text = 'DISCONNECT';
//                   break;
//                 case BluetoothDeviceState.disconnected:
//                   onPressed = () => device.connect();
//                   text = 'CONNECT';
//                   break;
//                 default:
//                   onPressed = null;
//                   text = snapshot.data.toString().substring(21).toUpperCase();
//                   break;
//               }
//               return TextButton(
//                   onPressed: onPressed,
//                   child: Text(
//                     text,
//                     style: Theme.of(context)
//                         .primaryTextTheme
//                         .button
//                         ?.copyWith(color: Colors.white),
//                   ));
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<BluetoothDeviceState>(
//               stream: device.state,
//               initialData: BluetoothDeviceState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 leading: (snapshot.data == BluetoothDeviceState.connected)
//                     ? Icon(Icons.bluetooth_connected)
//                     : Icon(Icons.bluetooth_disabled),
//                 title: Text(
//                     'Device is ${snapshot.data.toString().split('.')[1]}.'),
//                 subtitle: Text('${device.id}'),
//                 trailing: StreamBuilder<bool>(
//                   stream: device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data! ? 1 : 0,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(Icons.refresh),
//                         onPressed: () => device.discoverServices(),
//                       ),
//                       IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.grey),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             StreamBuilder<int>(
//               stream: device.mtu,
//               initialData: 0,
//               builder: (c, snapshot) => ListTile(
//                 title: Text('MTU Size'),
//                 subtitle: Text('${snapshot.data} bytes'),
//                 trailing: IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => device.requestMtu(223),
//                 ),
//               ),
//             ),
//             StreamBuilder<List<BluetoothService>>(
//               stream: device.services,
//               initialData: [],
//               builder: (c, snapshot) {
//                 return Container(
//                   child: Center(
//                     child: 
                    
//                      _authenticate(snapshot.data!),
                    
//                   ),
//                 );
//               },
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }
