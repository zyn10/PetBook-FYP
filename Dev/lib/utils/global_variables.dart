import 'package:petbook/Alerts/receive_alerts.dart';
import 'package:petbook/screen/Post/add_post_screen.dart';
import 'package:petbook/screen/Post/feed_screen.dart';
import 'package:petbook/screen/shop/accounts.dart';
import 'package:petbook/screen/shop/shop.dart';
import 'package:petbook/stack.dart';
import '../screen/search_users.dart';

const webScreenSize = 600;
const homeScreenItems = [
  FeedScreen(),
  Shop(),
  SearchScreen(),
  AddPostScreen(),
  AlertScreen(),
  Account(),
  StackScreen(),
];
