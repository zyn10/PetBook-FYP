import 'package:flutter/material.dart';

import '../screen/search_screen.dart';
import '../utils/utils.dart';

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
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        color: Colors.orange,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            hasBackButton
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))
                : Container(),
            SizedBox(
              width: screenSize.width * 0.9,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  // onSubmitted: (String query) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ResultsScreen(query: query),
                  //     ),
                  //   );
                  // },
                  readOnly: isReadOnly,
                  onTap: () {
                    if (isReadOnly) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Search for something ",
                    fillColor: Colors.white,
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
    );
  }
}
