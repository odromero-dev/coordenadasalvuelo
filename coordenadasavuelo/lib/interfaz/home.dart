import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:reto4/control/control.dart';
import 'package:reto4/interfaz/listar.dart';
import 'package:reto4/proceso/peticiones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'coordenadas al Vuelo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Coordenadasalvuelo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  control Control = Get.find();

  void ObtenerPosicion() async {
    Position posicion = await PeticionesDB.determinePosition();
    print(posicion.toString());
    Control.cargaUnaPosicion(posicion.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Aviso!!!",
                        buttons: [
                          DialogButton(
                              color: Colors.yellow,
                              child: Text("SI"),
                              onPressed: () {
                                PeticionesDB.EliminarTodas();
                                Control.CargarTodaBD();
                                Navigator.pop(context);
                              }),
                          DialogButton(
                              color: Colors.blue,
                              child: Text("NO"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                        desc: "Eliminar TODAS LAS UBICACIONES?")
                    .show();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: listar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ObtenerPosicion();
          Alert(
                  title: "Aviso!!!",
                  desc: "Guardar Ubicacion " + Control.unaPosicion + "?",
                  type: AlertType.info,
                  buttons: [
                    DialogButton(
                        color: Colors.yellow,
                        child: Text("SI"),
                        onPressed: () {
                          PeticionesDB.GuardarPosicion(
                              Control.unaPosicion, DateTime.now().toString());
                          Control.CargarTodaBD();
                          Navigator.pop(context);
                        }),
                    DialogButton(
                        color: Colors.blue,
                        child: Text("NO"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                  context: context)
              .show();
        },
        child: Icon(Icons.location_history),
      ),
      
    );
    
  }
}
