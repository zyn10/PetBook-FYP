import 'package:flutter/material.dart';
import 'package:petbook/model/product_model.dart';
import 'package:petbook/widgets/shop/single_product.dart';

const List<String> categoriesList = [
  "Dogs",
  "Cats",
  "Toys",
  "Homes",
  "Food",
];

const List<String> categoryLogos = [
  "https://i2-prod.irishmirror.ie/incoming/article26185096.ece/ALTERNATES/s615/0_I220209_151028_100570909oTextTRMRMMGLPICT000255932810o.jpg",
  "https://static.vecteezy.com/system/resources/previews/002/410/747/original/cute-siamese-cat-on-yellow-background-free-photo.jpg",
  "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F47%2F2020%2F07%2F31%2Fvarious-pet-toys-00c3ec73.jpg",
  "https://static.onecms.io/wp-content/uploads/sites/47/2021/06/17/dog-in-diy-doghouse-2000.jpg",
  "https://beta-kiosk.icrowdnewswire.com/assets/source/users/kamal.negi/dog-food-1296x728-header.jpg",
];

const List<String> largeAds = [
  "https://i.pinimg.com/originals/13/1e/64/131e64995f0d0b636bccd9b5ce2ec2ee.jpg",
  "http://cdn.shopify.com/s/files/1/1862/1549/collections/banner-2_1200x1200.jpg",
  "https://cdn.shopify.com/s/files/1/0565/8021/0861/files/Frame_10297_1200x1200.jpg",
  "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F47%2F2020%2F08%2F06%2Fcat-not-eating-1133769382-2000.jpg",
];

const List<String> payment = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> payments = ["Easypaisa", "Sadapay", "Jazzcash", "Nayapay"];

List<String> keysOfRating = [
  "Very bad",
  "Poor",
  "Average",
  "Good",
  "Excellent"
];

List<Widget> testChildren = [
  SingleProduct(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "Rick Astley",
        cost: 9999999999999,
        discount: 0,
        uid: "eioejfbkn",
        sellerName: "Rick Seller",
        sellerUid: "983498ihjb",
        rating: 1,
        noOfRating: 1),
  ),
  SingleProduct(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "Rick Astley",
        cost: 9999999999999,
        discount: 0,
        uid: "eioejfbkn",
        sellerName: "Rick Seller",
        sellerUid: "983498ihjb",
        rating: 1,
        noOfRating: 1),
  ),
  SingleProduct(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "Rick Astley",
        cost: 9999999999999,
        discount: 0,
        uid: "eioejfbkn",
        sellerName: "Rick Seller",
        sellerUid: "983498ihjb",
        rating: 1,
        noOfRating: 1),
  ),
  SingleProduct(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "Rick Astley",
        cost: 9999999999999,
        discount: 0,
        uid: "eioejfbkn",
        sellerName: "Rick Seller",
        sellerUid: "983498ihjb",
        rating: 1,
        noOfRating: 1),
  ),
  SingleProduct(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "Rick Astley",
        cost: 9999999999999,
        discount: 0,
        uid: "eioejfbkn",
        sellerName: "Rick Seller",
        sellerUid: "983498ihjb",
        rating: 1,
        noOfRating: 1),
  )
];

List<String> dogs = [
  'dog_marly.png',
  'dog_cocoa.png',
  'dog_walt.png',
];

List<String> cats = [
  'cat_alyx.png',
  'cat_brook.png',
  'cat_marly.png',
];

List<String> dogsName = [
  'Marly',
  'Cocoa',
  'Walt',
];

List<String> catsName = [
  'Alyx',
  'Brook',
  'Marly',
];
