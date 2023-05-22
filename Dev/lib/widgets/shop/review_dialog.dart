import 'package:flutter/material.dart';
import 'package:petbook/model/review_model.dart';
import 'package:petbook/providers/user_provider.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key, required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.getUser!.uid;

    return RatingDialog(
      title: const Text(
        'Type a review for this product!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?

      submitButtonText: 'Send',
      commentHint: 'Type here',

      onSubmitted: (RatingDialogResponse res) async {
        FireStoreMethods().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName: userProvider.getUser!.fullname,
                description: res.comment,
                rating: res.rating.toInt()));
      },
    );
  }
}
