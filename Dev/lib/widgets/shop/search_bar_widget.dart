import 'package:flutter/material.dart';
import 'package:petbook/screen/shop/results.dart';

import '../../screen/shop/product_search.dart';
import '../../utils/utils.dart';

class SearchBar extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchBar({
    Key? key,
    required this.isReadOnly,
    required this.hasBackButton,
  })  : preferredSize = const Size.fromHeight(100),
        super(key: key);

  @override
  final Size preferredSize;

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();
    return Container(
      height: 140,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasBackButton
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back))
                  : Container(),
              SizedBox(
                width: screenSize.width * 0.80,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    onSubmitted: (String query) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsScreen(query: query),
                        ),
                      );
                    },
                    readOnly: isReadOnly,
                    onTap: () {
                      if (isReadOnly) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProductSearchScreen()));
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Search Product",
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
