import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:petbook/screen/services/service.dart';
import 'package:petbook/utils/utils.dart';

class HirePhotographerScreen extends StatefulWidget {
  const HirePhotographerScreen({
    super.key,
  });

  @override
  State<HirePhotographerScreen> createState() => _HirePhotographerScreenState();
}

class _HirePhotographerScreenState extends State<HirePhotographerScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _priceQuoteController = TextEditingController();

  @override
  void dispose() {
    _petNameController.dispose();
    _petBreedController.dispose();
    _eventController.dispose();
    _priceQuoteController.dispose();
    super.dispose();
  }

  Future<void> push() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String output = await FireStoreMethods().uploadPhotographer(
        _petNameController.text,
        _petBreedController.text,
        _eventController.text,
        _priceQuoteController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (output != 'success') {
        // ignore: use_build_context_synchronously
        showSnackBar(context, output);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ServiceScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Hire a Photographer",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ServiceScreen(),
            ));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _petNameController,
                decoration: const InputDecoration(labelText: 'Pet Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a pet name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _petBreedController,
                decoration: const InputDecoration(labelText: 'Pet Breed'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a pet breed';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _eventController,
                decoration: const InputDecoration(labelText: 'Event'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the event details';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceQuoteController,
                decoration: const InputDecoration(labelText: 'Price Quote'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price quote';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
// Handle form submission and data processing
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(450, 50),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
