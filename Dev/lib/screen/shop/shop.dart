import 'package:flutter/material.dart';
import 'package:petbook/providers/user_provider.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:petbook/widgets/loading.dart';
import 'package:petbook/widgets/shop/categories.dart';
import 'package:petbook/widgets/shop/products_show.dart';
import 'package:petbook/widgets/shop/search_bar.dart';
import 'package:petbook/widgets/shop/user_details.dart';
import 'package:provider/provider.dart';
import '../../Layout/app_style.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  ScrollController controller = ScrollController();
  double offset = 10;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
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

  void getData() async {
    List<Widget> temp70 = await FireStoreMethods().getProductsFromDiscount(70);
    List<Widget> temp60 = await FireStoreMethods().getProductsFromDiscount(60);
    List<Widget> temp50 = await FireStoreMethods().getProductsFromDiscount(50);
    List<Widget> temp0 = await FireStoreMethods().getProductsFromDiscount(0);
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.getUser!.uid;

    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 40,
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                'assets/welcome_message.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 50,
                              top: 0,
                              bottom: 0,
                              right: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Text(
                                        'Hello',
                                        style: kSourceSansProLight.copyWith(
                                          fontSize: 18,
                                          color: kBlack,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${userProvider.getUser!.fullname} ",
                                        style: kSourceSansProMedium.copyWith(
                                          fontSize: 18,
                                          color: kBlack,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '👋',
                                        style: kSourceSansProMedium.copyWith(
                                          fontSize: 16,
                                          color: kBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, left: 100, right: 35),
                                    child: Text(
                                      'Ready for an amazing and lucky experience 🐈 🐕',
                                      style: kSourceSansProregular.copyWith(
                                        fontSize: 16,
                                        color: kBlack,
                                      ),
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

                      //const BannerAd(),
                      ProductShowList(
                          title: "Upto 70% Off", children: discount70!),
                      ProductShowList(
                          title: "Upto 60% Off", children: discount60!),
                      ProductShowList(
                          title: "Upto 50% Off", children: discount50!),
                      ProductShowList(title: "Explore", children: discount0!),
                    ],
                  ),
                ),
                UserDetailsBar(
                  offset: offset,
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
