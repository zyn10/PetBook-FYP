// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:petbook/Layout/app_style.dart';
// import 'package:petbook/Layout/size_config.dart';
// import 'package:petbook/model/product_model.dart';
// import 'package:petbook/providers/user_provider.dart';
// import 'package:petbook/widgets/shop/cart_item.dart';
// import 'package:petbook/widgets/shop/search_bar_widget.dart';
// import 'package:provider/provider.dart';

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   @override
//   Widget build(BuildContext context) {
//     final UserProvider userProvider = Provider.of<UserProvider>(context);
//     userProvider.getUser.uid;

//     SizeConfig().init(context);

//     return Scaffold(
//       appBar: SearchBar(
//         hasBackButton: true,
//         isReadOnly: true,
//       ),
//       backgroundColor: kWhite,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           debugPrint('Add to cart button pressed!');
//         },
//         label: Text(
//           'Add to cart',
//           style: kSourceSansProSemibold.copyWith(
//             color: kBoxShadowColor,
//             fontSize: SizeConfig.blockSizeHorizontal! * 4,
//           ),
//         ),
//         icon: SvgPicture.asset(
//           'assets/add_to_cart_icon.svg',
//         ),
//         backgroundColor: kGrey,
//         extendedPadding: const EdgeInsets.symmetric(
//           vertical: 18,
//           horizontal: kPaddingHorizontal,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: SizeConfig.blockSizeVertical! * 50,
//               child: Stack(
//                 children: [
//                   Image.asset(
//                     'assets/dog_marly_cover.png',
//                     height: SizeConfig.blockSizeVertical! * 60,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: 40,
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(42),
//                           topRight: Radius.circular(42),
//                         ),
//                         color: kWhite,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         top: SizeConfig.blockSizeVertical! * 8,
//                         left: SizeConfig.blockSizeHorizontal! * 8,
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           debugPrint('Tapped');
//                         },
//                         child: SvgPicture.asset(
//                           'assets/arrow_left_icon.svg',
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: kPaddingHorizontal,
//               ),
//               transform: Matrix4.translationValues(0, -12, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "${userProvider.getUser.fullname} ",
//                         style: kSourceSansProBold.copyWith(
//                           fontSize: SizeConfig.blockSizeHorizontal! * 6,
//                           color: kGrey,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 2,
//                       ),
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/pin_point_icon.svg',
//                           ),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             'Pakistan',
//                             style: kSourceSansProregular.copyWith(
//                               fontSize: SizeConfig.blockSizeHorizontal! * 4,
//                               color: kLighterGrey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       debugPrint('Favorite Button Tapped');
//                     },
//                     child: SvgPicture.asset(
//                       'assets/favorite_icon.svg',
//                       width: 30,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: kPaddingHorizontal,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: kPaddingHorizontal,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: kLighterOrange,
//                     ),
//                     width: SizeConfig.blockSizeHorizontal! * 50,
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {},
//                           child: Text(
//                             'Proceed to buy (n) items',
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                             style: kSourceSansProBold.copyWith(
//                               fontSize: SizeConfig.blockSizeHorizontal! * 4,
//                               color: kDarkOrange,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: kLighterOrange,
//                     ),
//                     width: SizeConfig.blockSizeHorizontal! * 25,
//                     child: Column(
//                       children: [
//                         Text(
//                           '6KG',
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           style: kSourceSansProBold.copyWith(
//                             fontSize: SizeConfig.blockSizeHorizontal! * 4,
//                             color: kDarkOrange,
//                           ),
//                         ),
//                         Text(
//                           'Weight',
//                           style: kSourceSansProregular.copyWith(
//                             fontSize: SizeConfig.blockSizeHorizontal! * 3,
//                             color: kLighterGrey,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: kPaddingHorizontal,
//             ),
//             const Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Order Requests",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const ScrollPhysics(),
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 return CartItem(
//                   product: ProductModel(
//                     url:
//                         'https://www.ccspca.com/wp-content/uploads/2016/01/Papu-30338335.png',
//                     productName: 'rick',
//                     cost: 500,
//                     discount: 0,
//                     uid: 'eeeee',
//                     sellerName: 'dada',
//                     sellerUid: 'ssss',
//                     rating: 1,
//                     noOfRating: 1,
//                   ),
//                 );
//               },
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
//               child: Text(
//                 'About me',
//                 style: kSourceSansProregular.copyWith(
//                   color: kLighterGrey,
//                   fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 6,
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
//               child: Text(
//                 'Remember this sweet face? Several years ago Charlie came into our care when their person died. These two easy-going Lhasa Apso mixes quickly to settle into foster care. Living with kids, cats, and other dogs, they were the perfect guests, and once their vetting and evaluation was done this bonded pair found their home with a kind couple.\n\nRemember this sweet face? Several years ago Charlie came into our care when their person died. These two easy-going Lhasa Apso mixes quickly to settle into foster care. Living with kids, cats, and other dogs, they were the perfect guests, and once their vetting and evaluation was done this bonded pair found their home with a kind couple.\n\nRemember this sweet face? Several years ago Charlie came into our care when their person died. These two easy-going Lhasa Apso mixes quickly to settle into foster care. Living with kids, cats, and other dogs, they were the perfect guests, and once their vetting and evaluation was done this bonded pair found their home with a kind couple.',
//                 style: kSourceSansProSemibold.copyWith(
//                   color: kGrey,
//                   fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 60,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
