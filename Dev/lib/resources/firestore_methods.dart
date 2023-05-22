import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:petbook/model/blog.dart';
import 'package:petbook/model/order_request.dart';
import 'package:petbook/model/photographer.dart';
import 'package:petbook/model/post.dart';
import 'package:petbook/model/product_model.dart';
import 'package:petbook/model/review_model.dart';
import 'package:petbook/model/name_address_model.dart';
import 'package:petbook/resources/storage_methods.dart';
import 'package:petbook/widgets/shop/single_product.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//getname and adress
  Future getNameAndAddress() async {
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );
    return userModel;
  }

  Future<String> uploadPhotographer(
      String petName, String petBreed, String event, String priceQuote) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photographerId =
          const Uuid().v1(); // creates unique id based on time
      Photographer grapher = Photographer(
        petName: petName,
        uid: photographerId,
        event: event,
        priceQuote: priceQuote,
        datePublished: DateTime.now(),
      );
      _firestore
          .collection('photographer')
          .doc(photographerId)
          .set(grapher.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//like post

//upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//like post
  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = const Uuid().v1();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel product = ProductModel(
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);

        await _firestore.collection("products").doc(uid).set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadToask = storageRef.putData(image);
    TaskSnapshot task = await uploadToask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await _firestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(SingleProduct(productModel: model));
    }
    return children;
  }

  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await _firestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future addProductToCart({required ProductModel productModel}) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders(
      {required ProductModel model,
      required UserDetailsModel userDetails}) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetails);
  }

  Future sendOrderRequest(
      {required ProductModel model,
      required UserDetailsModel userDetails}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: model.productName, buyersAddress: userDetails.address);
    await _firestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("orderRequests")
        .add(orderRequestModel.getJson());
  }

  Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await _firestore.collection("products").doc(productUid).get();
    ProductModel model =
        ProductModel.getModelFromJson(json: (snapshot.data() as dynamic));
    int currentRating = model.rating;
    int newRating = (currentRating + reviewModel.rating) ~/ 2;
    await _firestore
        .collection("products")
        .doc(productUid)
        .update({"rating": newRating});
  }

  Future<String> uploadBlog({
    required String title,
    required String description,
    required Uint8List? image,
  }) async {
    String output = "Something went wrong";

    if (image != null && title != "" && description != "") {
      try {
        String blogid = const Uuid().v1();
        String url = await uploadImageToDatabase(image: image, uid: blogid);

        Blog blogUp = Blog(
          blogid: blogid,
          title: title,
          description: description,
          imageUrl: url,
          datePublished: DateTime.now(),
        );

        await _firestore.collection("blogs").doc(blogid).set(blogUp.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }
}
