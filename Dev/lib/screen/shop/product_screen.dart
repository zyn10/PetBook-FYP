import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petbook/model/product_model.dart';
import 'package:petbook/model/review_model.dart';
import 'package:petbook/providers/json_details.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:petbook/utils/utils.dart';
import 'package:petbook/widgets/shop/cost.dart';
import 'package:petbook/widgets/shop/custom_main_button.dart';
import 'package:petbook/widgets/shop/custom_rounded_button.dart';
import 'package:petbook/widgets/shop/ratings.dart';
import 'package:petbook/widgets/shop/review_dialog.dart';
import 'package:petbook/widgets/shop/review_widget.dart';
import 'package:petbook/widgets/shop/search_bar.dart';
import 'package:petbook/widgets/shop/user_details.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  //Expanded spaceThingy = Expanded(child: Container());
  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();

    return SafeArea(
      child: Scaffold(
        
        appBar: SearchBarWidget(isReadOnly: true, hasBackButton: true),
        body: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: screenSize.height,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          widget.productModel.sellerName,
                                          style: const TextStyle(
                                              color: Colors.orange,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Text(widget.productModel.productName),
                                    ],
                                  ),
                                  RatingStatWidget(
                                      rating: widget.productModel.rating),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                height: screenSize.height / 3,
                                constraints: BoxConstraints(
                                    maxHeight: screenSize.height / 3),
                                child: Image.network(widget.productModel.url),
                              ),
                            ),
                            CostWidget(
                                color: Colors.black,
                                cost: widget.productModel.cost),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomMainButton(
                                color: Colors.orange,
                                isLoading: false,
                                onPressed: () async {
                                  await FireStoreMethods().addProductToOrders(
                                      model: widget.productModel,
                                      userDetails:
                                          Provider.of<UserDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .userDetails);
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context, "Done");
                                },
                                child: const Text(
                                  "Buy Now",
                                  style: TextStyle(color: Colors.black),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomMainButton(
                                color: Colors.orange,
                                isLoading: false,
                                onPressed: () async {
                                  await FireStoreMethods().addProductToCart(
                                      productModel: widget.productModel);
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context, "Added to cart.");
                                },
                                child: const Text(
                                  "Add to cart",
                                  style: TextStyle(color: Colors.black),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomSimpleRoundedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ReviewDialog(
                                            productUid: widget.productModel.uid,
                                          ));
                                },
                                text: "Add a review for this product"),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: screenSize.height,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("products")
                                .doc(widget.productModel.uid)
                                .collection("reviews")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else {
                                return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      ReviewModel model =
                                          ReviewModel.getModelFromJson(
                                              json: snapshot.data!.docs[index]
                                                  .data());
                                      return ReviewWidget(review: model);
                                    });
                              }
                            },
                          ))
                    ],
                  ),
                ),
              ),
              const UserDetailsBar(
                offset: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
