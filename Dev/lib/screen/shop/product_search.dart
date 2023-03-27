import 'package:flutter/material.dart';
import 'package:petbook/widgets/shop/search_bar_widget.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(isReadOnly: false, hasBackButton: true),
    );
  }
}
