import 'package:flutter/material.dart';
import 'package:petbook/Layout/details.dart';
import 'package:petbook/Layout/shop_layout.dart';
import 'package:petbook/screen/Post/add_post_screen.dart';
import 'package:petbook/screen/shop/accounts.dart';
import 'package:petbook/screen/maps/map_screen.dart';
import 'package:petbook/screen/shop/shop.dart';
import '../screen/Post/feed_screen.dart';
import '../screen/search_screen.dart';

const webScreenSize = 600;
const homeScreenItems = [
  FeedScreen(),
  MapScreen(),
  //Text("Blogs Coming Soon"),
  PetShop(),
  AddPostScreen(),
  SearchScreen(),
  Shop(),
  //Details(),
  Account(),
];
