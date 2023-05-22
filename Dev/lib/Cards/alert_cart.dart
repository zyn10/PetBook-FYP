import 'package:flutter/material.dart';

class AlertCard extends StatefulWidget {
  final snap;

  const AlertCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard> {
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.snap["title"]}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.date_range,
                    size: 14,
                  ),
                  Text(
                    '${widget.snap["date"]}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
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
