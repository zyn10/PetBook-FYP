import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petbook/providers/user_provider.dart';
import 'package:petbook/resources/firestore_methods.dart';
import 'package:petbook/screen/Post/comment_screen.dart';
import 'package:petbook/widgets/Post/like_animation.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../utils/utils.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLength = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLength = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
              .copyWith(right: 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  widget.snap["profImage"],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                    onTap: () async {
                                      FireStoreMethods()
                                          .deletePost(widget.snap['postId']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert))
            ],
          ),
        ),

        //Image Section
        GestureDetector(
          onDoubleTap: () async {
            await FireStoreMethods().likePost(
              widget.snap['postId'],
              user!.uid,
              widget.snap['likes'],
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap["postUrl"],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  microseconds: 200,
                ),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              )
            ],
          ),
        ),

        //Like Comment Section
        Row(
          children: [
            LikeAnimation(
              // isAnimating: widget.snap['likes'].contains(user!.uid),
              isAnimating: widget.snap['likes']?.contains(user?.uid) ?? false,
              smallLike: true,
              child: IconButton(
                onPressed: () async {
                  await FireStoreMethods().likePost(
                    widget.snap['postId'],
                    user!.uid,
                    widget.snap['likes'],
                  );
                },
                // icon: widget.snap['likes'].contains(user!.uid)
                icon: widget.snap['likes'].contains(user?.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.orange,
                      )
                    : const Icon(Icons.favorite_border),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ))),
              icon: const Icon(
                Icons.comment_outlined,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        //Description and number of comments

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                child: Text(
                  '${widget.snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: widget.snap['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ${widget.snap['description']} ',
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'View all $commentLength comments',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMd().format(
                    widget.snap['datePublished'].toDate(),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
