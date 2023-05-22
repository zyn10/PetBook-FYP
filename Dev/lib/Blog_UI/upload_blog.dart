import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbook/Blog_UI/blog_page.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:petbook/utils/utils.dart';

class BlogUpload extends StatefulWidget {
  const BlogUpload({Key? key}) : super(key: key);

  @override
  State<BlogUpload> createState() => _BlogUploadState();
}

class _BlogUploadState extends State<BlogUpload> {
  bool _isloading = false;
  Uint8List? _image;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<void> push() async {
    setState(() {
      _isloading = true;
    });
    String output = await FireStoreMethods().uploadBlog(
        title: _titleController.text,
        description: _descController.text,
        image: _image);
    setState(() {
      _isloading = false;
    });
    if (output != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(context, output);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BlogPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Add Blog",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const BlogPage(),
              ));
            }),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Form(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _image != null
                        ? Image.memory(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 50,
                                color: Colors.grey,
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Tap to add cover photo fot blog',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.title_outlined),
                      hintText: "Title",
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title';
                      }
                      if (value.length < 3 || value.length > 30) {
                        return 'Title should be between 3 to 30 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.title_outlined),
                      hintText: "Description",
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Description';
                      }
                      if (value.length < 3 || value.length > 30) {
                        return 'Title should be between 3 to 30 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: push,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(350, 50)),
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Add Blog'),
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
