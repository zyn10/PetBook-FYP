import 'package:flutter/material.dart';
import 'package:petbook/Layout/app_style.dart';
import 'package:petbook/Layout/size_config.dart';
import 'package:petbook/model/productmodel.dart';
import 'package:petbook/providers/user_provider.dart';
import 'package:petbook/utils/utils.dart';
import 'package:petbook/widgets/shop/custom_square.dart';
import 'package:petbook/widgets/shop/product_information.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;
  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.getUser!.uid;

    Size screenSize = getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: getScreenSize().width / 2,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.network(product.url)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ProductInformationWidget(
                      productName: product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSquareButton(
                    onPressed: () {},
                    color: kLightGrey,
                    dimension: 50,
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomSquareButton(
                    onPressed: () {},
                    color: kLightGrey,
                    dimension: 70,
                    child: const Text('1'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomSquareButton(
                    onPressed: () {},
                    color: kLightGrey,
                    dimension: 50,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingHorizontal,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kLighterOrange,
                    ),
                    width: SizeConfig.blockSizeHorizontal! * 20,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Delete',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: kSourceSansProBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 3,
                              color: kDarkOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kLighterOrange,
                    ),
                    width: SizeConfig.blockSizeHorizontal! * 25,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Save for later',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: kSourceSansProBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 3,
                              color: kDarkOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
