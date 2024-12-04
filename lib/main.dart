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


  Future<void> listenCurrentLocation() async {
    final isPermissionGranted = await checkLocationPermission();

    if (isPermissionGranted) {
      final isGPSEnable = await isGPSEnabled();

      if (isGPSEnable) {
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            timeLimit: Duration(seconds: 3),
            // distanceFilter: 10,
            accuracy: LocationAccuracy.best,
          )
        ).listen((pos){
          debugPrint('$pos');
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
        position = await Geolocator.getCurrentPosition();
        debugPrint('$position');
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

  late GoogleMapController googleMapController;
  Position? position;

  @override
  void initState() {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            googleMap(context),
            const SizedBox(height: 16),
            Text("My current location is:\n$position"),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: const Text("Get Current Location"),
            ),
          ],
        ),
      ),
    );
  }

  Widget googleMap(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height - 200,
          child: GoogleMap(
            onMapCreated: (controller) {
              getCurrentLocation();
              googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              zoom: 15,
              target: LatLng(
                position?.latitude ?? 0,
                position?.longitude ?? 0,
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
                  position?.latitude ?? 0,
                  position?.longitude ?? 0,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
                draggable: true,
                onDragStart: (LatLng? latLang) {
                  debugPrint('$latLang');
                },
                onDragEnd: (LatLng? latLang) {
                  debugPrint('$latLang');
                },
              ),
            },
            circles: <Circle>{
              Circle(
                  circleId: const CircleId('default-circle'),
                  center: const LatLng(23.91408575189919, 90.22750832140446),
                  fillColor: Colors.red.withOpacity(0.3),
                  radius: 500,
                  strokeWidth: 1,
                  strokeColor: Colors.transparent,
                  onTap: () {
                    debugPrint("Enter corona zone");
                  }),
              Circle(
                  circleId: const CircleId('default-circle-2'),
                  center: const LatLng(23.904706078389868, 90.22387526929379),
                  fillColor: Colors.blue.withOpacity(0.3),
                  radius: 800,
                  strokeWidth: 1,
                  strokeColor: Colors.transparent,
                  onTap: () {
                    debugPrint("Enter corona zone");
                  }),
            },
            polylines: <Polyline>{
              const Polyline(
                polylineId: PolylineId('random'),
                color: Colors.amber,
                width: 4,
                jointType: JointType.round,
                points: <LatLng>[
                  LatLng(23.89220604322025, 90.20004618912935),
                  LatLng(23.880250809925563, 90.19492518156767),
                  LatLng(23.872402269187706, 90.19329439848661),
                  LatLng(23.878602655847, 90.20771395415068),
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
          ),
        ),
        Positioned(
          top: 480,
          left: 150,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      zoom: 15,
                      target: LatLng(
                        position?.latitude ?? 0,
                        position?.longitude ?? 0,
                      ),
                    ),
                  ),
                );
              });
            },
            backgroundColor: Colors.lightGreen,
            child: const Icon(Icons.location_history),
          ),
        ),
      ],
    );
  }
}
