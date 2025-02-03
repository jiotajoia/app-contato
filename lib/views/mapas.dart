import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trabalho_final/controllers/bd.controller.dart';
import 'package:trabalho_final/controllers/utils.dart';

class Mapas extends StatefulWidget {
  const Mapas({super.key});

  @override
  State<Mapas> createState() => _MapasState();
}

class _MapasState extends State<Mapas> {
  late GoogleMapController mapController;
  final Location _location = Location();
  LatLng? localizacao;
  var dados = [];
  
  Set<Marker> marcadores = {};

  obterDados() async {
    Database bd = await abrirBanco();
    dados = await bd.query("contato");
    
    setState(() {
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  
  @override
  void initState() {
    super.initState();
    checkPermission();
    obterDados();
    carregarMarcadores();
  }

  checkPermission() async{
    
    final permissionStatus = await _location.requestPermission();
    final serviceEnabled = await _location.serviceEnabled();

    if (permissionStatus == PermissionStatus.granted && serviceEnabled) {
      // Localização disponível
    } else {
      // Solicitar novamente caso necessário
      if (!serviceEnabled) {
        final serviceRequested = await _location.requestService();
        if (serviceRequested) {
          // Localização disponível
        }
      }
    }
    var local = await _location.getLocation();

    setState(() {
      localizacao = LatLng(local.latitude!, local.longitude!);
    });

  }
  
  carregarMarcadores() async {
    Set<Marker> marcadorLocal = {};
    
    for (var dado in dados){
      Marker marcador1 = Marker(
        markerId:  MarkerId(dado['nome']),
        position:  LatLng(dado['latitude'], dado['longitude']),
        icon: await getBitmapFromUrl(dado['imagem']),
        infoWindow: InfoWindow(
          title: dado['nome'],
          snippet: dado['descricao'],
          )
        );
      marcadorLocal.add(marcador1);
    }
    setState(() {
      marcadores = marcadorLocal;
    });
  }

  @override
  Widget build(BuildContext context) {
    carregarMarcadores(); 
    return Scaffold(
        appBar: AppBar(
          title: const Text('mapas'),
          backgroundColor: Colors.yellow,
        ),
        body: localizacao == null ?
          const Center( child: CircularProgressIndicator(),) :
        
          GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: localizacao!,
            zoom: 15.0,
          ),
          markers: marcadores,
        ),
        
      );
  }
}