import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController googleMapController;
  Position? myCurrentPosition;
  Position? myPreviousPosition;

  @override
  void initState() {
    animateCurrentPosition();
    listenCurrentLocation();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Maps",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: googleMap(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: animateCurrentPosition,
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.location_history),
      ),
    );
  }

  Future<void> listenCurrentLocation() async {
    final isPermissionGranted = await checkLocationPermission();

    if (isPermissionGranted) {
      final isGPSEnable = await isGPSEnabled();

      if (isGPSEnable) {
        var position = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 10),
          accuracy: LocationAccuracy.best,
        )).listen((pos) {
          debugPrint('$pos');
          myPreviousPosition = pos;
        });

        position.onData((pos) {
          setState(() {
            myPreviousPosition = pos;
            Timer(const Duration(seconds: 10), () {
              myCurrentPosition = pos;
            });
          });
        });
      } else {
        await Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();

      if (result) {
        getCurrentLocation();
      } else {
        await Geolocator.openAppSettings();
      }
    }
  }

  Future<void> getCurrentLocation() async {
    final isPermissionGranted = await checkLocationPermission();

    if (isPermissionGranted) {
      final isGPSEnable = await isGPSEnabled();

      if (isGPSEnable) {
        myCurrentPosition = await Geolocator.getCurrentPosition();
        debugPrint('$myCurrentPosition');
        setState(() {});
      } else {
        await Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();

      if (result) {
        getCurrentLocation();
      } else {
        await Geolocator.openAppSettings();
      }
    }
  }

  Future<bool> requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkLocationPermission() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isGPSEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> animateCurrentPosition() async {
    await googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 15,
          target: LatLng(
            myCurrentPosition?.latitude ?? 0,
            myCurrentPosition?.longitude ?? 0,
          ),
        ),
      ),
    );
  }

  Widget googleMap(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        getCurrentLocation();
        googleMapController = controller;
      },
      initialCameraPosition: CameraPosition(
        zoom: 15,
        target: LatLng(
          myCurrentPosition?.latitude ?? 0,
          myCurrentPosition?.longitude ?? 0,
        ),
      ),
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      mapType: MapType.normal,
      trafficEnabled: true,
      onTap: (LatLng? latLng) {
        setState(() {
          debugPrint('$latLng');
        });
      },
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('secondary-location'),
          position: LatLng(
            myCurrentPosition?.latitude ?? 0,
            myCurrentPosition?.longitude ?? 0,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
          infoWindow: InfoWindow(
            title: "My current location",
            snippet:
                "${myCurrentPosition?.latitude}, ${myCurrentPosition?.longitude}",
          ),
        ),
      },
      polylines: <Polyline>{
        Polyline(
          polylineId: const PolylineId('random'),
          color: Colors.amber,
          width: 4,
          jointType: JointType.round,
          points: <LatLng>[
            LatLng(myPreviousPosition?.latitude ?? 0,
                myPreviousPosition?.longitude ?? 0),
            LatLng(myCurrentPosition?.latitude ?? 0,
                myCurrentPosition?.longitude ?? 0),
          ],
        ),
      },
      polygons: <Polygon>{
        Polygon(
          polygonId: const PolygonId('default'),
          fillColor: Colors.red.withOpacity(0.5),
          strokeWidth: 1,
          strokeColor: Colors.transparent,
          points: const <LatLng>[
            LatLng(23.89354135070255, 90.1463483646512),
            LatLng(23.894383421129007, 90.17796993255615),
            LatLng(23.875716189611246, 90.17909545451403),
            LatLng(23.877119728445578, 90.14624610543251),
          ],
        ),
      },
    );
  }
}
