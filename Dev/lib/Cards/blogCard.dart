import 'package:flutter/material.dart';

class BlogCard extends StatefulWidget {
  final snap;

  const BlogCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) {
              //       return const BlogDescription(
              //         title: 'The Bond with Pets',
              //         imagePath: 'images/three.jpg',
              //       );
              //     },
              //   ),
              // );
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                    )
                  ]),
              child: Column(
                children: [
                  Image.asset('assets/three.jpg'),
                  const ListTile(
                    title: Text('The Bond with Pets'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 224, 222, 222),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  widget.snap["imageUrl"],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.snap["name"]}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 14,
                  ),
                  Text(
                    '${widget.snap["location"]}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 30),
                  const Icon(
                    Icons.calendar_month,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${widget.snap["date"]}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 30),
                  const Icon(
                    Icons.timer,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${widget.snap["time"]}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.snap["description"]}',
                style: const TextStyle(
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
