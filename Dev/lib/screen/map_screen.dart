import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      address: json['formatted_address'],
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> markers = {};

  Future<void> _searchPlaces(String query) async {
    const apiKey =
        "AIzaSyCuDpe2UWZiYiaZ5cd8qeNE0mADij_CUQs"; // Replace with your API key
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey'),
    );
    final data = json.decode(response.body);
    final results = data['results'] as List;
    final places = results.map((place) => Place.fromJson(place)).toList();
    setState(() {
      markers = places
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
    _searchPlaces('petshops in faisalabd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: Title("Locate near by pet shops"),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(31.418715, 73.079109),
          zoom: 12,
        ),
        markers: markers,
      ),
    );
  }
}
