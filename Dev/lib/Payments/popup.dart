import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:petbook/screen/shop/cart_screen.dart';
import 'package:petbook/utils/utils.dart';

class PaymentPop extends StatefulWidget {
  // Declare the useramount variable

  const PaymentPop({super.key, required String useramount});
  @override
  State<PaymentPop> createState() => _PaymentPopState();
}

class _PaymentPopState extends State<PaymentPop> {
  Map<String, dynamic>? paymentIntent;
  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      // Set the Stripe publishable key
      Stripe.publishableKey =
          "pk_test_51N7nWLAVXUi2V7LVC1B7rwj6oz1sWkOGY1hoTv3N4wUQ3ct4b33YaZrKziwCagv2vksIjDjrC97fLIrAjPyRaft200xAIkbm0s";

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!["client_secret"],
        style: ThemeMode.light,
        merchantDisplayName: "Sabir",
        googlePay: gpay,
      ));

      displayPaymentSheet();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      showSnackBar(navigatorKey.currentContext!, "Done");

      // Navigate to the other screen
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    } catch (e) {
      showSnackBar(navigatorKey.currentContext!, "Failed");
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "368",
        "currency": "USD",
      };

      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51N7nWLAVXUi2V7LVYiZfOqmyQDoZjp9rRORFnpRWpSjjLzmJug19OfolhgagPpZmiu1oaK7LDschnILkT9Goetys00phw8zG5P",
            "Content-Type": "application/x-www-form-urlencoded",
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Example"),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                makePayment();
              },
              child: const Text("Pay Me!"))),
    );
  }
}
