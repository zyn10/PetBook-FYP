import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petbook/Payments/popup.dart';
import 'package:petbook/model/product_model.dart';
import 'package:petbook/responsive/mobile_screen_layout.dart';
import 'package:petbook/widgets/shop/custom_main_button.dart';
import 'package:petbook/widgets/shop/user_details.dart';
import '../../widgets/shop/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double cost = 0.0; // Global variable to store the total cost

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetBook'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MobileScreenLayout(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 80 / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomMainButton(
                            color: Colors.orange,
                            isLoading: true,
                            onPressed: () {},
                            child: const Text("Loading"));
                      } else {
                        cost = 0.0; // Reset the cost to calculate again
                        for (var doc in snapshot.data!.docs) {
                          ProductModel model =
                              ProductModel.getModelFromJson(json: doc.data());
                          cost +=
                              model.cost; // Accumulate the cost of each item
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomMainButton(
                                color: Colors.orange,
                                isLoading: false,
                                onPressed: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPop(
                                          useramount: cost.toString(),
                                        ),
                                      ));
                                },
                                child: Text(
                                  "Proceed to buy (${snapshot.data!.docs.length}) items",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              CustomMainButton(
                                color: Colors.blue,
                                isLoading: false,
                                onPressed: () {
                                  // Handle the additional button press
                                  // You can add your desired functionality here
                                },
                                child: Text(
                                  "Total Price: \$${cost.toStringAsFixed(2)}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel model = ProductModel.getModelFromJson(
                                json: snapshot.data!.docs[index].data());
                            return CartItem(product: model);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
