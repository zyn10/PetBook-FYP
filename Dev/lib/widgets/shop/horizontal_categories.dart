import 'package:flutter/material.dart';
import 'package:petbook/utils/constants.dart';

class CategoriesHorizontal extends StatelessWidget {
  const CategoriesHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    categoryLogos[index],
                  ),
                ),
                Text(categoriesList[index])
              ],
            );
          }),
    );
  }
}
