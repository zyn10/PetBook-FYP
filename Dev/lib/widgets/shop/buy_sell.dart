import 'package:flutter/material.dart';
import 'package:petbook/Layout/app_style.dart';
import 'package:petbook/utils/constants.dart';
import 'package:petbook/widgets/shop/products_show.dart';

class BuySell extends StatelessWidget {
  const BuySell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // navigate back to the previous screen
          },
        ),
        backgroundColor: kWhite,
        title: const Text("Petshop"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: kBackground,
                ),
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.login,
                      color: kGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: kGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.sell_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Sell',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ProductShowList(title: "Your Orders", children: testChildren),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order Requests",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: const Text("Order: Black Shoes",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text("Somewhere on earth"),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
