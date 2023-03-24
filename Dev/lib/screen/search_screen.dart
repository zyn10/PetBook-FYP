import 'package:flutter/material.dart';
import 'package:petbook/widgets/search_bar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(isReadOnly: false, hasBackButton: true),
      body: const Text("zain"),
    );
  }
}
