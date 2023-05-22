import 'package:flutter/material.dart';
import 'package:petbook/model/name_address_model.dart';
import 'package:petbook/resources/firestore_methods.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetails = await FireStoreMethods().getNameAndAddress();
    notifyListeners();
  }
}
