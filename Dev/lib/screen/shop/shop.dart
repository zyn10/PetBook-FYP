import 'package:flutter/material.dart';
import 'package:petbook/providers/user_provider.dart';
import 'package:petbook/widgets/shop/ad.dart';
import 'package:petbook/widgets/shop/categories.dart';
import 'package:petbook/widgets/shop/products_show.dart';
import 'package:petbook/widgets/shop/search_bar_widget.dart';
import 'package:petbook/widgets/shop/single_product.dart';
import 'package:provider/provider.dart';

import '../../Layout/app_style.dart';
import '../../Layout/size_config.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  ScrollController controller = ScrollController();
  double offset = 10;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.getUser.uid;

    return Scaffold(
      appBar: SearchBar(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/welcome_message.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: SizeConfig.blockSizeHorizontal! * 38,
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(),
                            Text(
                              'Hello',
                              style: kSourceSansProLight.copyWith(
                                fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
                                color: kBlack,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${userProvider.getUser.fullname} ",
                              style: kSourceSansProMedium.copyWith(
                                fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
                                color: kBlack,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '👋',
                              style: kSourceSansProMedium.copyWith(
                                fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                                color: kBlack,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Ready for an amazing and lucky experience 🐈 🐕',
                          style: kSourceSansProregular.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                            color: kBlack,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CategoriesHorizontal(),
            const BannerAd(),
            const ProductShowList(
              title: "Dogs",
              children: [
                SingleProduct(
                  url:
                      "https://i2-prod.irishmirror.ie/incoming/article26185096.ece/ALTERNATES/s615/0_I220209_151028_100570909oTextTRMRMMGLPICT000255932810o.jpg",
                ),
                SingleProduct(
                  url:
                      "https://i2-prod.irishmirror.ie/incoming/article26185096.ece/ALTERNATES/s615/0_I220209_151028_100570909oTextTRMRMMGLPICT000255932810o.jpg",
                ),
                SingleProduct(
                  url:
                      "https://i2-prod.irishmirror.ie/incoming/article26185096.ece/ALTERNATES/s615/0_I220209_151028_100570909oTextTRMRMMGLPICT000255932810o.jpg",
                ),
                SingleProduct(
                  url:
                      "https://i2-prod.irishmirror.ie/incoming/article26185096.ece/ALTERNATES/s615/0_I220209_151028_100570909oTextTRMRMMGLPICT000255932810o.jpg",
                ),
                SingleProduct(
                  url:
                      "https://i2-prod.irishmirror.ie/incoming/article26185096.ece/ALTERNATES/s615/0_I220209_151028_100570909oTextTRMRMMGLPICT000255932810o.jpg",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
