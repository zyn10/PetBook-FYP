import 'package:flutter/material.dart';
import '../../Layout/app_style.dart';
import '../../Layout/size_config.dart';
import '../../utils/utils.dart';

class ProductShowList extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductShowList({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();
    double height = screenSize.height / 4;
    double titleHeight = 45;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: kSourceSansProBold.copyWith(
                    fontSize: 16,
                    //SizeConfig.blockSizeHorizontal! * 6,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '🛒',
                  style: kSourceSansProBold.copyWith(
                    fontSize: SizeConfig.blockSizeHorizontal! * 3,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    "Show more",
                    style: TextStyle(color: Colors.orange),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 36),
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          )
        ],
      ),
    );
  }
}
