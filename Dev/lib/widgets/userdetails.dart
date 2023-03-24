import 'package:flutter/material.dart';
import 'package:petbook/model/user.dart';
import 'package:petbook/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserDetailsBar extends StatelessWidget {
  final snap;

  const UserDetailsBar({
    Key? key,
    this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();

    return Positioned(
      //top: -offset / 3,
      child: Container(
        height: 100 / 2,
        width: screenSize.width,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  snap.data()['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
