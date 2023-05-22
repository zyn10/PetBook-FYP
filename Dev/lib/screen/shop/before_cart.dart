import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petbook/model/name_address_model.dart';
import 'package:petbook/model/order_request.dart';
import 'package:petbook/model/product_model.dart';
import 'package:petbook/providers/json_details.dart';
import 'package:petbook/screen/shop/sell_screen.dart';
import 'package:petbook/utils/utils.dart';
import 'package:petbook/widgets/shop/custom_main_button.dart';
import 'package:petbook/widgets/shop/products_show.dart';
import 'package:petbook/widgets/shop/single_product.dart';
import 'package:provider/provider.dart';

class BeforeCart extends StatefulWidget {
  const BeforeCart({Key? key}) : super(key: key);

  @override
  State<BeforeCart> createState() => _BeforeCartState();
}

class _BeforeCartState extends State<BeforeCart> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('PetBook'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellScreen()));
                  },
                  child: const Text(
                    "Sell",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orders")
                      //.orderBy("datePublished", descending: true)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      List<Widget> children = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModel model = ProductModel.getModelFromJson(
                            json: snapshot.data!.docs[i].data());
                        children.add(SingleProduct(productModel: model));
                      }
                      return ProductShowList(
                          title: "Your Prev orders", children: children);
                    }
                  }),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("orderRequests")
                          // .orderBy("datePublished", descending: true)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                OrderRequestModel model =
                                    OrderRequestModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return ListTile(
                                  title: Text(
                                    "Order: ${model.orderName}",
                                    style: const TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle:
                                      Text("Address: ${model.buyersAddress}"),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("orderRequests")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                      icon: const Icon(Icons.check)),
                                );
                              });
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: 80 / 2,
      decoration: const BoxDecoration(
        color: Colors.orange,
      ),
      child: Container(
        height: 80 / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.000000000001)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(
                      text: userDetailsModel.name,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
