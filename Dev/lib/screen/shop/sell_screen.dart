import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petbook/providers/json_details.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:petbook/screen/shop/shop.dart';
import 'package:petbook/utils/utils.dart';
import 'package:petbook/widgets/loading.dart';
import 'package:petbook/widgets/shop/custom_main_button.dart';
import 'package:petbook/widgets/shop/text_custom.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];
  //keysofdiscoutn[selected -1]

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product Selling'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: !isLoading
          ? SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              image == null
                                  ? CircleAvatar(
                                      radius: 64,
                                      child: Image.network(
                                        "https://cdn-icons-png.flaticon.com/512/3082/3082745.png",
                                        height: screenSize.height / 10,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 64,
                                      child: Image.memory(
                                        image!,
                                        height: screenSize.height / 10,
                                      ),
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                    onPressed: () async {
                                      Uint8List? temp = await productImage();
                                      if (temp != null) {
                                        setState(() {
                                          image = temp;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          height: screenSize.height * 0.55,
                          width: screenSize.width * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldWidget(
                                  title: "Name",
                                  controller: nameController,
                                  obscureText: false,
                                  hintText: "Enter the name of the item"),
                              TextFieldWidget(
                                  title: "Cost",
                                  controller: costController,
                                  obscureText: false,
                                  hintText: "Enter the cost of the item"),
                              const Text(
                                "Discount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              ListTile(
                                title: const Text("None"),
                                leading: Radio(
                                  value: 1,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text("70%"),
                                leading: Radio(
                                  value: 2,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text("60%"),
                                leading: Radio(
                                  value: 3,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text("50%"),
                                leading: Radio(
                                  value: 4,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CustomMainButton(
                              color: Colors.orange,
                              isLoading: isLoading,
                              onPressed: () async {
                                String output = await FireStoreMethods()
                                    .uploadProductToDatabase(
                                        image: image,
                                        productName: nameController.text,
                                        rawCost: costController.text,
                                        discount: keysForDiscount[selected - 1],
                                        sellerName:
                                            Provider.of<UserDetailsProvider>(
                                                    context,
                                                    listen: false)
                                                .userDetails
                                                .name,
                                        sellerUid: FirebaseAuth
                                            .instance.currentUser!.uid);
                                if (output == "success") {
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context, "Posted Product");
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context, output);
                                }
                              },
                              child: const Text(
                                "Sell",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            CustomMainButton(
                              color: Colors.grey[300]!,
                              isLoading: false,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Shop(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Back",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const LoadingWidget(),
    ));
  }
}
