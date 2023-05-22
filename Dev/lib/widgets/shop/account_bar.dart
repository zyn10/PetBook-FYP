import 'package:flutter/material.dart';
import 'package:petbook/screen/shop/product_search.dart';
import 'package:petbook/utils/utils.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppBar({Key? key})
      : preferredSize = const Size.fromHeight(100),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 100,
        width: screenSize.width,
        decoration: const BoxDecoration(color: Colors.orange),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductSearchScreen()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductSearchScreen()));
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
