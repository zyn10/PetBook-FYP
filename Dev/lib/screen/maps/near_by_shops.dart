import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Place {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String address;

  Place({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['place_id'],
      name: json['name'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      address: json['vicinity'],
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //GoogleMapController? _controller;
  Set<Marker> _markers = {};
  late Position _currentPosition;

  void _onMapCreated(GoogleMapController controller) {
    //_controller = controller;
  }

  Future<void> _getCurrentLocation() async {
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _searchPlaces(String query) async {
    const apiKey = "AIzaSyCuDpe2UWZiYiaZ5cd8qeNE0mADij_CUQs";
    final location =
        "${_currentPosition.latitude},${_currentPosition.longitude}";
    const radius = "50000";
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$location&radius=$radius&type=$query&key=$apiKey";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final results = data['results'] as List;
    final places = results.map((place) => Place.fromJson(place)).toList();
    setState(() {
      _markers = places
          .map((place) => Marker(
                markerId: MarkerId(place.id),
                position: LatLng(place.lat, place.lng),
                infoWindow: InfoWindow(
                  title: place.name,
                  snippet: place.address,
                ),
              ))
          .toSet();
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((_) {
      _searchPlaces('pet_store');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: unnecessary_null_comparison
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                ),
                zoom: 7,
              ),
              onMapCreated: _onMapCreated,
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
            ),
    );
  }
}
