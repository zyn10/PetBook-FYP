import 'package:flutter/material.dart';
import 'package:petbook/resources/auth_methods.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
User? get getUser {
  if (_user != null) {
    return _user;
  } else {
    // Handle the case where _user is null
    return null;
  }
}
  //User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
