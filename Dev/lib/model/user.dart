import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String fullname;
  final String address;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.fullname,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'photoUrl': photoUrl,
        'email': email,
        'fullname': fullname,
        'address': address,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      fullname: snapshot['fullname'],
      address: snapshot['address'],
    );
  }
}
