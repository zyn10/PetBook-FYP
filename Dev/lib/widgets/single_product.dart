import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String url;
  const SingleProduct({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ProductScreen(productModel: productModel)));
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(url),
          ),
        ),
      ),
    );
  }
}
