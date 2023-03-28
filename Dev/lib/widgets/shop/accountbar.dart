import 'package:flutter/material.dart';
import 'package:petbook/Layout/app_style.dart';


class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kPaddingHorizontal),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10),
            child: Image.asset(
              "assets/welcome_message.png",
              // height: 300,
              // width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
