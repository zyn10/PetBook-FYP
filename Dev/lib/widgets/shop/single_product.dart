import 'package:flutter/material.dart';
import 'package:petbook/model/product_model.dart';
import 'package:petbook/screen/shop/product_screen.dart';

class SingleProduct extends StatelessWidget {
  final ProductModel productModel;
  const SingleProduct({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: productModel),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(productModel.url),
          ),
        ),
      ),
    );
  }
}
