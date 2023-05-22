import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petbook/model/pet.dart';
import 'package:petbook/model/service.dart';

class HireRequest {
  final String id;
  final Pet pet;
  final Service service;
  final String userId;
  final Timestamp timestamp;
  final String status;

  HireRequest({
    required this.id,
    required this.pet,
    required this.service,
    required this.userId,
    required this.timestamp,
    required this.status,
  });

  factory HireRequest.fromJson(Map<String, dynamic> json) {
    return HireRequest(
      id: json['id'] ?? '',
      pet: Pet.fromJson(json['pet'] ?? {}),
      service: Service.fromJson(json['service'] ?? {}),
      userId: json['userId'] ?? '',
      timestamp: json['timestamp'],
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet': pet.toJson(),
      'service': service.toJson(),
      'userId': userId,
      'timestamp': timestamp,
      'status': status,
    };
  }
}
