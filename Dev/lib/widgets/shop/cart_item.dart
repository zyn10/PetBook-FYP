import 'package:flutter/material.dart';
import 'package:petbook/model/product_model.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:petbook/screen/shop/product_screen.dart';
import 'package:petbook/widgets/shop/custom_rounded_button.dart';
import 'package:petbook/widgets/shop/product_information.dart';
import '../../utils/utils.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;
  const CartItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      height: screenSize.height / 3,
      width: screenSize.width / 2,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductScreen(productModel: product)),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenSize.width / 2,
                  child: Align(
                    child: Center(
                      child: Image.network(product.url),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ProductInformationWidget(
                  productName: product.productName,
                  cost: product.cost,
                  sellerName: product.sellerName,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CustomSimpleRoundedButton(
                        onPressed: () async {
                          await FireStoreMethods().addProductToCart(
                            productModel: ProductModel(
                                url: product.url,
                                productName: product.productName,
                                cost: product.cost,
                                discount: product.discount,
                                uid: getUid(),
                                sellerName: product.sellerName,
                                sellerUid: product.sellerUid,
                                rating: product.rating,
                                noOfRating: product.noOfRating),
                          );
                        },
                        text: "Add this product one more"),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomSimpleRoundedButton(
                        onPressed: () async {
                          FireStoreMethods()
                              .deleteProductFromCart(uid: product.uid);
                        },
                        text: "Delete"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
