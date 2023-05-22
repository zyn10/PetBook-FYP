import 'package:cloud_firestore/cloud_firestore.dart';

class Photographer {
  final String petName;
  final String uid;
  final String event;
  final String priceQuote;
  final DateTime datePublished;

  const Photographer({
    required this.petName,
    required this.uid,
    required this.event,
    required this.priceQuote,
    required this.datePublished,
  });

  static Photographer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Photographer(
      petName: snapshot["petName"],
      uid: snapshot["photographerId"],
      event: snapshot["event"],
      priceQuote: snapshot["priceQuote"],
      datePublished: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        "petName": petName,
        "uid": uid,
        "event": event,
        "datePublished": datePublished,
        'priceQuote': priceQuote,
      };
}
